package com.sky.utils;

import org.springframework.transaction.support.TransactionSynchronization;
import org.springframework.transaction.support.TransactionSynchronizationManager;

public class TransactionSynchronizationUtils {
    /**
     * 事务结束后执行的代码，与事务解耦
     * @param action
     */
    public static void doAfterCommit(Runnable action) {
        if (TransactionSynchronizationManager.isActualTransactionActive()) {
            TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization() {
                @Override
                public void afterCommit() {
                    action.run();
                }
            });
        }
        //没有事务不用删除，因为此时数据没发生改变
    }
}
