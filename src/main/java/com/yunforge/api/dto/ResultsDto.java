package com.yunforge.api.dto;

import java.util.HashMap;
import java.util.Map;

public class ResultsDto {

private Map<String,Object> map = new HashMap<String,Object>();
	
	public void put(String key,Object value) {
		map.put(key, value);
	}
	
	public Object get(String key) {
		return map.get(key);
	}
}