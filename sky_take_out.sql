/*
 Navicat Premium Dump SQL

 Source Server         : man
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : sky_take_out

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 25/06/2026 11:59:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address_book
-- ----------------------------
DROP TABLE IF EXISTS `address_book`;
CREATE TABLE `address_book`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `consignee` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '收货人',
  `sex` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '性别',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '手机号',
  `province_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '省级区划编号',
  `province_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '省级名称',
  `city_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '市级区划编号',
  `city_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '市级名称',
  `district_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区级区划编号',
  `district_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区级名称',
  `detail` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '详细地址',
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标签',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '默认 0 否 1是',
  `longitude` double NULL DEFAULT NULL COMMENT '经度',
  `latitude` double NULL DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 88 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '地址簿' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address_book
-- ----------------------------
INSERT INTO `address_book` VALUES (1, 1, '张小明', '1', '13900139001', '110000', '北京市', '110100', '北京市', '110101', '东城区', '王府井大街1号', '家', 1, 116.4106, 39.9147);
INSERT INTO `address_book` VALUES (2, 1, '张小明', '1', '13900139001', '110000', '北京市', '110100', '北京市', '110105', '朝阳区', '建国门外大街2号', '公司', 0, 116.4595, 39.9087);
INSERT INTO `address_book` VALUES (3, 2, '李小红', '0', '13900139002', '110000', '北京市', '110100', '北京市', '110108', '海淀区', '中关村大街1号', '家', 1, 116.3074, 39.9841);
INSERT INTO `address_book` VALUES (4, 3, '王小华', '1', '13900139003', '110000', '北京市', '110100', '北京市', '110106', '丰台区', '丰台路1号', '家', 1, 116.2863, 39.8585);
INSERT INTO `address_book` VALUES (5, 4, '赵小芳', '0', '13900139004', '110000', '北京市', '110100', '北京市', '110102', '西城区', '西单北大街1号', '家', 1, 116.3728, 39.9127);
INSERT INTO `address_book` VALUES (6, 5, '孙小龙', '1', '13900139005', '110000', '北京市', '110100', '北京市', '110113', '顺义区', '顺义大街1号', '家', 1, 116.6542, 40.1301);
INSERT INTO `address_book` VALUES (7, 6, 'lk', '1', '17776248496', '广西壮族自治区', '广西壮族自治区', '南宁市', '南宁市', '西乡塘区', '西乡塘区', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路辅路广西财经学院明秀校区', '学校', 1, 108.298066, 22.836316);
INSERT INTO `address_book` VALUES (8, 1, '张三丰', '男', '13800138001', '440000', '广东省', '440100', '广州市', '440105', '海珠区', '新港中路123号', '家', 1, 113.263, 23.096);
INSERT INTO `address_book` VALUES (9, 1, '张三丰', '男', '13800138001', '440000', '广东省', '440100', '广州市', '440106', '天河区', '天河东路456号', '公司', 0, 113.345, 23.124);
INSERT INTO `address_book` VALUES (10, 2, '李四娘', '女', '13800138002', '440000', '广东省', '440300', '深圳市', '440305', '南山区', '科技园南路789号', '家', 1, 113.941, 22.543);
INSERT INTO `address_book` VALUES (11, 3, '王五哥', '男', '13800138003', '440000', '广东省', '440100', '广州市', '440104', '越秀区', '东风中路321号', '家', 1, 113.259, 23.132);
INSERT INTO `address_book` VALUES (12, 4, '赵六妹', '女', '13800138004', '440000', '广东省', '440300', '深圳市', '440304', '福田区', '深南大道6001号', '家', 1, 114.055, 22.531);
INSERT INTO `address_book` VALUES (13, 5, '孙七爷', '男', '13800138005', '440000', '广东省', '440600', '佛山市', '440605', '南海区', '桂城街道桂澜路88号', '家', 1, 113.143, 23.034);
INSERT INTO `address_book` VALUES (15, 7, '吴九郎', '男', '13800138007', '440000', '广东省', '440300', '深圳市', '440306', '宝安区', '宝安大道3000号', '家', 1, 113.884, 22.555);
INSERT INTO `address_book` VALUES (16, 8, '郑十妹', '女', '13800138008', '440000', '广东省', '440100', '广州市', '440112', '黄埔区', '开创大道666号', '家', 1, 113.458, 23.106);
INSERT INTO `address_book` VALUES (17, 9, '陈大勇', '男', '13800138009', '440000', '广东省', '440600', '佛山市', '440604', '禅城区', '季华五路28号', '家', 1, 113.113, 23.018);
INSERT INTO `address_book` VALUES (18, 10, '林小美', '女', '13800138010', '440000', '广东省', '440300', '深圳市', '440308', '盐田区', '深盐路111号', '家', 1, 114.236, 22.556);
INSERT INTO `address_book` VALUES (19, 11, '黄药师', '男', '13800138011', '440000', '广东省', '440100', '广州市', '440103', '荔湾区', '中山八路50号', '家', 1, 113.233, 23.126);
INSERT INTO `address_book` VALUES (20, 12, '杨过', '男', '13800138012', '440000', '广东省', '440300', '深圳市', '440307', '龙岗区', '龙翔大道200号', '家', 1, 114.248, 22.721);
INSERT INTO `address_book` VALUES (21, 13, '小龙女', '女', '13800138013', '440000', '广东省', '440100', '广州市', '440113', '番禺区', '市桥街繁华路18号', '家', 1, 113.363, 22.937);
INSERT INTO `address_book` VALUES (22, 14, '郭靖', '男', '13800138014', '440000', '广东省', '440600', '佛山市', '440606', '顺德区', '大良街道清晖路22号', '家', 1, 113.245, 22.843);
INSERT INTO `address_book` VALUES (23, 15, '黄蓉', '女', '13800138015', '440000', '广东省', '440100', '广州市', '440114', '花都区', '迎宾大道99号', '家', 1, 113.22, 23.404);
INSERT INTO `address_book` VALUES (24, 1, '张三丰', '男', '13800138001', '440000', '广东省', '440100', '广州市', '440105', '海珠区', '新港中路123号', '家', 1, 113.263, 23.096);
INSERT INTO `address_book` VALUES (25, 1, '张三丰', '男', '13800138001', '440000', '广东省', '440100', '广州市', '440106', '天河区', '天河东路456号', '公司', 0, 113.345, 23.124);
INSERT INTO `address_book` VALUES (26, 2, '李四娘', '女', '13800138002', '440000', '广东省', '440300', '深圳市', '440305', '南山区', '科技园南路789号', '家', 1, 113.941, 22.543);
INSERT INTO `address_book` VALUES (27, 3, '王五哥', '男', '13800138003', '440000', '广东省', '440100', '广州市', '440104', '越秀区', '东风中路321号', '家', 1, 113.259, 23.132);
INSERT INTO `address_book` VALUES (28, 4, '赵六妹', '女', '13800138004', '440000', '广东省', '440300', '深圳市', '440304', '福田区', '深南大道6001号', '家', 1, 114.055, 22.531);
INSERT INTO `address_book` VALUES (29, 5, '孙七爷', '男', '13800138005', '440000', '广东省', '440600', '佛山市', '440605', '南海区', '桂城街道桂澜路88号', '家', 1, 113.143, 23.034);
INSERT INTO `address_book` VALUES (31, 7, '吴九郎', '男', '13800138007', '440000', '广东省', '440300', '深圳市', '440306', '宝安区', '宝安大道3000号', '家', 1, 113.884, 22.555);
INSERT INTO `address_book` VALUES (32, 8, '郑十妹', '女', '13800138008', '440000', '广东省', '440100', '广州市', '440112', '黄埔区', '开创大道666号', '家', 1, 113.458, 23.106);
INSERT INTO `address_book` VALUES (33, 9, '陈大勇', '男', '13800138009', '440000', '广东省', '440600', '佛山市', '440604', '禅城区', '季华五路28号', '家', 1, 113.113, 23.018);
INSERT INTO `address_book` VALUES (34, 10, '林小美', '女', '13800138010', '440000', '广东省', '440300', '深圳市', '440308', '盐田区', '深盐路111号', '家', 1, 114.236, 22.556);
INSERT INTO `address_book` VALUES (35, 11, '黄药师', '男', '13800138011', '440000', '广东省', '440100', '广州市', '440103', '荔湾区', '中山八路50号', '家', 1, 113.233, 23.126);
INSERT INTO `address_book` VALUES (36, 12, '杨过', '男', '13800138012', '440000', '广东省', '440300', '深圳市', '440307', '龙岗区', '龙翔大道200号', '家', 1, 114.248, 22.721);
INSERT INTO `address_book` VALUES (37, 13, '小龙女', '女', '13800138013', '440000', '广东省', '440100', '广州市', '440113', '番禺区', '市桥街繁华路18号', '家', 1, 113.363, 22.937);
INSERT INTO `address_book` VALUES (38, 14, '郭靖', '男', '13800138014', '440000', '广东省', '440600', '佛山市', '440606', '顺德区', '大良街道清晖路22号', '家', 1, 113.245, 22.843);
INSERT INTO `address_book` VALUES (39, 15, '黄蓉', '女', '13800138015', '440000', '广东省', '440100', '广州市', '440114', '花都区', '迎宾大道99号', '家', 1, 113.22, 23.404);
INSERT INTO `address_book` VALUES (40, 1, '张三丰', '男', '13800138001', '440000', '广东省', '440100', '广州市', '440105', '海珠区', '新港中路123号', '家', 1, 113.263, 23.096);
INSERT INTO `address_book` VALUES (41, 1, '张三丰', '男', '13800138001', '440000', '广东省', '440100', '广州市', '440106', '天河区', '天河东路456号', '公司', 0, 113.345, 23.124);
INSERT INTO `address_book` VALUES (42, 2, '李四娘', '女', '13800138002', '440000', '广东省', '440300', '深圳市', '440305', '南山区', '科技园南路789号', '家', 1, 113.941, 22.543);
INSERT INTO `address_book` VALUES (43, 3, '王五哥', '男', '13800138003', '440000', '广东省', '440100', '广州市', '440104', '越秀区', '东风中路321号', '家', 1, 113.259, 23.132);
INSERT INTO `address_book` VALUES (44, 4, '赵六妹', '女', '13800138004', '440000', '广东省', '440300', '深圳市', '440304', '福田区', '深南大道6001号', '家', 1, 114.055, 22.531);
INSERT INTO `address_book` VALUES (45, 5, '孙七爷', '男', '13800138005', '440000', '广东省', '440600', '佛山市', '440605', '南海区', '桂城街道桂澜路88号', '家', 1, 113.143, 23.034);
INSERT INTO `address_book` VALUES (47, 7, '吴九郎', '男', '13800138007', '440000', '广东省', '440300', '深圳市', '440306', '宝安区', '宝安大道3000号', '家', 1, 113.884, 22.555);
INSERT INTO `address_book` VALUES (48, 8, '郑十妹', '女', '13800138008', '440000', '广东省', '440100', '广州市', '440112', '黄埔区', '开创大道666号', '家', 1, 113.458, 23.106);
INSERT INTO `address_book` VALUES (49, 9, '陈大勇', '男', '13800138009', '440000', '广东省', '440600', '佛山市', '440604', '禅城区', '季华五路28号', '家', 1, 113.113, 23.018);
INSERT INTO `address_book` VALUES (50, 10, '林小美', '女', '13800138010', '440000', '广东省', '440300', '深圳市', '440308', '盐田区', '深盐路111号', '家', 1, 114.236, 22.556);
INSERT INTO `address_book` VALUES (51, 11, '黄药师', '男', '13800138011', '440000', '广东省', '440100', '广州市', '440103', '荔湾区', '中山八路50号', '家', 1, 113.233, 23.126);
INSERT INTO `address_book` VALUES (52, 12, '杨过', '男', '13800138012', '440000', '广东省', '440300', '深圳市', '440307', '龙岗区', '龙翔大道200号', '家', 1, 114.248, 22.721);
INSERT INTO `address_book` VALUES (53, 13, '小龙女', '女', '13800138013', '440000', '广东省', '440100', '广州市', '440113', '番禺区', '市桥街繁华路18号', '家', 1, 113.363, 22.937);
INSERT INTO `address_book` VALUES (54, 14, '郭靖', '男', '13800138014', '440000', '广东省', '440600', '佛山市', '440606', '顺德区', '大良街道清晖路22号', '家', 1, 113.245, 22.843);
INSERT INTO `address_book` VALUES (55, 15, '黄蓉', '女', '13800138015', '440000', '广东省', '440100', '广州市', '440114', '花都区', '迎宾大道99号', '家', 1, 113.22, 23.404);
INSERT INTO `address_book` VALUES (56, 1, '张三丰', '男', '13800138001', '440000', '广东省', '440100', '广州市', '440105', '海珠区', '新港中路123号', '家', 1, 113.263, 23.096);
INSERT INTO `address_book` VALUES (57, 1, '张三丰', '男', '13800138001', '440000', '广东省', '440100', '广州市', '440106', '天河区', '天河东路456号', '公司', 0, 113.345, 23.124);
INSERT INTO `address_book` VALUES (58, 2, '李四娘', '女', '13800138002', '440000', '广东省', '440300', '深圳市', '440305', '南山区', '科技园南路789号', '家', 1, 113.941, 22.543);
INSERT INTO `address_book` VALUES (59, 3, '王五哥', '男', '13800138003', '440000', '广东省', '440100', '广州市', '440104', '越秀区', '东风中路321号', '家', 1, 113.259, 23.132);
INSERT INTO `address_book` VALUES (60, 4, '赵六妹', '女', '13800138004', '440000', '广东省', '440300', '深圳市', '440304', '福田区', '深南大道6001号', '家', 1, 114.055, 22.531);
INSERT INTO `address_book` VALUES (61, 5, '孙七爷', '男', '13800138005', '440000', '广东省', '440600', '佛山市', '440605', '南海区', '桂城街道桂澜路88号', '家', 1, 113.143, 23.034);
INSERT INTO `address_book` VALUES (63, 7, '吴九郎', '男', '13800138007', '440000', '广东省', '440300', '深圳市', '440306', '宝安区', '宝安大道3000号', '家', 1, 113.884, 22.555);
INSERT INTO `address_book` VALUES (64, 8, '郑十妹', '女', '13800138008', '440000', '广东省', '440100', '广州市', '440112', '黄埔区', '开创大道666号', '家', 1, 113.458, 23.106);
INSERT INTO `address_book` VALUES (65, 9, '陈大勇', '男', '13800138009', '440000', '广东省', '440600', '佛山市', '440604', '禅城区', '季华五路28号', '家', 1, 113.113, 23.018);
INSERT INTO `address_book` VALUES (66, 10, '林小美', '女', '13800138010', '440000', '广东省', '440300', '深圳市', '440308', '盐田区', '深盐路111号', '家', 1, 114.236, 22.556);
INSERT INTO `address_book` VALUES (67, 11, '黄药师', '男', '13800138011', '440000', '广东省', '440100', '广州市', '440103', '荔湾区', '中山八路50号', '家', 1, 113.233, 23.126);
INSERT INTO `address_book` VALUES (68, 12, '杨过', '男', '13800138012', '440000', '广东省', '440300', '深圳市', '440307', '龙岗区', '龙翔大道200号', '家', 1, 114.248, 22.721);
INSERT INTO `address_book` VALUES (69, 13, '小龙女', '女', '13800138013', '440000', '广东省', '440100', '广州市', '440113', '番禺区', '市桥街繁华路18号', '家', 1, 113.363, 22.937);
INSERT INTO `address_book` VALUES (70, 14, '郭靖', '男', '13800138014', '440000', '广东省', '440600', '佛山市', '440606', '顺德区', '大良街道清晖路22号', '家', 1, 113.245, 22.843);
INSERT INTO `address_book` VALUES (71, 15, '黄蓉', '女', '13800138015', '440000', '广东省', '440100', '广州市', '440114', '花都区', '迎宾大道99号', '家', 1, 113.22, 23.404);
INSERT INTO `address_book` VALUES (72, 1, '张三丰', '男', '13800138001', '440000', '广东省', '440100', '广州市', '440105', '海珠区', '新港中路123号', '家', 1, 113.263, 23.096);
INSERT INTO `address_book` VALUES (73, 1, '张三丰', '男', '13800138001', '440000', '广东省', '440100', '广州市', '440106', '天河区', '天河东路456号', '公司', 0, 113.345, 23.124);
INSERT INTO `address_book` VALUES (74, 2, '李四娘', '女', '13800138002', '440000', '广东省', '440300', '深圳市', '440305', '南山区', '科技园南路789号', '家', 1, 113.941, 22.543);
INSERT INTO `address_book` VALUES (75, 3, '王五哥', '男', '13800138003', '440000', '广东省', '440100', '广州市', '440104', '越秀区', '东风中路321号', '家', 1, 113.259, 23.132);
INSERT INTO `address_book` VALUES (76, 4, '赵六妹', '女', '13800138004', '440000', '广东省', '440300', '深圳市', '440304', '福田区', '深南大道6001号', '家', 1, 114.055, 22.531);
INSERT INTO `address_book` VALUES (77, 5, '孙七爷', '男', '13800138005', '440000', '广东省', '440600', '佛山市', '440605', '南海区', '桂城街道桂澜路88号', '家', 1, 113.143, 23.034);
INSERT INTO `address_book` VALUES (79, 7, '吴九郎', '男', '13800138007', '440000', '广东省', '440300', '深圳市', '440306', '宝安区', '宝安大道3000号', '家', 1, 113.884, 22.555);
INSERT INTO `address_book` VALUES (80, 8, '郑十妹', '女', '13800138008', '440000', '广东省', '440100', '广州市', '440112', '黄埔区', '开创大道666号', '家', 1, 113.458, 23.106);
INSERT INTO `address_book` VALUES (81, 9, '陈大勇', '男', '13800138009', '440000', '广东省', '440600', '佛山市', '440604', '禅城区', '季华五路28号', '家', 1, 113.113, 23.018);
INSERT INTO `address_book` VALUES (82, 10, '林小美', '女', '13800138010', '440000', '广东省', '440300', '深圳市', '440308', '盐田区', '深盐路111号', '家', 1, 114.236, 22.556);
INSERT INTO `address_book` VALUES (83, 11, '黄药师', '男', '13800138011', '440000', '广东省', '440100', '广州市', '440103', '荔湾区', '中山八路50号', '家', 1, 113.233, 23.126);
INSERT INTO `address_book` VALUES (84, 12, '杨过', '男', '13800138012', '440000', '广东省', '440300', '深圳市', '440307', '龙岗区', '龙翔大道200号', '家', 1, 114.248, 22.721);
INSERT INTO `address_book` VALUES (85, 13, '小龙女', '女', '13800138013', '440000', '广东省', '440100', '广州市', '440113', '番禺区', '市桥街繁华路18号', '家', 1, 113.363, 22.937);
INSERT INTO `address_book` VALUES (86, 14, '郭靖', '男', '13800138014', '440000', '广东省', '440600', '佛山市', '440606', '顺德区', '大良街道清晖路22号', '家', 1, 113.245, 22.843);
INSERT INTO `address_book` VALUES (87, 15, '黄蓉', '女', '13800138015', '440000', '广东省', '440100', '广州市', '440114', '花都区', '迎宾大道99号', '家', 1, 113.22, 23.404);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` int NULL DEFAULT NULL COMMENT '类型   1 菜品分类 2 套餐分类',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '分类名称',
  `sort` int NOT NULL DEFAULT 0 COMMENT '顺序',
  `status` int NULL DEFAULT NULL COMMENT '分类状态 0:禁用，1:启用',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_user` bigint NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_category_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '菜品及套餐分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 1, '川菜', 1, 1, '2024-01-01 00:00:00', '2024-01-01 00:00:00', 1, 1);
INSERT INTO `category` VALUES (2, 1, '湘菜', 2, 1, '2024-01-01 00:00:00', '2024-01-01 00:00:00', 1, 1);
INSERT INTO `category` VALUES (3, 1, '粤菜', 3, 1, '2024-01-01 00:00:00', '2024-01-01 00:00:00', 1, 1);
INSERT INTO `category` VALUES (4, 1, '东北菜', 4, 1, '2024-01-01 00:00:00', '2024-01-01 00:00:00', 1, 1);
INSERT INTO `category` VALUES (5, 1, '主食', 5, 1, '2024-01-01 00:00:00', '2024-01-01 00:00:00', 1, 1);
INSERT INTO `category` VALUES (6, 1, '饮品', 6, 1, '2024-01-01 00:00:00', '2024-01-01 00:00:00', 1, 1);
INSERT INTO `category` VALUES (11, 2, '单人套餐', 1, 1, '2024-01-01 00:00:00', '2024-01-01 00:00:00', 1, 1);
INSERT INTO `category` VALUES (12, 2, '双人套餐', 2, 1, '2024-01-01 00:00:00', '2024-01-01 00:00:00', 1, 1);
INSERT INTO `category` VALUES (13, 2, '家庭套餐', 3, 1, '2024-01-01 00:00:00', '2024-01-01 00:00:00', 1, 1);

-- ----------------------------
-- Table structure for dish
-- ----------------------------
DROP TABLE IF EXISTS `dish`;
CREATE TABLE `dish`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '菜品名称',
  `category_id` bigint NOT NULL COMMENT '菜品分类id',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '菜品价格',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '图片',
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '描述信息',
  `status` int NULL DEFAULT 1 COMMENT '0 停售 1 起售',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_user` bigint NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_dish_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '菜品' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dish
-- ----------------------------
INSERT INTO `dish` VALUES (1, '水煮鱼', 1, 68.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1b7068a6-3b55-4415-87ef-ba14005c3ea1.jpg', '鲜嫩鱼片配以麻辣红油，香辣可口', 1, '2024-01-01 00:00:00', '2026-06-25 08:37:49', 1, 1);
INSERT INTO `dish` VALUES (2, '麻婆豆腐', 1, 28.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/d2983e28-778b-40bf-bb08-a2c846fba5ed.jpg', '经典川菜，麻辣鲜香', 1, '2024-01-01 00:00:00', '2026-06-25 08:37:20', 1, 1);
INSERT INTO `dish` VALUES (3, '宫保鸡丁', 1, 38.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/82471f26-68ba-431f-8aea-54fae026627a.jpg', '鸡肉鲜嫩，花生酥脆，酸甜微辣', 1, '2024-01-01 00:00:00', '2026-06-25 08:36:48', 1, 1);
INSERT INTO `dish` VALUES (4, '回锅肉', 1, 45.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/9a9bb700-3e8d-4846-92a3-47e3057e33e9.jpg', '五花肉配蒜苗，肥而不腻', 1, '2024-01-01 00:00:00', '2026-06-25 08:36:13', 1, 1);
INSERT INTO `dish` VALUES (5, '辣子鸡', 1, 58.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/7aa41cf4-e0bc-4e7a-8bed-e15f62b7588d.jpg', '外酥里嫩，麻辣鲜香', 1, '2024-01-01 00:00:00', '2026-06-25 08:35:28', 1, 1);
INSERT INTO `dish` VALUES (6, '剁椒鱼头', 2, 88.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/b58fdc8a-4bbd-4e08-8815-080d2dd7e8c3.jpg', '鲜嫩鱼头配以剁椒，香辣开胃', 1, '2024-01-01 00:00:00', '2026-06-25 08:34:45', 1, 1);
INSERT INTO `dish` VALUES (7, '小炒肉', 2, 36.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1d58c907-228e-4952-becb-a3f44e71c425.jpg', '湖南家常菜，肉香四溢', 1, '2024-01-01 00:00:00', '2026-06-25 08:34:13', 1, 1);
INSERT INTO `dish` VALUES (8, '农家小炒', 2, 28.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/5d66b754-1b53-467e-ac46-0333f16269d0.jpg', '新鲜时蔬，清爽可口', 1, '2024-01-01 00:00:00', '2026-06-25 08:32:34', 1, 1);
INSERT INTO `dish` VALUES (9, '白切鸡', 3, 68.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/e321e987-8857-4aef-9a87-99829639adb8.jpg', '皮爽肉滑，原汁原味', 1, '2024-01-01 00:00:00', '2026-06-25 08:31:57', 1, 1);
INSERT INTO `dish` VALUES (10, '蒜蓉蒸虾', 3, 78.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/ace50027-cc50-4a94-a4d3-1a75ddb53209.jpg', '鲜虾配蒜蓉，鲜嫩可口', 1, '2024-01-01 00:00:00', '2026-06-25 08:31:24', 1, 1);
INSERT INTO `dish` VALUES (11, '叉烧', 3, 48.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/4af6abc6-7e2b-4905-9c92-158a5591be3c.jpg', '蜜汁叉烧，甜香可口', 1, '2024-01-01 00:00:00', '2026-06-25 08:30:43', 1, 1);
INSERT INTO `dish` VALUES (12, '锅包肉', 4, 42.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/621487ba-0cea-42bb-acfb-c381413ef72e.jpg', '外酥里嫩，酸甜可口', 1, '2024-01-01 00:00:00', '2026-06-25 08:30:14', 1, 1);
INSERT INTO `dish` VALUES (13, '地三鲜', 4, 26.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/19f4a1d9-239b-442c-b5dd-e856ff9d9d69.jpg', '土豆茄子青椒，经典东北菜', 1, '2024-01-01 00:00:00', '2026-06-25 08:29:51', 1, 1);
INSERT INTO `dish` VALUES (14, '小鸡炖蘑菇', 4, 68.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/b0670cc6-6c6d-4679-8fa3-062197e5741d.jpg', '东北名菜，营养丰富', 1, '2024-01-01 00:00:00', '2026-06-25 08:29:16', 1, 1);
INSERT INTO `dish` VALUES (15, '米饭', 5, 3.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/ed64457e-e8cb-44f2-977f-a58d67680ea3.jpg', '东北大米，颗粒饱满', 1, '2024-01-01 00:00:00', '2026-06-25 01:15:36', 1, 1);
INSERT INTO `dish` VALUES (16, '炒饭', 5, 18.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/98ee817c-6845-4bf9-9906-725a2217c7f6.jpg', '蛋炒饭，粒粒分明', 1, '2024-01-01 00:00:00', '2026-06-25 01:15:10', 1, 1);
INSERT INTO `dish` VALUES (17, '担担面', 5, 22.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/29eeff29-36ba-4019-a253-242e217128e4.jpg', '四川特色面食，麻辣鲜香', 1, '2024-01-01 00:00:00', '2026-06-25 01:13:51', 1, 1);
INSERT INTO `dish` VALUES (18, '可乐', 6, 6.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/bb5d8864-176f-4076-a26c-9656a943367b.jpg', '冰镇可乐', 1, '2024-01-01 00:00:00', '2026-06-25 01:13:23', 1, 1);
INSERT INTO `dish` VALUES (19, '柠檬茶', 6, 8.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/91cac219-849e-454d-9862-3e2f6b270d1d.jpg', '新鲜柠檬泡制', 1, '2024-01-01 00:00:00', '2026-06-25 01:07:55', 1, 1);
INSERT INTO `dish` VALUES (20, '酸梅汤', 6, 6.00, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/c2f0751a-915c-4d8e-a919-639ca1fc86af.jpg', '传统饮品，消暑解渴', 1, '2024-01-01 00:00:00', '2026-06-25 01:06:45', 1, 1);

-- ----------------------------
-- Table structure for dish_flavor
-- ----------------------------
DROP TABLE IF EXISTS `dish_flavor`;
CREATE TABLE `dish_flavor`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dish_id` bigint NOT NULL COMMENT '菜品',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '口味名称',
  `value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '口味数据list',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '菜品口味关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dish_flavor
-- ----------------------------
INSERT INTO `dish_flavor` VALUES (10, 17, '口味', '[\"原味\",\"加蛋\",\"加肉\"]');
INSERT INTO `dish_flavor` VALUES (11, 17, '辣度', '[\"不辣\",\"微辣\",\"中辣\"]');
INSERT INTO `dish_flavor` VALUES (12, 7, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"特辣\"]');
INSERT INTO `dish_flavor` VALUES (13, 6, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"特辣\"]');
INSERT INTO `dish_flavor` VALUES (14, 5, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"特辣\"]');
INSERT INTO `dish_flavor` VALUES (15, 4, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"特辣\"]');
INSERT INTO `dish_flavor` VALUES (16, 3, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"特辣\"]');
INSERT INTO `dish_flavor` VALUES (17, 2, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"特辣\"]');
INSERT INTO `dish_flavor` VALUES (18, 1, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"特辣\"]');

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '姓名',
  `username` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '密码',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '身份证号',
  `status` int NOT NULL DEFAULT 1 COMMENT '状态 0:禁用，1:启用',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_user` bigint NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '员工信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, '管理员', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '13800138000', '1', '110101199001011234', 1, '2024-01-01 00:00:00', '2024-01-01 00:00:00', 1, 1);
INSERT INTO `employee` VALUES (2, '张四', 'zhangsi', 'e10adc3949ba59abbe56e057f20f883e', '13800138123', '0', '110101199002021123', 1, '2024-01-01 00:00:00', '2026-06-25 08:52:07', 1, 1);
INSERT INTO `employee` VALUES (3, '李四', 'lisi', 'e10adc3949ba59abbe56e057f20f883e', '13800138002', '0', '110101199003031234', 1, '2024-01-01 00:00:00', '2024-01-01 00:00:00', 1, 1);
INSERT INTO `employee` VALUES (4, '王五', 'wangwu', 'e10adc3949ba59abbe56e057f20f883e', '13800138003', '1', '110101199004041234', 0, '2024-01-01 00:00:00', '2024-01-01 00:00:00', 1, 1);
INSERT INTO `employee` VALUES (5, '1', '1111', 'e10adc3949ba59abbe56e057f20f883e', '17776248494', '1', '450788876574671822', 1, '2026-06-25 08:52:28', '2026-06-25 08:52:28', 1, 1);

-- ----------------------------
-- Table structure for favorite
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `dish_id` bigint NOT NULL DEFAULT -1 COMMENT '菜品id',
  `setmeal_id` bigint NOT NULL DEFAULT -1 COMMENT '套餐id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_dish_setmeal`(`user_id` ASC, `dish_id` ASC, `setmeal_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '收藏菜品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of favorite
-- ----------------------------
INSERT INTO `favorite` VALUES (1, 1, 1, -1, '2024-06-15 12:30:00');
INSERT INTO `favorite` VALUES (2, 1, 3, -1, '2024-06-15 12:30:00');
INSERT INTO `favorite` VALUES (3, 1, -1, 3, '2024-06-16 18:40:00');
INSERT INTO `favorite` VALUES (4, 2, 6, -1, '2024-06-15 12:40:00');
INSERT INTO `favorite` VALUES (5, 2, 9, -1, '2024-06-15 12:40:00');
INSERT INTO `favorite` VALUES (6, 3, 12, -1, '2024-06-15 12:50:00');
INSERT INTO `favorite` VALUES (7, 4, -1, 1, '2024-06-17 12:30:00');
INSERT INTO `favorite` VALUES (8, 5, 1, -1, '2024-06-18 12:10:00');
INSERT INTO `favorite` VALUES (9, 5, 5, -1, '2024-06-18 12:10:00');
INSERT INTO `favorite` VALUES (15, 6, 5, -1, '2026-06-25 09:06:36');
INSERT INTO `favorite` VALUES (20, 6, 2, -1, '2026-06-25 10:43:44');

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '名字',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '图片',
  `order_id` bigint NOT NULL COMMENT '订单id',
  `dish_id` bigint NULL DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint NULL DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '口味',
  `number` int NOT NULL DEFAULT 1 COMMENT '数量',
  `amount` decimal(10, 2) NOT NULL COMMENT '金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 82 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '订单明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES (1, '水煮鱼', 'https://example.com/dish/shuizhuyu.jpg', 1, 1, NULL, '中辣', 1, 68.00);
INSERT INTO `order_detail` VALUES (2, '米饭', 'https://example.com/dish/mifan.jpg', 1, 15, NULL, NULL, 1, 3.00);
INSERT INTO `order_detail` VALUES (3, '双人套餐', 'https://example.com/setmeal/shuangren.jpg', 2, NULL, 3, NULL, 1, 128.00);
INSERT INTO `order_detail` VALUES (4, '单人豪华套餐', 'https://example.com/setmeal/danrenhaohua.jpg', 3, NULL, 2, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (5, '家庭套餐（3-4人）', 'https://example.com/setmeal/jiating.jpg', 4, NULL, 5, NULL, 1, 268.00);
INSERT INTO `order_detail` VALUES (6, '单人精选套餐', 'https://example.com/setmeal/danren.jpg', 5, NULL, 1, NULL, 1, 58.00);
INSERT INTO `order_detail` VALUES (7, '双人豪华套餐', 'https://example.com/setmeal/shuangrenhaohua.jpg', 6, NULL, 4, NULL, 1, 188.00);
INSERT INTO `order_detail` VALUES (8, '宫保鸡丁', 'https://example.com/dish/gongbaojiding.jpg', 7, 3, NULL, '微辣', 1, 38.00);
INSERT INTO `order_detail` VALUES (9, '回锅肉', 'https://example.com/dish/huiguorou.jpg', 7, 4, NULL, NULL, 1, 45.00);
INSERT INTO `order_detail` VALUES (10, '米饭', 'https://example.com/dish/mifan.jpg', 7, 15, NULL, NULL, 2, 3.00);
INSERT INTO `order_detail` VALUES (11, '可乐', 'https://example.com/dish/kele.jpg', 7, 18, NULL, NULL, 2, 6.00);
INSERT INTO `order_detail` VALUES (12, '水煮鱼', 'https://example.com/dish/shuizhuyu.jpg', 8, 1, NULL, '特辣', 1, 68.00);
INSERT INTO `order_detail` VALUES (13, '农家小炒', 'https://example.com/dish/nongjiaxiaochao.jpg', 9, 8, -1, '', 4, 28.00);
INSERT INTO `order_detail` VALUES (14, '家庭套餐（3-4人）', 'https://example.com/setmeal/jiating.jpg', 10, -1, 5, '', 1, 268.00);
INSERT INTO `order_detail` VALUES (15, '锅包肉', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/621487ba-0cea-42bb-acfb-c381413ef72e.jpg', 11, 12, -1, '', 2, 42.00);
INSERT INTO `order_detail` VALUES (16, '锅包肉', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/621487ba-0cea-42bb-acfb-c381413ef72e.jpg', 12, 12, -1, '', 2, 42.00);
INSERT INTO `order_detail` VALUES (17, '水煮鱼', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1b7068a6-3b55-4415-87ef-ba14005c3ea1.jpg', 13, 1, -1, '特辣', 1, 68.00);
INSERT INTO `order_detail` VALUES (18, '水煮鱼', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1b7068a6-3b55-4415-87ef-ba14005c3ea1.jpg', 14, 1, -1, '特辣', 1, 68.00);
INSERT INTO `order_detail` VALUES (19, '水煮鱼', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1b7068a6-3b55-4415-87ef-ba14005c3ea1.jpg', 15, 1, -1, '中辣', 1, 68.00);
INSERT INTO `order_detail` VALUES (20, '宫保鸡丁', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/82471f26-68ba-431f-8aea-54fae026627a.jpg', 15, 3, -1, '特辣', 1, 38.00);
INSERT INTO `order_detail` VALUES (21, '回锅肉', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/9a9bb700-3e8d-4846-92a3-47e3057e33e9.jpg', 15, 4, -1, '中辣', 1, 45.00);
INSERT INTO `order_detail` VALUES (22, '锅包肉', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/621487ba-0cea-42bb-acfb-c381413ef72e.jpg', 15, 12, -1, '', 2, 42.00);
INSERT INTO `order_detail` VALUES (23, '水煮鱼', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1b7068a6-3b55-4415-87ef-ba14005c3ea1.jpg', 1001, 1, NULL, '微辣', 1, 68.00);
INSERT INTO `order_detail` VALUES (24, '麻婆豆腐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/d2983e28-778b-40bf-bb08-a2c846fba5ed.jpg', 1002, 2, NULL, '中辣', 2, 56.00);
INSERT INTO `order_detail` VALUES (25, '米饭', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/ed64457e-e8cb-44f2-977f-a58d67680ea3.jpg', 1002, 15, NULL, NULL, 2, 6.00);
INSERT INTO `order_detail` VALUES (26, '可乐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/bb5d8864-176f-4076-a26c-9656a943367b.jpg', 1002, 18, NULL, NULL, 2, 12.00);
INSERT INTO `order_detail` VALUES (27, '宫保鸡丁', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/82471f26-68ba-431f-8aea-54fae026627a.jpg', 1003, 3, NULL, '微辣', 1, 38.00);
INSERT INTO `order_detail` VALUES (28, '单人豪华套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/99806447-1172-481a-a9cc-fc9476e976ab.png', 1004, NULL, 2, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (29, '回锅肉', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/9a9bb700-3e8d-4846-92a3-47e3057e33e9.jpg', 1005, 4, NULL, '正常', 1, 45.00);
INSERT INTO `order_detail` VALUES (30, '双人套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/95b6b76f-ddc1-4a88-9303-36bb3cbc2c4d.png', 1006, NULL, 3, NULL, 1, 128.00);
INSERT INTO `order_detail` VALUES (31, '家庭套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/779ac7be-283f-4ce4-ad04-07e113568dfa.png', 1007, NULL, 5, NULL, 1, 268.00);
INSERT INTO `order_detail` VALUES (32, '辣子鸡', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/7aa41cf4-e0bc-4e7a-8bed-e15f62b7588d.jpg', 1008, 5, NULL, '重辣', 1, 58.00);
INSERT INTO `order_detail` VALUES (33, '双人套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/95b6b76f-ddc1-4a88-9303-36bb3cbc2c4d.png', 1009, NULL, 3, NULL, 1, 128.00);
INSERT INTO `order_detail` VALUES (34, '水煮鱼', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1b7068a6-3b55-4415-87ef-ba14005c3ea1.jpg', 1010, 1, NULL, '微辣', 1, 68.00);
INSERT INTO `order_detail` VALUES (35, '家庭豪华套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/e3f5c215-4f6c-41ea-b184-19892f27913a.png', 1011, NULL, 6, NULL, 1, 388.00);
INSERT INTO `order_detail` VALUES (36, '单人豪华套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/99806447-1172-481a-a9cc-fc9476e976ab.png', 1012, NULL, 2, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (37, '双人套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/95b6b76f-ddc1-4a88-9303-36bb3cbc2c4d.png', 1013, NULL, 3, NULL, 1, 128.00);
INSERT INTO `order_detail` VALUES (38, '家庭套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/779ac7be-283f-4ce4-ad04-07e113568dfa.png', 1014, NULL, 5, NULL, 1, 268.00);
INSERT INTO `order_detail` VALUES (39, '蒜蓉蒸虾', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/ace50027-cc50-4a94-a4d3-1a75ddb53209.jpg', 1015, 10, NULL, '正常', 1, 78.00);
INSERT INTO `order_detail` VALUES (40, '小炒肉', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1d58c907-228e-4952-becb-a3f44e71c425.jpg', 1016, 7, NULL, '微辣', 1, 36.00);
INSERT INTO `order_detail` VALUES (41, '双人豪华套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/be393694-6deb-4abd-bdbf-b777c4690a3a.png', 1017, NULL, 4, NULL, 1, 188.00);
INSERT INTO `order_detail` VALUES (42, '单人豪华套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/99806447-1172-481a-a9cc-fc9476e976ab.png', 1018, NULL, 2, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (43, '双人套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/95b6b76f-ddc1-4a88-9303-36bb3cbc2c4d.png', 1019, NULL, 3, NULL, 1, 128.00);
INSERT INTO `order_detail` VALUES (44, '水煮鱼', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1b7068a6-3b55-4415-87ef-ba14005c3ea1.jpg', 1020, 1, NULL, '微辣', 1, 68.00);
INSERT INTO `order_detail` VALUES (45, '单人精选套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/ce289fec-ecda-4309-a742-daa0c9537206.png', 1021, NULL, 1, NULL, 1, 60.00);
INSERT INTO `order_detail` VALUES (46, '双人豪华套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/be393694-6deb-4abd-bdbf-b777c4690a3a.png', 1022, NULL, 4, NULL, 1, 188.00);
INSERT INTO `order_detail` VALUES (47, '家庭套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/779ac7be-283f-4ce4-ad04-07e113568dfa.png', 1023, NULL, 5, NULL, 1, 268.00);
INSERT INTO `order_detail` VALUES (48, '锅包肉', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/621487ba-0cea-42bb-acfb-c381413ef72e.jpg', 1024, 12, NULL, '正常', 1, 42.00);
INSERT INTO `order_detail` VALUES (49, '双人套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/95b6b76f-ddc1-4a88-9303-36bb3cbc2c4d.png', 1025, NULL, 3, NULL, 1, 128.00);
INSERT INTO `order_detail` VALUES (50, '家庭豪华套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/e3f5c215-4f6c-41ea-b184-19892f27913a.png', 1026, NULL, 6, NULL, 1, 388.00);
INSERT INTO `order_detail` VALUES (51, '单人豪华套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/99806447-1172-481a-a9cc-fc9476e976ab.png', 1027, NULL, 2, NULL, 1, 88.00);
INSERT INTO `order_detail` VALUES (52, '双人套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/95b6b76f-ddc1-4a88-9303-36bb3cbc2c4d.png', 1028, NULL, 3, NULL, 1, 128.00);
INSERT INTO `order_detail` VALUES (53, '家庭套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/779ac7be-283f-4ce4-ad04-07e113568dfa.png', 1029, NULL, 5, NULL, 1, 268.00);
INSERT INTO `order_detail` VALUES (54, '辣子鸡', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/7aa41cf4-e0bc-4e7a-8bed-e15f62b7588d.jpg', 1030, 5, NULL, '中辣', 1, 58.00);
INSERT INTO `order_detail` VALUES (55, '蒜蓉蒸虾', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/ace50027-cc50-4a94-a4d3-1a75ddb53209.jpg', 1031, 10, NULL, '正常', 1, 78.00);
INSERT INTO `order_detail` VALUES (56, '双人豪华套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/be393694-6deb-4abd-bdbf-b777c4690a3a.png', 1032, NULL, 4, NULL, 1, 188.00);
INSERT INTO `order_detail` VALUES (57, '双人套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/95b6b76f-ddc1-4a88-9303-36bb3cbc2c4d.png', 1033, NULL, 3, NULL, 1, 128.00);
INSERT INTO `order_detail` VALUES (58, '水煮鱼', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1b7068a6-3b55-4415-87ef-ba14005c3ea1.jpg', 1034, 1, NULL, '微辣', 1, 68.00);
INSERT INTO `order_detail` VALUES (59, '家庭豪华套餐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/e3f5c215-4f6c-41ea-b184-19892f27913a.png', 1035, NULL, 6, NULL, 1, 388.00);
INSERT INTO `order_detail` VALUES (60, '水煮鱼', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1b7068a6-3b55-4415-87ef-ba14005c3ea1.jpg', 1141, 1, -1, '特辣', 1, 68.00);
INSERT INTO `order_detail` VALUES (61, '麻婆豆腐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/d2983e28-778b-40bf-bb08-a2c846fba5ed.jpg', 1141, 2, -1, '中辣', 1, 28.00);
INSERT INTO `order_detail` VALUES (62, '白切鸡', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/e321e987-8857-4aef-9a87-99829639adb8.jpg', 1141, 9, -1, '', 1, 68.00);
INSERT INTO `order_detail` VALUES (63, '蒜蓉蒸虾', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/ace50027-cc50-4a94-a4d3-1a75ddb53209.jpg', 1141, 10, -1, '', 1, 78.00);
INSERT INTO `order_detail` VALUES (64, '可乐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/bb5d8864-176f-4076-a26c-9656a943367b.jpg', 1141, 18, -1, '', 1, 6.00);
INSERT INTO `order_detail` VALUES (65, '水煮鱼', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1b7068a6-3b55-4415-87ef-ba14005c3ea1.jpg', 1142, 1, -1, '中辣', 1, 68.00);
INSERT INTO `order_detail` VALUES (66, '水煮鱼', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1b7068a6-3b55-4415-87ef-ba14005c3ea1.jpg', 1143, 1, -1, '中辣', 1, 68.00);
INSERT INTO `order_detail` VALUES (67, '辣子鸡', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/7aa41cf4-e0bc-4e7a-8bed-e15f62b7588d.jpg', 1144, 5, -1, '特辣', 1, 58.00);
INSERT INTO `order_detail` VALUES (68, '水煮鱼', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1b7068a6-3b55-4415-87ef-ba14005c3ea1.jpg', 1145, 1, -1, '不辣', 1, 68.00);
INSERT INTO `order_detail` VALUES (69, '麻婆豆腐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/d2983e28-778b-40bf-bb08-a2c846fba5ed.jpg', 1146, 2, -1, '不辣', 1, 28.00);
INSERT INTO `order_detail` VALUES (70, '水煮鱼', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1b7068a6-3b55-4415-87ef-ba14005c3ea1.jpg', 1147, 1, -1, '', 1, 68.00);
INSERT INTO `order_detail` VALUES (71, '麻婆豆腐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/d2983e28-778b-40bf-bb08-a2c846fba5ed.jpg', 1148, 2, -1, '不辣', 1, 28.00);
INSERT INTO `order_detail` VALUES (72, '水煮鱼', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1b7068a6-3b55-4415-87ef-ba14005c3ea1.jpg', 1149, 1, -1, '不辣', 1, 68.00);
INSERT INTO `order_detail` VALUES (73, '水煮鱼', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1b7068a6-3b55-4415-87ef-ba14005c3ea1.jpg', 1150, 1, -1, '不辣', 1, 68.00);
INSERT INTO `order_detail` VALUES (74, '水煮鱼', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1b7068a6-3b55-4415-87ef-ba14005c3ea1.jpg', 1151, 1, -1, '', 1, 68.00);
INSERT INTO `order_detail` VALUES (75, '水煮鱼', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1b7068a6-3b55-4415-87ef-ba14005c3ea1.jpg', 1152, 1, -1, '', 1, 68.00);
INSERT INTO `order_detail` VALUES (76, '麻婆豆腐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/d2983e28-778b-40bf-bb08-a2c846fba5ed.jpg', 1153, 2, -1, '不辣', 1, 28.00);
INSERT INTO `order_detail` VALUES (77, '水煮鱼', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/1b7068a6-3b55-4415-87ef-ba14005c3ea1.jpg', 1154, 1, -1, '中辣', 1, 68.00);
INSERT INTO `order_detail` VALUES (78, '麻婆豆腐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/d2983e28-778b-40bf-bb08-a2c846fba5ed.jpg', 1154, 2, -1, '微辣', 1, 28.00);
INSERT INTO `order_detail` VALUES (79, '锅包肉', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/621487ba-0cea-42bb-acfb-c381413ef72e.jpg', 1154, 12, -1, '', 1, 42.00);
INSERT INTO `order_detail` VALUES (80, '米饭', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/ed64457e-e8cb-44f2-977f-a58d67680ea3.jpg', 1154, 15, -1, '', 1, 3.00);
INSERT INTO `order_detail` VALUES (81, '可乐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/bb5d8864-176f-4076-a26c-9656a943367b.jpg', 1154, 18, -1, '', 1, 6.00);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `number` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '订单号',
  `status` int NOT NULL DEFAULT 1 COMMENT '订单状态 1待付款 2待接单 3已接单 4派送中 5已完成 6已取消 7退款',
  `user_id` bigint NOT NULL COMMENT '下单用户',
  `address_book_id` bigint NOT NULL COMMENT '地址id',
  `order_time` datetime NOT NULL DEFAULT (now()) COMMENT '下单时间',
  `checkout_time` datetime NULL DEFAULT NULL COMMENT '结账时间',
  `pay_method` int NOT NULL DEFAULT 1 COMMENT '支付方式 1微信,2支付宝',
  `pay_status` tinyint NOT NULL DEFAULT 0 COMMENT '支付状态 0未支付 1已支付 2退款',
  `amount` decimal(10, 2) NOT NULL COMMENT '实收金额',
  `remark` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '备注',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '手机号',
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '地址',
  `user_name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '用户名称',
  `consignee` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '收货人',
  `cancel_reason` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '订单取消原因',
  `rejection_reason` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '订单拒绝原因',
  `cancel_time` datetime NULL DEFAULT NULL COMMENT '订单取消时间',
  `estimated_delivery_time` datetime NULL DEFAULT NULL COMMENT '预计送达时间',
  `delivery_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '配送状态  1立即送出  0选择具体时间',
  `delivery_time` datetime NULL DEFAULT NULL COMMENT '送达时间',
  `pack_amount` int NULL DEFAULT NULL COMMENT '打包费',
  `tableware_number` int NULL DEFAULT NULL COMMENT '餐具数量',
  `tableware_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '餐具数量状态  1按餐量提供  0选择具体数量',
  `version` int NULL DEFAULT 0 COMMENT '乐观锁',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unoin`(`user_id` ASC, `number` ASC) USING BTREE COMMENT '联合唯一索引',
  INDEX `idx_orders_status_estimated_time`(`status` ASC, `estimated_delivery_time` ASC) USING BTREE COMMENT '加速查询: status=4(派送中) AND estimated_delivery_time < 截止时间'
) ENGINE = InnoDB AUTO_INCREMENT = 1155 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, '202406150001', 5, 1, 1, '2024-06-15 12:00:00', '2024-06-15 12:05:00', 1, 1, 68.00, '少放辣', '13900139001', '北京市东城区王府井大街1号', '张小明', '张小明', NULL, NULL, NULL, '2024-06-15 12:30:00', 1, '2024-06-15 12:25:00', 2, 2, 1, 1);
INSERT INTO `orders` VALUES (2, '202406150002', 5, 2, 3, '2024-06-15 12:10:00', '2024-06-15 12:15:00', 1, 1, 128.00, '不要香菜', '13900139002', '北京市海淀区中关村大街1号', '李小红', '李小红', NULL, NULL, NULL, '2024-06-15 12:40:00', 1, '2024-06-15 12:35:00', 3, 2, 1, 1);
INSERT INTO `orders` VALUES (3, '202406150003', 5, 3, 4, '2024-06-15 12:20:00', '2024-06-15 12:25:00', 1, 1, 88.00, '', '13900139003', '北京市丰台区丰台路1号', '王小华', '王小华', NULL, NULL, NULL, '2024-06-15 12:50:00', 1, '2024-06-15 12:45:00', 2, 1, 1, 1);
INSERT INTO `orders` VALUES (4, '202406160001', 5, 1, 1, '2024-06-16 18:00:00', '2024-06-16 18:05:00', 1, 1, 268.00, '家庭聚餐', '13900139001', '北京市东城区王府井大街1号', '张小明', '张小明', NULL, NULL, NULL, '2024-06-16 18:40:00', 1, '2024-06-16 18:35:00', 5, 4, 1, 1);
INSERT INTO `orders` VALUES (5, '202406170001', 5, 4, 5, '2024-06-17 12:00:00', '2024-06-17 12:05:00', 1, 1, 58.00, '', '13900139004', '北京市西城区西单北大街1号', '赵小芳', '赵小芳', NULL, NULL, NULL, '2024-06-17 12:30:00', 1, '2024-06-17 12:25:00', 2, 1, 1, 1);
INSERT INTO `orders` VALUES (6, '202406180001', 4, 5, 6, '2024-06-18 12:00:00', '2024-06-18 12:05:00', 1, 1, 188.00, '双人餐', '13900139005', '北京市顺义区顺义大街1号', '孙小龙', '孙小龙', NULL, NULL, NULL, '2024-06-18 12:40:00', 1, NULL, 3, 2, 1, 1);
INSERT INTO `orders` VALUES (7, '202406180002', 5, 2, 3, '2024-06-18 12:10:00', '2024-06-18 12:15:00', 1, 1, 98.00, '', '13900139002', '北京市海淀区中关村大街1号', '李小红', '李小红', NULL, NULL, NULL, '2024-06-18 12:45:00', 1, '2026-06-25 01:00:00', 2, 1, 1, 1);
INSERT INTO `orders` VALUES (8, '202406180003', 6, 3, 4, '2024-06-18 12:20:00', NULL, 1, 0, 68.00, '', '13900139003', '北京市丰台区丰台路1号', '王小华', '王小华', '不想吃了', NULL, '2024-06-18 12:25:00', NULL, 1, NULL, 2, 1, 1, 1);
INSERT INTO `orders` VALUES (9, '2069819019930120192', 5, 6, 7, '2026-06-25 00:24:44', '2026-06-25 00:24:52', 1, 1, 122.00, '', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100号广西沿海铁路股份有限公司', NULL, 'lk', NULL, NULL, NULL, '2026-06-25 01:24:44', 1, NULL, 4, 0, 1, 0);
INSERT INTO `orders` VALUES (10, '2069826978324164608', 6, 6, 7, '2026-06-25 00:56:22', NULL, 1, 0, 275.00, '', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100号广西沿海铁路股份有限公司', NULL, 'lk', NULL, NULL, '2026-06-25 01:12:00', '2026-06-25 01:56:21', 1, NULL, 1, 0, 1, 0);
INSERT INTO `orders` VALUES (11, '2069947706696642560', 5, 6, 7, '2026-06-25 08:56:06', '2026-06-25 08:56:18', 1, 1, 92.00, '', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100号广西沿海铁路股份有限公司', NULL, 'lk', NULL, NULL, NULL, '2026-06-25 09:56:05', 1, NULL, 2, 0, 1, 0);
INSERT INTO `orders` VALUES (12, '2069948582999896064', 6, 6, 7, '2026-06-25 08:59:35', '2026-06-25 08:59:44', 1, 1, 92.00, '2ewerw', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100号广西沿海铁路股份有限公司', NULL, 'lk', '菜品已销售完，暂时无法接单', NULL, '2026-06-25 09:02:27', '2026-06-25 09:59:34', 1, NULL, 2, 0, 1, 0);
INSERT INTO `orders` VALUES (13, '2069948923032121344', 6, 6, 7, '2026-06-25 09:00:56', '2026-06-25 09:00:57', 1, 1, 75.00, '', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100号广西沿海铁路股份有限公司', NULL, 'lk', NULL, '订单量较多，暂时无法接单', '2026-06-25 09:02:16', '2026-06-25 10:00:55', 1, NULL, 1, 0, 1, 0);
INSERT INTO `orders` VALUES (14, '2069949441158758400', 6, 6, 7, '2026-06-25 09:02:59', '2026-06-25 09:03:01', 1, 1, 75.00, '', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100号广西沿海铁路股份有限公司', NULL, 'lk', NULL, '关门了', '2026-06-25 09:03:44', '2026-06-25 10:02:58', 1, NULL, 1, 0, 1, 0);
INSERT INTO `orders` VALUES (15, '2069952082521702400', 6, 6, 7, '2026-06-25 09:13:29', NULL, 1, 0, 246.00, '', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100号广西沿海铁路股份有限公司', NULL, 'lk', NULL, NULL, '2026-06-25 09:29:00', '2026-06-25 10:13:28', 1, NULL, 5, 0, 1, 0);
INSERT INTO `orders` VALUES (1001, 'ORD20260526001', 5, 1, 1, '2026-05-26 11:30:00', '2026-05-26 11:35:00', 1, 1, 68.00, '少辣', '13800138001', '新港中路123号', '张三丰', '张三丰', NULL, NULL, NULL, '2026-05-26 12:00:00', 1, '2026-05-26 12:15:00', 2, 2, 1, 0);
INSERT INTO `orders` VALUES (1002, 'ORD20260526002', 5, 2, 3, '2026-05-26 17:20:00', '2026-05-26 17:25:00', 2, 1, 128.00, NULL, '13800138002', '科技园南路789号', '李四娘', '李四娘', NULL, NULL, NULL, '2026-05-26 18:00:00', 1, '2026-05-26 18:20:00', 3, 2, 1, 0);
INSERT INTO `orders` VALUES (1003, 'ORD20260527001', 4, 3, 4, '2026-05-27 12:10:00', '2026-05-27 12:15:00', 1, 1, 38.00, '多放花生', '13800138003', '东风中路321号', '王五哥', '王五哥', NULL, NULL, NULL, '2026-05-27 12:45:00', 1, NULL, 1, 1, 1, 0);
INSERT INTO `orders` VALUES (1004, 'ORD20260527002', 2, 4, 5, '2026-05-27 18:00:00', '2026-05-27 18:05:00', 1, 1, 88.00, NULL, '13800138004', '深南大道6001号', '赵六妹', '赵六妹', NULL, NULL, NULL, '2026-05-27 18:40:00', 1, NULL, 2, 1, 1, 0);
INSERT INTO `orders` VALUES (1005, 'ORD20260528001', 6, 5, 6, '2026-05-28 11:45:00', NULL, 1, 0, 45.00, '不要葱', '13800138005', '桂城街道桂澜路88号', '孙七爷', '孙七爷', '用户临时取消', NULL, '2026-05-28 11:50:00', '2026-05-28 12:20:00', 1, NULL, 1, 1, 1, 0);
INSERT INTO `orders` VALUES (1006, 'ORD20260528002', 5, 6, 7, '2026-05-28 19:30:00', '2026-05-28 19:35:00', 2, 1, 188.00, '加辣', '13800138006', '白云大道北100号', '周八姐', '周八姐', NULL, NULL, NULL, '2026-05-28 20:10:00', 1, '2026-05-28 20:30:00', 4, 2, 1, 0);
INSERT INTO `orders` VALUES (1007, 'ORD20260529001', 3, 7, 8, '2026-05-29 12:20:00', '2026-05-29 12:25:00', 1, 1, 268.00, NULL, '13800138007', '宝安大道3000号', '吴九郎', '吴九郎', NULL, NULL, NULL, '2026-05-29 13:00:00', 1, NULL, 5, 3, 1, 0);
INSERT INTO `orders` VALUES (1008, 'ORD20260529002', 5, 8, 9, '2026-05-29 18:45:00', '2026-05-29 18:50:00', 1, 1, 58.00, '少油', '13800138008', '开创大道666号', '郑十妹', '郑十妹', NULL, NULL, NULL, '2026-05-29 19:20:00', 1, '2026-05-29 19:40:00', 1, 1, 1, 0);
INSERT INTO `orders` VALUES (1009, 'ORD20260530001', 4, 9, 10, '2026-05-30 11:50:00', '2026-05-30 11:55:00', 2, 1, 128.00, '不要香菜', '13800138009', '季华五路28号', '陈大勇', '陈大勇', NULL, NULL, NULL, '2026-05-30 12:30:00', 1, NULL, 3, 2, 1, 0);
INSERT INTO `orders` VALUES (1010, 'ORD20260530002', 2, 10, 11, '2026-05-30 19:00:00', '2026-05-30 19:05:00', 1, 1, 68.00, NULL, '13800138010', '深盐路111号', '林小美', '林小美', NULL, NULL, NULL, '2026-05-30 19:40:00', 1, NULL, 2, 1, 1, 0);
INSERT INTO `orders` VALUES (1011, 'ORD20260531001', 5, 11, 12, '2026-05-31 12:30:00', '2026-05-31 12:35:00', 1, 1, 388.00, '家庭聚餐', '13800138011', '中山八路50号', '黄药师', '黄药师', NULL, NULL, NULL, '2026-05-31 13:20:00', 1, '2026-05-31 13:45:00', 5, 4, 1, 0);
INSERT INTO `orders` VALUES (1012, 'ORD20260531002', 6, 12, 13, '2026-05-31 18:10:00', NULL, 2, 0, 88.00, NULL, '13800138012', '龙翔大道200号', '杨过', '杨过', '商家超时未接单', NULL, '2026-05-31 18:25:00', '2026-05-31 18:50:00', 1, NULL, 2, 1, 1, 0);
INSERT INTO `orders` VALUES (1013, 'ORD20260601001', 5, 13, 14, '2026-06-01 11:40:00', '2026-06-01 11:45:00', 1, 1, 128.00, '少盐', '13800138013', '市桥街繁华路18号', '小龙女', '小龙女', NULL, NULL, NULL, '2026-06-01 12:20:00', 1, '2026-06-01 12:35:00', 3, 2, 1, 0);
INSERT INTO `orders` VALUES (1014, 'ORD20260601002', 3, 14, 15, '2026-06-01 19:20:00', '2026-06-01 19:25:00', 1, 1, 268.00, NULL, '13800138014', '大良街道清晖路22号', '郭靖', '郭靖', NULL, NULL, NULL, '2026-06-01 20:00:00', 1, NULL, 4, 3, 1, 0);
INSERT INTO `orders` VALUES (1015, 'ORD20260602001', 5, 15, 16, '2026-06-02 12:15:00', '2026-06-02 12:20:00', 2, 1, 78.00, '蒜蓉多些', '13800138015', '迎宾大道99号', '黄蓉', '黄蓉', NULL, NULL, NULL, '2026-06-02 12:55:00', 1, '2026-06-02 13:10:00', 2, 1, 1, 0);
INSERT INTO `orders` VALUES (1016, 'ORD20260602002', 4, 1, 2, '2026-06-02 18:30:00', '2026-06-02 18:35:00', 1, 1, 36.00, '打包', '13800138001', '天河东路456号', '张三丰', '张三丰', NULL, NULL, NULL, '2026-06-02 19:00:00', 1, NULL, 1, 1, 1, 0);
INSERT INTO `orders` VALUES (1017, 'ORD20260603001', 2, 2, 3, '2026-06-03 11:55:00', '2026-06-03 12:00:00', 1, 1, 188.00, NULL, '13800138002', '科技园南路789号', '李四娘', '李四娘', NULL, NULL, NULL, '2026-06-03 12:40:00', 1, NULL, 4, 2, 1, 0);
INSERT INTO `orders` VALUES (1018, 'ORD20260603002', 5, 3, 4, '2026-06-03 19:10:00', '2026-06-03 19:15:00', 2, 1, 88.00, '加辣', '13800138003', '东风中路321号', '王五哥', '王五哥', NULL, NULL, NULL, '2026-06-03 19:50:00', 1, '2026-06-03 20:05:00', 2, 2, 1, 0);
INSERT INTO `orders` VALUES (1019, 'ORD20260604001', 5, 4, 5, '2026-06-04 12:25:00', '2026-06-04 12:30:00', 1, 1, 128.00, '米饭多一份', '13800138004', '深南大道6001号', '赵六妹', '赵六妹', NULL, NULL, NULL, '2026-06-04 13:00:00', 1, '2026-06-04 13:20:00', 3, 2, 1, 0);
INSERT INTO `orders` VALUES (1020, 'ORD20260604002', 6, 5, 6, '2026-06-04 18:40:00', NULL, 1, 0, 68.00, '不要辣', '13800138005', '桂城街道桂澜路88号', '孙七爷', '孙七爷', '已取消-用户修改地址', NULL, '2026-06-04 18:45:00', '2026-06-04 19:20:00', 1, NULL, 1, 1, 1, 0);
INSERT INTO `orders` VALUES (1021, 'ORD20260605001', 3, 6, 7, '2026-06-05 11:35:00', '2026-06-05 11:40:00', 1, 1, 60.00, NULL, '13800138006', '白云大道北100号', '周八姐', '周八姐', NULL, NULL, NULL, '2026-06-05 12:10:00', 1, NULL, 1, 1, 1, 0);
INSERT INTO `orders` VALUES (1022, 'ORD20260605002', 5, 7, 8, '2026-06-05 19:50:00', '2026-06-05 19:55:00', 2, 1, 188.00, '多放辣椒', '13800138007', '宝安大道3000号', '吴九郎', '吴九郎', NULL, NULL, NULL, '2026-06-05 20:30:00', 1, '2026-06-05 20:50:00', 4, 2, 1, 0);
INSERT INTO `orders` VALUES (1023, 'ORD20260606001', 4, 8, 9, '2026-06-06 12:45:00', '2026-06-06 12:50:00', 1, 1, 268.00, '家庭聚餐', '13800138008', '开创大道666号', '郑十妹', '郑十妹', NULL, NULL, NULL, '2026-06-06 13:30:00', 1, NULL, 5, 3, 1, 0);
INSERT INTO `orders` VALUES (1024, 'ORD20260606002', 5, 9, 10, '2026-06-06 18:15:00', '2026-06-06 18:20:00', 1, 1, 42.00, NULL, '13800138009', '季华五路28号', '陈大勇', '陈大勇', NULL, NULL, NULL, '2026-06-06 18:50:00', 1, '2026-06-06 19:05:00', 1, 1, 1, 0);
INSERT INTO `orders` VALUES (1025, 'ORD20260607001', 2, 10, 11, '2026-06-07 11:50:00', '2026-06-07 11:55:00', 2, 1, 128.00, '不加香菜', '13800138010', '深盐路111号', '林小美', '林小美', NULL, NULL, NULL, '2026-06-07 12:30:00', 1, NULL, 3, 2, 1, 0);
INSERT INTO `orders` VALUES (1026, 'ORD20260607002', 5, 11, 12, '2026-06-07 19:30:00', '2026-06-07 19:35:00', 1, 1, 388.00, NULL, '13800138011', '中山八路50号', '黄药师', '黄药师', NULL, NULL, NULL, '2026-06-07 20:20:00', 1, '2026-06-07 20:45:00', 5, 4, 1, 0);
INSERT INTO `orders` VALUES (1027, 'ORD20260608001', 3, 12, 13, '2026-06-08 12:10:00', '2026-06-08 12:15:00', 1, 1, 88.00, '少油', '13800138012', '龙翔大道200号', '杨过', '杨过', NULL, NULL, NULL, '2026-06-08 12:50:00', 1, NULL, 2, 1, 1, 0);
INSERT INTO `orders` VALUES (1028, 'ORD20260608002', 5, 13, 14, '2026-06-08 18:50:00', '2026-06-08 18:55:00', 1, 1, 128.00, NULL, '13800138013', '市桥街繁华路18号', '小龙女', '小龙女', NULL, NULL, NULL, '2026-06-08 19:30:00', 1, '2026-06-08 19:45:00', 3, 2, 1, 0);
INSERT INTO `orders` VALUES (1029, 'ORD20260609001', 4, 14, 15, '2026-06-09 11:40:00', '2026-06-09 11:45:00', 2, 1, 268.00, '多放蒜', '13800138014', '大良街道清晖路22号', '郭靖', '郭靖', NULL, NULL, NULL, '2026-06-09 12:30:00', 1, NULL, 4, 3, 1, 0);
INSERT INTO `orders` VALUES (1030, 'ORD20260609002', 5, 15, 16, '2026-06-09 19:10:00', '2026-06-09 19:15:00', 1, 1, 58.00, '不要葱', '13800138015', '迎宾大道99号', '黄蓉', '黄蓉', NULL, NULL, NULL, '2026-06-09 19:45:00', 1, '2026-06-09 20:00:00', 1, 1, 1, 0);
INSERT INTO `orders` VALUES (1031, 'ORD20260610001', 5, 1, 1, '2026-06-10 12:20:00', '2026-06-10 12:25:00', 1, 1, 78.00, '加辣', '13800138001', '新港中路123号', '张三丰', '张三丰', NULL, NULL, NULL, '2026-06-10 13:00:00', 1, '2026-06-10 13:15:00', 2, 1, 1, 0);
INSERT INTO `orders` VALUES (1032, 'ORD20260610002', 3, 2, 3, '2026-06-10 18:30:00', '2026-06-10 18:35:00', 2, 1, 188.00, NULL, '13800138002', '科技园南路789号', '李四娘', '李四娘', NULL, NULL, NULL, '2026-06-10 19:10:00', 1, NULL, 4, 2, 1, 0);
INSERT INTO `orders` VALUES (1033, 'ORD20260611001', 2, 3, 4, '2026-06-11 11:55:00', '2026-06-11 12:00:00', 1, 1, 128.00, '少盐', '13800138003', '东风中路321号', '王五哥', '王五哥', NULL, NULL, NULL, '2026-06-11 12:40:00', 1, NULL, 3, 2, 1, 0);
INSERT INTO `orders` VALUES (1034, 'ORD20260611002', 5, 4, 5, '2026-06-11 19:20:00', '2026-06-11 19:25:00', 1, 1, 68.00, NULL, '13800138004', '深南大道6001号', '赵六妹', '赵六妹', NULL, NULL, NULL, '2026-06-11 20:00:00', 1, '2026-06-11 20:15:00', 2, 1, 1, 0);
INSERT INTO `orders` VALUES (1035, 'ORD20260612001', 5, 5, 6, '2026-06-12 12:30:00', '2026-06-12 12:35:00', 1, 1, 388.00, '家庭聚餐', '13800138005', '桂城街道桂澜路88号', '孙七爷', '孙七爷', NULL, NULL, NULL, '2026-06-12 13:20:00', 1, '2026-06-12 13:45:00', 5, 4, 1, 0);
INSERT INTO `orders` VALUES (1141, '2069962672023662592', 6, 6, 7, '2026-06-25 09:55:34', '2026-06-25 09:55:52', 1, 1, 259.00, '啥叫看都不看就把空间分布', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100-3号10广西财经学院明秀校区', NULL, 'lk', NULL, NULL, '2026-06-25 09:56:29', '2026-06-25 10:55:33', 1, NULL, 5, 0, 1, 1);
INSERT INTO `orders` VALUES (1142, '2069963049083203584', 5, 6, 7, '2026-06-25 09:57:04', '2026-06-25 09:57:04', 1, 1, 75.00, '', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100-3号10广西财经学院明秀校区', NULL, 'lk', NULL, NULL, NULL, '2026-06-25 10:57:03', 1, NULL, 1, 0, 1, 0);
INSERT INTO `orders` VALUES (1143, '2069964884082814976', 6, 6, 7, '2026-06-25 10:04:21', '2026-06-25 10:04:22', 1, 1, 75.00, '', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100-3号10广西财经学院明秀校区', NULL, 'lk', NULL, '订单量较多，暂时无法接单', '2026-06-25 10:04:32', '2026-06-25 11:04:21', 1, NULL, 1, 0, 1, 0);
INSERT INTO `orders` VALUES (1144, '2069965098692767744', 6, 6, 7, '2026-06-25 10:05:12', '2026-06-25 10:05:23', 1, 1, 65.00, '', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100-3号10广西财经学院明秀校区', NULL, 'lk', '菜品已销售完，暂时无法接单', NULL, '2026-06-25 10:05:31', '2026-06-25 11:05:12', 1, NULL, 1, 0, 1, 0);
INSERT INTO `orders` VALUES (1145, '2069966932337618944', 6, 6, 7, '2026-06-25 10:12:29', '2026-06-25 10:12:31', 1, 1, 75.00, '', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100-3号10广西财经学院明秀校区', NULL, 'lk', NULL, NULL, '2026-06-25 10:12:38', '2026-06-25 11:12:29', 1, NULL, 1, 0, 1, 1);
INSERT INTO `orders` VALUES (1146, '2069967202811412480', 6, 6, 7, '2026-06-25 10:13:34', '2026-06-25 10:13:35', 1, 1, 35.00, '', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100-3号10广西财经学院明秀校区', NULL, 'lk', NULL, NULL, '2026-06-25 10:13:40', '2026-06-25 11:13:33', 1, NULL, 1, 0, 1, 1);
INSERT INTO `orders` VALUES (1147, '2069967475646693376', 6, 6, 7, '2026-06-25 10:14:39', '2026-06-25 10:14:41', 1, 1, 75.00, '', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100-3号10广西财经学院明秀校区', NULL, 'lk', NULL, NULL, '2026-06-25 10:14:46', '2026-06-25 11:14:38', 1, NULL, 1, 0, 1, 1);
INSERT INTO `orders` VALUES (1148, '2069967867872837632', 2, 6, 7, '2026-06-25 10:16:13', '2026-06-25 10:16:13', 1, 1, 35.00, '', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100-3号10广西财经学院明秀校区', NULL, 'lk', NULL, NULL, NULL, '2026-06-25 11:16:12', 1, NULL, 1, 0, 1, 0);
INSERT INTO `orders` VALUES (1149, '2069968012723126272', 2, 6, 7, '2026-06-25 10:16:47', '2026-06-25 10:16:49', 1, 1, 75.00, '', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100-3号10广西财经学院明秀校区', NULL, 'lk', NULL, NULL, NULL, '2026-06-25 11:16:47', 1, NULL, 1, 0, 1, 0);
INSERT INTO `orders` VALUES (1150, '2069968077298630656', 2, 6, 7, '2026-06-25 10:17:02', '2026-06-25 10:17:03', 1, 1, 75.00, '', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100-3号10广西财经学院明秀校区', NULL, 'lk', NULL, NULL, NULL, '2026-06-25 11:17:02', 1, NULL, 1, 0, 1, 0);
INSERT INTO `orders` VALUES (1151, '2069968360321875968', 2, 6, 7, '2026-06-25 10:18:10', '2026-06-25 10:18:11', 1, 1, 75.00, '', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100-3号10广西财经学院明秀校区', NULL, 'lk', NULL, NULL, NULL, '2026-06-25 11:18:09', 1, NULL, 1, 0, 1, 0);
INSERT INTO `orders` VALUES (1152, '2069969817544802304', 6, 6, 7, '2026-06-25 10:23:57', '2026-06-25 10:23:59', 1, 1, 75.00, '', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100-3号10广西财经学院明秀校区', NULL, 'lk', NULL, NULL, '2026-06-25 10:24:08', '2026-06-25 11:23:56', 1, NULL, 1, 0, 1, 1);
INSERT INTO `orders` VALUES (1153, '2069969904748576768', 2, 6, 7, '2026-06-25 10:24:18', '2026-06-25 10:24:19', 1, 1, 35.00, '', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路100-3号10广西财经学院明秀校区', NULL, 'lk', NULL, NULL, NULL, '2026-06-25 11:24:18', 1, NULL, 1, 0, 1, 0);
INSERT INTO `orders` VALUES (1154, '2069973432816746496', 5, 6, 7, '2026-06-25 10:38:19', '2026-06-25 10:38:43', 1, 1, 158.00, '个人的的', '17776248496', '广西壮族自治区南宁市西乡塘区西乡塘街道明秀西路辅路广西财经学院明秀校区', NULL, 'lk', NULL, NULL, NULL, '2026-06-25 11:38:19', 1, NULL, 5, 0, 1, 0);

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` bigint NOT NULL COMMENT '订单id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `score` int NOT NULL COMMENT '评分（1-5）',
  `comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '评价内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_order_id`(`order_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '评价表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of review
-- ----------------------------
INSERT INTO `review` VALUES (1, 1, 1, 5, '水煮鱼味道很正宗，麻辣鲜香，配送也很快！', '2024-06-15 12:35:00');
INSERT INTO `review` VALUES (2, 2, 2, 4, '双人套餐分量很足，性价比高，就是等餐时间有点长。', '2024-06-15 12:45:00');
INSERT INTO `review` VALUES (3, 3, 3, 5, '单人豪华套餐很棒，菜品丰富，味道好！', '2024-06-15 12:55:00');
INSERT INTO `review` VALUES (4, 4, 1, 5, '家庭套餐非常适合聚餐，菜品丰富，家人都很满意！', '2024-06-16 18:50:00');
INSERT INTO `review` VALUES (5, 5, 4, 4, '单人套餐还不错，就是分量可以再多一点。', '2024-06-17 12:35:00');
INSERT INTO `review` VALUES (6, 11, 6, 5, 'hao', '2026-06-25 08:59:20');
INSERT INTO `review` VALUES (7, 1001, 1, 5, '水煮鱼非常好吃，下次还来！', '2026-05-26 12:20:00');
INSERT INTO `review` VALUES (8, 1002, 2, 4, '麻婆豆腐不错，可乐有点淡', '2026-05-26 18:30:00');
INSERT INTO `review` VALUES (9, 1006, 6, 5, '双人套餐很划算，分量足', '2026-05-28 20:40:00');
INSERT INTO `review` VALUES (10, 1008, 8, 3, '辣子鸡太辣了，不太适应', '2026-05-29 19:50:00');
INSERT INTO `review` VALUES (11, 1011, 11, 5, '家庭豪华套餐非常丰盛，家人满意', '2026-05-31 14:00:00');
INSERT INTO `review` VALUES (12, 1013, 13, 4, '双人套餐味道好，配送快', '2026-06-01 12:50:00');
INSERT INTO `review` VALUES (13, 1015, 15, 5, '蒜蓉蒸虾很新鲜，好评', '2026-06-02 13:20:00');
INSERT INTO `review` VALUES (14, 1018, 3, 4, '单人豪华套餐性价比高', '2026-06-03 20:10:00');
INSERT INTO `review` VALUES (15, 1019, 4, 5, '双人套餐完美，下次点家庭套餐', '2026-06-04 13:30:00');
INSERT INTO `review` VALUES (16, 1022, 7, 4, '双人豪华套餐，辣度合适', '2026-06-05 21:00:00');
INSERT INTO `review` VALUES (17, 1024, 9, 3, '锅包肉有点硬，一般般', '2026-06-06 19:15:00');
INSERT INTO `review` VALUES (18, 1026, 11, 5, '家庭豪华套餐，每次必点', '2026-06-07 21:00:00');
INSERT INTO `review` VALUES (19, 1028, 13, 5, '双人套餐，味道稳定', '2026-06-08 20:00:00');
INSERT INTO `review` VALUES (20, 1030, 15, 4, '辣子鸡不错，就是量少点', '2026-06-09 20:10:00');
INSERT INTO `review` VALUES (21, 1031, 1, 5, '蒜蓉蒸虾，我的最爱', '2026-06-10 13:30:00');
INSERT INTO `review` VALUES (22, 1034, 4, 4, '水煮鱼有点咸，但整体好', '2026-06-11 20:30:00');
INSERT INTO `review` VALUES (23, 1035, 5, 5, '家庭豪华套餐，聚会首选', '2026-06-12 14:00:00');
INSERT INTO `review` VALUES (24, 1142, 6, 5, '好吃', '2026-06-25 09:57:33');
INSERT INTO `review` VALUES (25, 1154, 6, 5, '好吃', '2026-06-25 10:40:36');

-- ----------------------------
-- Table structure for setmeal
-- ----------------------------
DROP TABLE IF EXISTS `setmeal`;
CREATE TABLE `setmeal`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_id` bigint NOT NULL COMMENT '菜品分类id',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '套餐名称',
  `price` decimal(10, 2) NOT NULL COMMENT '套餐价格',
  `status` int NULL DEFAULT 1 COMMENT '售卖状态 0:停售 1:起售',
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '描述信息',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '图片',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_user` bigint NULL DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_setmeal_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '套餐' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of setmeal
-- ----------------------------
INSERT INTO `setmeal` VALUES (1, 11, '单人精选套餐', 60.00, 1, '宫保鸡丁+米饭+可乐', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/ce289fec-ecda-4309-a742-daa0c9537206.png', '2024-01-01 00:00:00', '2026-06-25 08:54:30', 1, 1);
INSERT INTO `setmeal` VALUES (2, 11, '单人豪华套餐', 88.00, 1, '水煮鱼+麻婆豆腐+米饭+柠檬茶', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/99806447-1172-481a-a9cc-fc9476e976ab.png', '2024-01-01 00:00:00', '2026-06-25 08:38:07', 1, 1);
INSERT INTO `setmeal` VALUES (3, 12, '双人套餐', 128.00, 1, '宫保鸡丁+回锅肉+地三鲜+米饭2份+可乐2杯', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/95b6b76f-ddc1-4a88-9303-36bb3cbc2c4d.png', '2024-01-01 00:00:00', '2026-06-25 08:38:14', 1, 1);
INSERT INTO `setmeal` VALUES (4, 12, '双人豪华套餐', 188.00, 1, '水煮鱼+剁椒鱼头+锅包肉+地三鲜+米饭2份+柠檬茶2杯', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/be393694-6deb-4abd-bdbf-b777c4690a3a.png', '2024-01-01 00:00:00', '2026-06-25 08:40:18', 1, 1);
INSERT INTO `setmeal` VALUES (5, 13, '家庭套餐', 268.00, 1, '水煮鱼+剁椒鱼头+白切鸡+锅包肉+小鸡炖蘑菇+米饭4份+可乐4杯', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/779ac7be-283f-4ce4-ad04-07e113568dfa.png', '2024-01-01 00:00:00', '2026-06-25 10:45:14', 1, 1);
INSERT INTO `setmeal` VALUES (6, 13, '家庭豪华套餐', 388.00, 1, '水煮鱼+辣子鸡+剁椒鱼头+白切鸡+蒜蓉蒸虾+小鸡炖蘑菇+米饭5份+柠檬茶5杯', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/e3f5c215-4f6c-41ea-b184-19892f27913a.png', '2024-01-01 00:00:00', '2026-06-25 08:41:32', 1, 1);
INSERT INTO `setmeal` VALUES (7, 11, '套餐', 150.00, 0, '白切鸡，剁椒鱼头，水煮鱼', 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/996345cd-28bd-40ad-807b-2486a2fcdbf7.png', '2026-06-25 10:42:01', '2026-06-25 10:45:27', 1, 1);

-- ----------------------------
-- Table structure for setmeal_dish
-- ----------------------------
DROP TABLE IF EXISTS `setmeal_dish`;
CREATE TABLE `setmeal_dish`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `setmeal_id` bigint NULL DEFAULT NULL COMMENT '套餐id',
  `dish_id` bigint NULL DEFAULT NULL COMMENT '菜品id',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '菜品名称 （冗余字段）',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '菜品单价（冗余字段）',
  `copies` int NULL DEFAULT NULL COMMENT '菜品份数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '套餐菜品关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of setmeal_dish
-- ----------------------------
INSERT INTO `setmeal_dish` VALUES (34, NULL, 18, '可乐', 6.00, 1);
INSERT INTO `setmeal_dish` VALUES (35, NULL, 15, '米饭', 3.00, 1);
INSERT INTO `setmeal_dish` VALUES (36, NULL, 3, '宫保鸡丁', 38.00, 1);
INSERT INTO `setmeal_dish` VALUES (37, NULL, 19, '柠檬茶', 8.00, 1);
INSERT INTO `setmeal_dish` VALUES (38, NULL, 15, '米饭', 3.00, 1);
INSERT INTO `setmeal_dish` VALUES (39, NULL, 2, '麻婆豆腐', 28.00, 1);
INSERT INTO `setmeal_dish` VALUES (40, NULL, 1, '水煮鱼', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (41, NULL, 18, '可乐', 6.00, 2);
INSERT INTO `setmeal_dish` VALUES (42, NULL, 15, '米饭', 3.00, 2);
INSERT INTO `setmeal_dish` VALUES (43, NULL, 13, '地三鲜', 26.00, 1);
INSERT INTO `setmeal_dish` VALUES (44, NULL, 4, '回锅肉', 45.00, 1);
INSERT INTO `setmeal_dish` VALUES (45, NULL, 3, '宫保鸡丁', 38.00, 1);
INSERT INTO `setmeal_dish` VALUES (46, NULL, 19, '柠檬茶', 8.00, 2);
INSERT INTO `setmeal_dish` VALUES (47, NULL, 15, '米饭', 3.00, 2);
INSERT INTO `setmeal_dish` VALUES (48, NULL, 13, '地三鲜', 26.00, 1);
INSERT INTO `setmeal_dish` VALUES (49, NULL, 12, '锅包肉', 42.00, 1);
INSERT INTO `setmeal_dish` VALUES (50, NULL, 6, '剁椒鱼头', 88.00, 1);
INSERT INTO `setmeal_dish` VALUES (51, NULL, 1, '水煮鱼', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (52, NULL, 19, '柠檬茶', 8.00, 2);
INSERT INTO `setmeal_dish` VALUES (53, NULL, 13, '地三鲜', 26.00, 1);
INSERT INTO `setmeal_dish` VALUES (54, NULL, 12, '锅包肉', 42.00, 1);
INSERT INTO `setmeal_dish` VALUES (55, NULL, 1, '水煮鱼', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (56, NULL, 6, '剁椒鱼头', 88.00, 1);
INSERT INTO `setmeal_dish` VALUES (57, NULL, 15, '米饭', 3.00, 1);
INSERT INTO `setmeal_dish` VALUES (58, NULL, 18, '可乐', 6.00, 4);
INSERT INTO `setmeal_dish` VALUES (59, NULL, 15, '米饭', 3.00, 4);
INSERT INTO `setmeal_dish` VALUES (60, NULL, 14, '小鸡炖蘑菇', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (61, NULL, 12, '锅包肉', 42.00, 1);
INSERT INTO `setmeal_dish` VALUES (62, NULL, 9, '白切鸡', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (63, NULL, 6, '剁椒鱼头', 88.00, 1);
INSERT INTO `setmeal_dish` VALUES (64, NULL, 1, '水煮鱼', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (65, NULL, 18, '可乐', 6.00, 4);
INSERT INTO `setmeal_dish` VALUES (66, NULL, 15, '米饭', 3.00, 4);
INSERT INTO `setmeal_dish` VALUES (67, NULL, 14, '小鸡炖蘑菇', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (68, NULL, 12, '锅包肉', 42.00, 1);
INSERT INTO `setmeal_dish` VALUES (69, NULL, 9, '白切鸡', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (70, NULL, 6, '剁椒鱼头', 88.00, 1);
INSERT INTO `setmeal_dish` VALUES (71, NULL, 1, '水煮鱼', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (72, NULL, 18, '可乐', 6.00, 4);
INSERT INTO `setmeal_dish` VALUES (73, NULL, 15, '米饭', 3.00, 4);
INSERT INTO `setmeal_dish` VALUES (74, NULL, 12, '锅包肉', 42.00, 1);
INSERT INTO `setmeal_dish` VALUES (75, NULL, 9, '白切鸡', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (76, NULL, 1, '水煮鱼', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (77, NULL, 6, '剁椒鱼头', 88.00, 1);
INSERT INTO `setmeal_dish` VALUES (78, NULL, 14, '小鸡炖蘑菇', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (79, NULL, 19, '柠檬茶', 8.00, 5);
INSERT INTO `setmeal_dish` VALUES (80, NULL, 15, '米饭', 3.00, 5);
INSERT INTO `setmeal_dish` VALUES (81, NULL, 14, '小鸡炖蘑菇', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (82, NULL, 10, '蒜蓉蒸虾', 78.00, 1);
INSERT INTO `setmeal_dish` VALUES (83, NULL, 9, '白切鸡', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (84, NULL, 6, '剁椒鱼头', 88.00, 1);
INSERT INTO `setmeal_dish` VALUES (85, NULL, 5, '辣子鸡', 58.00, 1);
INSERT INTO `setmeal_dish` VALUES (86, NULL, 1, '水煮鱼', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (87, NULL, 6, '剁椒鱼头', 88.00, 1);
INSERT INTO `setmeal_dish` VALUES (88, NULL, 1, '水煮鱼', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (89, NULL, 6, '剁椒鱼头', 88.00, 1);
INSERT INTO `setmeal_dish` VALUES (90, NULL, 1, '水煮鱼', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (91, NULL, 18, '可乐', 6.00, 1);
INSERT INTO `setmeal_dish` VALUES (92, NULL, 15, '米饭', 3.00, 1);
INSERT INTO `setmeal_dish` VALUES (93, NULL, 3, '宫保鸡丁', 38.00, 1);
INSERT INTO `setmeal_dish` VALUES (97, NULL, 1, '水煮鱼', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (98, NULL, 1, '水煮鱼', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (99, NULL, 1, '水煮鱼', 68.00, 1);
INSERT INTO `setmeal_dish` VALUES (100, NULL, 6, '剁椒鱼头', 88.00, 1);
INSERT INTO `setmeal_dish` VALUES (101, NULL, 9, '白切鸡', 68.00, 1);

-- ----------------------------
-- Table structure for shopping_cart
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '商品名称',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '图片',
  `user_id` bigint NOT NULL COMMENT '主键',
  `dish_id` bigint NULL DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint NULL DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT '口味',
  `number` int NOT NULL DEFAULT 1 COMMENT '数量',
  `create_time` datetime NULL DEFAULT (now()) COMMENT '创建时间',
  `amount` decimal(10, 0) NULL DEFAULT NULL COMMENT '金额(弃用字段)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_item`(`user_id` ASC, `dish_id` ASC, `setmeal_id` ASC, `dish_flavor` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '购物车' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shopping_cart
-- ----------------------------
INSERT INTO `shopping_cart` VALUES (1, '麻婆豆腐', 'https://example.com/dish/mapodoufu.jpg', 1, 2, NULL, '微辣', 1, '2024-06-18 13:00:00', 28);
INSERT INTO `shopping_cart` VALUES (2, '米饭', 'https://example.com/dish/mifan.jpg', 1, 15, NULL, '-1', 2, '2024-06-18 13:00:00', 3);
INSERT INTO `shopping_cart` VALUES (3, '单人精选套餐', 'https://example.com/setmeal/danren.jpg', 2, NULL, 1, '-1', 1, '2024-06-18 13:00:00', 58);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `openid` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '微信用户唯一标识',
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '身份证号',
  `avatar` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '头像',
  `create_time` datetime NULL DEFAULT NULL,
  `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '密码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 82 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '用户信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'oXXXX1', '张小明', '13900139001', '1', '110101199501011111', 'https://example.com/avatar1.jpg', '2024-01-15 10:00:00', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `user` VALUES (2, 'oXXXX2', '李小红', '13900139002', '0', '110101199502022222', 'https://example.com/avatar2.jpg', '2024-01-16 11:00:00', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `user` VALUES (3, 'oXXXX3', '王小华', '13900139003', '1', '110101199503033333', 'https://example.com/avatar3.jpg', '2024-01-17 12:00:00', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `user` VALUES (4, 'oXXXX4', '赵小芳', '13900139004', '0', '110101199504044444', 'https://example.com/avatar4.jpg', '2024-01-18 13:00:00', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `user` VALUES (5, 'oXXXX5', '孙小龙', '13900139005', '1', '110101199505055555', 'https://example.com/avatar5.jpg', '2024-01-19 14:00:00', 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `user` VALUES (6, 'oPbYE2Wks8Uzct0vhdyVgzi00T5o', 'kk', '17776248496', '0', NULL, 'https://lk111-bucket.oss-cn-guangzhou.aliyuncs.com/5bda179c-7775-4309-80a3-7c8f6239e585.jpg', '2026-06-25 00:18:43', '$2a$10$JYvBmIeIRj3l5ZqeiZ/rn.W7/5YxGR.QrmzVVUXhD.fJCtE7jKoNu');
INSERT INTO `user` VALUES (7, 'wx_openid_001', '张三丰', '13800138001', '男', '110101199001011234', 'https://example.com/avatar1.jpg', '2026-05-20 10:00:00', NULL);
INSERT INTO `user` VALUES (8, 'wx_openid_002', '李四娘', '13800138002', '女', '110101199002021235', 'https://example.com/avatar2.jpg', '2026-05-21 11:00:00', NULL);
INSERT INTO `user` VALUES (9, 'wx_openid_003', '王五哥', '13800138003', '男', '110101199003031236', 'https://example.com/avatar3.jpg', '2026-05-22 12:00:00', NULL);
INSERT INTO `user` VALUES (10, 'wx_openid_004', '赵六妹', '13800138004', '女', '110101199004041237', 'https://example.com/avatar4.jpg', '2026-05-23 13:00:00', NULL);
INSERT INTO `user` VALUES (11, 'wx_openid_005', '孙七爷', '13800138005', '男', '110101199005051238', 'https://example.com/avatar5.jpg', '2026-05-24 14:00:00', NULL);
INSERT INTO `user` VALUES (12, 'wx_openid_006', '周八姐', '13800138006', '女', '110101199006061239', 'https://example.com/avatar6.jpg', '2026-05-25 15:00:00', NULL);
INSERT INTO `user` VALUES (13, 'wx_openid_007', '吴九郎', '13800138007', '男', '110101199007071240', 'https://example.com/avatar7.jpg', '2026-05-26 16:00:00', NULL);
INSERT INTO `user` VALUES (14, 'wx_openid_008', '郑十妹', '13800138008', '女', '110101199008081241', 'https://example.com/avatar8.jpg', '2026-05-27 17:00:00', NULL);
INSERT INTO `user` VALUES (15, 'wx_openid_009', '陈大勇', '13800138009', '男', '110101199009091242', 'https://example.com/avatar9.jpg', '2026-05-28 18:00:00', NULL);
INSERT INTO `user` VALUES (16, 'wx_openid_010', '林小美', '13800138010', '女', '110101199010101243', 'https://example.com/avatar10.jpg', '2026-05-29 19:00:00', NULL);
INSERT INTO `user` VALUES (17, 'wx_openid_011', '黄药师', '13800138011', '男', '110101199011111244', 'https://example.com/avatar11.jpg', '2026-05-30 20:00:00', NULL);
INSERT INTO `user` VALUES (18, 'wx_openid_012', '杨过', '13800138012', '男', '110101199012121245', 'https://example.com/avatar12.jpg', '2026-05-31 21:00:00', NULL);
INSERT INTO `user` VALUES (19, 'wx_openid_013', '小龙女', '13800138013', '女', '110101199013131246', 'https://example.com/avatar13.jpg', '2026-06-01 08:00:00', NULL);
INSERT INTO `user` VALUES (20, 'wx_openid_014', '郭靖', '13800138014', '男', '110101199014141247', 'https://example.com/avatar14.jpg', '2026-06-02 09:00:00', NULL);
INSERT INTO `user` VALUES (21, 'wx_openid_015', '黄蓉', '13800138015', '女', '110101199015151248', 'https://example.com/avatar15.jpg', '2026-06-03 10:00:00', NULL);
INSERT INTO `user` VALUES (22, 'wx_openid_001', '张三丰', '13800138001', '男', '110101199001011234', 'https://example.com/avatar1.jpg', '2026-05-20 10:00:00', NULL);
INSERT INTO `user` VALUES (23, 'wx_openid_002', '李四娘', '13800138002', '女', '110101199002021235', 'https://example.com/avatar2.jpg', '2026-05-21 11:00:00', NULL);
INSERT INTO `user` VALUES (24, 'wx_openid_003', '王五哥', '13800138003', '男', '110101199003031236', 'https://example.com/avatar3.jpg', '2026-05-22 12:00:00', NULL);
INSERT INTO `user` VALUES (25, 'wx_openid_004', '赵六妹', '13800138004', '女', '110101199004041237', 'https://example.com/avatar4.jpg', '2026-05-23 13:00:00', NULL);
INSERT INTO `user` VALUES (26, 'wx_openid_005', '孙七爷', '13800138005', '男', '110101199005051238', 'https://example.com/avatar5.jpg', '2026-05-24 14:00:00', NULL);
INSERT INTO `user` VALUES (27, 'wx_openid_006', '周八姐', '13800138006', '女', '110101199006061239', 'https://example.com/avatar6.jpg', '2026-05-25 15:00:00', NULL);
INSERT INTO `user` VALUES (28, 'wx_openid_007', '吴九郎', '13800138007', '男', '110101199007071240', 'https://example.com/avatar7.jpg', '2026-05-26 16:00:00', NULL);
INSERT INTO `user` VALUES (29, 'wx_openid_008', '郑十妹', '13800138008', '女', '110101199008081241', 'https://example.com/avatar8.jpg', '2026-05-27 17:00:00', NULL);
INSERT INTO `user` VALUES (30, 'wx_openid_009', '陈大勇', '13800138009', '男', '110101199009091242', 'https://example.com/avatar9.jpg', '2026-05-28 18:00:00', NULL);
INSERT INTO `user` VALUES (31, 'wx_openid_010', '林小美', '13800138010', '女', '110101199010101243', 'https://example.com/avatar10.jpg', '2026-05-29 19:00:00', NULL);
INSERT INTO `user` VALUES (32, 'wx_openid_011', '黄药师', '13800138011', '男', '110101199011111244', 'https://example.com/avatar11.jpg', '2026-05-30 20:00:00', NULL);
INSERT INTO `user` VALUES (33, 'wx_openid_012', '杨过', '13800138012', '男', '110101199012121245', 'https://example.com/avatar12.jpg', '2026-05-31 21:00:00', NULL);
INSERT INTO `user` VALUES (34, 'wx_openid_013', '小龙女', '13800138013', '女', '110101199013131246', 'https://example.com/avatar13.jpg', '2026-06-01 08:00:00', NULL);
INSERT INTO `user` VALUES (35, 'wx_openid_014', '郭靖', '13800138014', '男', '110101199014141247', 'https://example.com/avatar14.jpg', '2026-06-02 09:00:00', NULL);
INSERT INTO `user` VALUES (36, 'wx_openid_015', '黄蓉', '13800138015', '女', '110101199015151248', 'https://example.com/avatar15.jpg', '2026-06-03 10:00:00', NULL);
INSERT INTO `user` VALUES (37, 'wx_openid_001', '张三丰', '13800138001', '男', '110101199001011234', 'https://example.com/avatar1.jpg', '2026-05-20 10:00:00', NULL);
INSERT INTO `user` VALUES (38, 'wx_openid_002', '李四娘', '13800138002', '女', '110101199002021235', 'https://example.com/avatar2.jpg', '2026-05-21 11:00:00', NULL);
INSERT INTO `user` VALUES (39, 'wx_openid_003', '王五哥', '13800138003', '男', '110101199003031236', 'https://example.com/avatar3.jpg', '2026-05-22 12:00:00', NULL);
INSERT INTO `user` VALUES (40, 'wx_openid_004', '赵六妹', '13800138004', '女', '110101199004041237', 'https://example.com/avatar4.jpg', '2026-05-23 13:00:00', NULL);
INSERT INTO `user` VALUES (41, 'wx_openid_005', '孙七爷', '13800138005', '男', '110101199005051238', 'https://example.com/avatar5.jpg', '2026-05-24 14:00:00', NULL);
INSERT INTO `user` VALUES (42, 'wx_openid_006', '周八姐', '13800138006', '女', '110101199006061239', 'https://example.com/avatar6.jpg', '2026-05-25 15:00:00', NULL);
INSERT INTO `user` VALUES (43, 'wx_openid_007', '吴九郎', '13800138007', '男', '110101199007071240', 'https://example.com/avatar7.jpg', '2026-05-26 16:00:00', NULL);
INSERT INTO `user` VALUES (44, 'wx_openid_008', '郑十妹', '13800138008', '女', '110101199008081241', 'https://example.com/avatar8.jpg', '2026-05-27 17:00:00', NULL);
INSERT INTO `user` VALUES (45, 'wx_openid_009', '陈大勇', '13800138009', '男', '110101199009091242', 'https://example.com/avatar9.jpg', '2026-05-28 18:00:00', NULL);
INSERT INTO `user` VALUES (46, 'wx_openid_010', '林小美', '13800138010', '女', '110101199010101243', 'https://example.com/avatar10.jpg', '2026-05-29 19:00:00', NULL);
INSERT INTO `user` VALUES (47, 'wx_openid_011', '黄药师', '13800138011', '男', '110101199011111244', 'https://example.com/avatar11.jpg', '2026-05-30 20:00:00', NULL);
INSERT INTO `user` VALUES (48, 'wx_openid_012', '杨过', '13800138012', '男', '110101199012121245', 'https://example.com/avatar12.jpg', '2026-05-31 21:00:00', NULL);
INSERT INTO `user` VALUES (49, 'wx_openid_013', '小龙女', '13800138013', '女', '110101199013131246', 'https://example.com/avatar13.jpg', '2026-06-01 08:00:00', NULL);
INSERT INTO `user` VALUES (50, 'wx_openid_014', '郭靖', '13800138014', '男', '110101199014141247', 'https://example.com/avatar14.jpg', '2026-06-02 09:00:00', NULL);
INSERT INTO `user` VALUES (51, 'wx_openid_015', '黄蓉', '13800138015', '女', '110101199015151248', 'https://example.com/avatar15.jpg', '2026-06-03 10:00:00', NULL);
INSERT INTO `user` VALUES (52, 'wx_openid_001', '张三丰', '13800138001', '男', '110101199001011234', 'https://example.com/avatar1.jpg', '2026-05-20 10:00:00', NULL);
INSERT INTO `user` VALUES (53, 'wx_openid_002', '李四娘', '13800138002', '女', '110101199002021235', 'https://example.com/avatar2.jpg', '2026-05-21 11:00:00', NULL);
INSERT INTO `user` VALUES (54, 'wx_openid_003', '王五哥', '13800138003', '男', '110101199003031236', 'https://example.com/avatar3.jpg', '2026-05-22 12:00:00', NULL);
INSERT INTO `user` VALUES (55, 'wx_openid_004', '赵六妹', '13800138004', '女', '110101199004041237', 'https://example.com/avatar4.jpg', '2026-05-23 13:00:00', NULL);
INSERT INTO `user` VALUES (56, 'wx_openid_005', '孙七爷', '13800138005', '男', '110101199005051238', 'https://example.com/avatar5.jpg', '2026-05-24 14:00:00', NULL);
INSERT INTO `user` VALUES (57, 'wx_openid_006', '周八姐', '13800138006', '女', '110101199006061239', 'https://example.com/avatar6.jpg', '2026-05-25 15:00:00', NULL);
INSERT INTO `user` VALUES (58, 'wx_openid_007', '吴九郎', '13800138007', '男', '110101199007071240', 'https://example.com/avatar7.jpg', '2026-05-26 16:00:00', NULL);
INSERT INTO `user` VALUES (59, 'wx_openid_008', '郑十妹', '13800138008', '女', '110101199008081241', 'https://example.com/avatar8.jpg', '2026-05-27 17:00:00', NULL);
INSERT INTO `user` VALUES (60, 'wx_openid_009', '陈大勇', '13800138009', '男', '110101199009091242', 'https://example.com/avatar9.jpg', '2026-05-28 18:00:00', NULL);
INSERT INTO `user` VALUES (61, 'wx_openid_010', '林小美', '13800138010', '女', '110101199010101243', 'https://example.com/avatar10.jpg', '2026-05-29 19:00:00', NULL);
INSERT INTO `user` VALUES (62, 'wx_openid_011', '黄药师', '13800138011', '男', '110101199011111244', 'https://example.com/avatar11.jpg', '2026-05-30 20:00:00', NULL);
INSERT INTO `user` VALUES (63, 'wx_openid_012', '杨过', '13800138012', '男', '110101199012121245', 'https://example.com/avatar12.jpg', '2026-05-31 21:00:00', NULL);
INSERT INTO `user` VALUES (64, 'wx_openid_013', '小龙女', '13800138013', '女', '110101199013131246', 'https://example.com/avatar13.jpg', '2026-06-01 08:00:00', NULL);
INSERT INTO `user` VALUES (65, 'wx_openid_014', '郭靖', '13800138014', '男', '110101199014141247', 'https://example.com/avatar14.jpg', '2026-06-02 09:00:00', NULL);
INSERT INTO `user` VALUES (66, 'wx_openid_015', '黄蓉', '13800138015', '女', '110101199015151248', 'https://example.com/avatar15.jpg', '2026-06-03 10:00:00', NULL);
INSERT INTO `user` VALUES (67, 'wx_openid_001', '张三丰', '13800138001', '男', '110101199001011234', 'https://example.com/avatar1.jpg', '2026-05-20 10:00:00', NULL);
INSERT INTO `user` VALUES (68, 'wx_openid_002', '李四娘', '13800138002', '女', '110101199002021235', 'https://example.com/avatar2.jpg', '2026-05-21 11:00:00', NULL);
INSERT INTO `user` VALUES (69, 'wx_openid_003', '王五哥', '13800138003', '男', '110101199003031236', 'https://example.com/avatar3.jpg', '2026-05-22 12:00:00', NULL);
INSERT INTO `user` VALUES (70, 'wx_openid_004', '赵六妹', '13800138004', '女', '110101199004041237', 'https://example.com/avatar4.jpg', '2026-05-23 13:00:00', NULL);
INSERT INTO `user` VALUES (71, 'wx_openid_005', '孙七爷', '13800138005', '男', '110101199005051238', 'https://example.com/avatar5.jpg', '2026-05-24 14:00:00', NULL);
INSERT INTO `user` VALUES (72, 'wx_openid_006', '周八姐', '13800138006', '女', '110101199006061239', 'https://example.com/avatar6.jpg', '2026-05-25 15:00:00', NULL);
INSERT INTO `user` VALUES (73, 'wx_openid_007', '吴九郎', '13800138007', '男', '110101199007071240', 'https://example.com/avatar7.jpg', '2026-05-26 16:00:00', NULL);
INSERT INTO `user` VALUES (74, 'wx_openid_008', '郑十妹', '13800138008', '女', '110101199008081241', 'https://example.com/avatar8.jpg', '2026-05-27 17:00:00', NULL);
INSERT INTO `user` VALUES (75, 'wx_openid_009', '陈大勇', '13800138009', '男', '110101199009091242', 'https://example.com/avatar9.jpg', '2026-05-28 18:00:00', NULL);
INSERT INTO `user` VALUES (76, 'wx_openid_010', '林小美', '13800138010', '女', '110101199010101243', 'https://example.com/avatar10.jpg', '2026-05-29 19:00:00', NULL);
INSERT INTO `user` VALUES (77, 'wx_openid_011', '黄药师', '13800138011', '男', '110101199011111244', 'https://example.com/avatar11.jpg', '2026-05-30 20:00:00', NULL);
INSERT INTO `user` VALUES (78, 'wx_openid_012', '杨过', '13800138012', '男', '110101199012121245', 'https://example.com/avatar12.jpg', '2026-05-31 21:00:00', NULL);
INSERT INTO `user` VALUES (79, 'wx_openid_013', '小龙女', '13800138013', '女', '110101199013131246', 'https://example.com/avatar13.jpg', '2026-06-01 08:00:00', NULL);
INSERT INTO `user` VALUES (80, 'wx_openid_014', '郭靖', '13800138014', '男', '110101199014141247', 'https://example.com/avatar14.jpg', '2026-06-02 09:00:00', NULL);
INSERT INTO `user` VALUES (81, 'wx_openid_015', '黄蓉', '13800138015', '女', '110101199015151248', 'https://example.com/avatar15.jpg', '2026-06-03 10:00:00', NULL);

SET FOREIGN_KEY_CHECKS = 1;
