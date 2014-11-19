package com.eastteam.myprogram.utils;

import net.sf.ehcache.Cache;
import net.sf.ehcache.Element;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;

public class MethodCacheInterceptor implements MethodInterceptor, InitializingBean {

	private static Logger logger = LoggerFactory.getLogger(MethodCacheInterceptor.class);

	private Cache cache;

	public void setCache(Cache cache) {
		this.cache = cache;
	}

	public Object invoke(MethodInvocation invocation) throws Throwable {
		String targetName = invocation.getThis().getClass().getName();
		String methodName = invocation.getMethod().getName();
		Object[] arguments = invocation.getArguments();
		Object result;
		String cacheKey = getCacheKey(targetName, methodName, arguments);
		Element element = null;
		synchronized (this) {
			element = cache.get(cacheKey);
			if (element == null) {
				logger.info(cacheKey + "加入到缓存： " + cache.getName());
				// 调用实际的方法
				result = invocation.proceed();
				element = new Element(cacheKey, result);
				cache.put(element);
			} else {
				logger.info(cacheKey + "使用缓存： " + cache.getName());
			}

		}

		return element.getValue();

	}

	private String getCacheKey(String targetName, String methodName, Object[] arguments) {
		StringBuffer sb = new StringBuffer();
		sb.append(targetName).append(".").append(methodName);
		if ((arguments != null) && (arguments.length != 0)) {
			for (int i = 0; i < arguments.length; i++) {
				sb.append(".").append(arguments[i]);
			}
		}
		return sb.toString();

	}

	@Override
	public void afterPropertiesSet() throws Exception {
		logger.info(cache + " A cache is required. Use setCache(Cache) to provide one.");
	}

}
