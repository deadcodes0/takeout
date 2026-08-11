const fs = require('fs');
const path = require('path');

const jsDir = 'd:\\Coding\\takeaway - copy\\nginx-1.20.2\\html\\sky\\js';
const dest = 'd:\\Coding\\takeaway - copy\\sky-admin-restored-src';
const mapFiles = ['app.d0aa4eb3.js.map','dashboard.630a609e.js.map','login.90288d75.js.map','shopTable.fe534d8f.js.map'];

// Collect ALL sources
const allSources = {};
mapFiles.forEach(f => {
  try {
    const map = JSON.parse(fs.readFileSync(path.join(jsDir, f), 'utf8'));
    map.sources.forEach((src, i) => {
      const content = map.sourcesContent?.[i];
      if (!content || content.trim().length === 0) return;
      const key = src.replace('webpack:///./', '');
      if (!allSources[key] || content.length > allSources[key].length) {
        allSources[key] = content;
      }
    });
  } catch(e) {}
});

// Group vue file parts
const vueFiles = {};
Object.keys(allSources).forEach(key => {
  const match = key.match(/^(src\/.*\.vue)(\?.*)?$/);
  if (match) {
    const base = match[1];
    const suffix = match[2] || '';
    if (!vueFiles[base]) vueFiles[base] = [];
    vueFiles[base].push({ suffix, key, content: allSources[key] });
  }
});

let restored = 0;
Object.keys(vueFiles).sort().forEach(basePath => {
  const parts = vueFiles[basePath];

  let renderSource = null;
  let scriptSource = null;

  parts.forEach(p => {
    const c = p.content;
    if (c.includes('var render = function') || c.includes('var render=function')) {
      renderSource = c;
    } else if (c.includes('cache-loader') || c.includes('vue-loader/lib/runtime') || c.includes('componentNormalizer')) {
      // skip
    } else if (c.includes('vue-property-decorator') || c.includes('export default') || c.includes('@Component') || (c.includes('import {') && !c.includes('cache-loader') && !c.includes('vue-loader'))) {
      scriptSource = c;
    }
  });

  if (!scriptSource && !renderSource) {
    console.log('SKIP:', basePath);
    return;
  }

  let sfc = '';

  if (scriptSource && renderSource) {
    // Extract render function code
    const renderFnMatch = renderSource.match(/(var render = function[\s\S]*?var staticRenderFns = \[[\s\S]*?\])/);
    const renderCode = renderFnMatch ? renderFnMatch[1] : renderSource;

    // Convert render function to use `h` parameter style
    // var render = function() { ... } => render(h) { ... }
    let renderForComponent = renderCode
      .replace(/var render = function\s*\(\)\s*\{/, 'render(createElement) {')
      .replace(/var staticRenderFns = \[/, 'staticRenderFns: [')
      .replace(/\]$/, ']');

    // Close the render function if needed
    if (!renderForComponent.includes('staticRenderFns:')) {
      renderForComponent = renderSource
        .replace(/var render = function\s*\(\)\s*\{/, 'render(createElement) {')
        .replace(/export \{ render, staticRenderFns \}/, '');
    }

    const isClassStyle = scriptSource.includes('vue-property-decorator') || scriptSource.includes('@Component');

    if (isClassStyle) {
      // For class-style components, add render to @Component options
      // @Component({ name: 'Xxx' }) => @Component({ name: 'Xxx', render, staticRenderFns })
      let modifiedScript = scriptSource;

      // Extract just the render function body and staticRenderFns
      const renderBodyMatch = renderSource.match(/var render = function\s*\(\)\s*\{([\s\S]*?)\}\s*\nvar staticRenderFns/);
      const staticRenderFnsMatch = renderSource.match(/var staticRenderFns = (\[[\s\S]*?\])\s*\nexport/);

      if (renderBodyMatch) {
        const renderBody = renderBodyMatch[1].trim();
        const staticRenderFnsBody = staticRenderFnsMatch ? staticRenderFnsMatch[1] : '[]';

        // Add render function before the class
        modifiedScript = `// Render function (decompiled from source map)\n`
          + `const __render__ = function(createElement) {${renderBody}}\n`
          + `const __staticRenderFns__ = ${staticRenderFnsBody}\n\n`
          + modifiedScript;

        // Add render to @Component decorator
        modifiedScript = modifiedScript.replace(
          /@Component\(\{([\s\S]*?)\}\)/,
          (match, inner) => {
            // Check if inner already has content
            const trimmed = inner.trim();
            // Remove trailing comma if present
            const cleanInner = trimmed.replace(/,\s*$/, '');
            if (cleanInner) {
              return `@Component({ ${cleanInner}, render: __render__, staticRenderFns: __staticRenderFns__ })`;
            } else {
              return `@Component({ render: __render__, staticRenderFns: __staticRenderFns__ })`;
            }
          }
        );

        // If no @Component decorator found, add one
        if (!modifiedScript.includes('@Component')) {
          modifiedScript = `@Component({ render: __render__, staticRenderFns: __staticRenderFns__ })\n` + modifiedScript;
        }
      }

      sfc += '<script lang="ts">\n';
      sfc += modifiedScript.trim();
      sfc += '\n</script>\n';
    } else {
      // Options API - add render directly
      sfc += '<script lang="ts">\n';
      sfc += scriptSource.trim();
      sfc += '\n</script>\n';
    }
  } else if (scriptSource) {
    sfc += '<script lang="ts">\n';
    sfc += scriptSource.trim();
    sfc += '\n</script>\n';
  } else if (renderSource) {
    sfc += '<script lang="ts">\n';
    sfc += renderSource.trim();
    sfc += '\n</script>\n';
  }

  const destPath = path.join(dest, basePath);
  fs.mkdirSync(path.dirname(destPath), { recursive: true });
  fs.writeFileSync(destPath, sfc, 'utf8');
  restored++;
  console.log('OK:', basePath);
});

console.log('\nRestored:', restored);
