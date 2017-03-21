package com.manager.pojo;

import java.util.Date;

public class RetryPojo {

	private int retry = 1; // 已经重试的次数
	private long lockStartTime = (new Date()).getTime() / 1000; // 开始锁定时间，秒

	public int getRetry() {
		return retry;
	}

	public void setRetry(int retry) {
		this.retry = retry;
	}

	public long getLockStartTime() {
		return lockStartTime;
	}

	public void setLockStartTime(long lockStartTime) {
		this.lockStartTime = lockStartTime;
	}

	public void retryAutoIncre() {
		this.retry++;
	}

}
