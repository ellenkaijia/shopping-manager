package com.manager.json;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;
import org.codehaus.jackson.map.introspect.BasicBeanDescription;
import org.codehaus.jackson.map.ser.BeanSerializerFactory;
import org.codehaus.jackson.map.ser.BeanSerializerFactory.ConfigImpl;
import org.codehaus.jackson.map.ser.impl.SimpleBeanPropertyFilter;
import org.codehaus.jackson.map.ser.impl.SimpleFilterProvider;
import org.codehaus.jackson.type.JavaType;
import org.codehaus.jackson.type.TypeReference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * json工具，jackson转换json-lib效率更高，更完善和准确.
 * 
 * 
 */
public class JacksonUtils {

	/**
	 * 共用ObjectMapper，提升JSON转化效率
	 */
	private static ObjectMapper mapper = new ObjectMapper();
	protected static final Logger logger = LoggerFactory.getLogger(JacksonUtils.class);

	static {
		mapper.configure(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS, false);
		mapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		mapper.configure(DeserializationConfig.Feature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT, true);
		mapper.configure(DeserializationConfig.Feature.ACCEPT_SINGLE_VALUE_AS_ARRAY, true);
	}
	
	/**
	 * 获取ojbectMapper对象
	 */
	public static ObjectMapper getObjectMapper() {
		if (mapper == null) {
			mapper = new ObjectMapper();
		}
		return mapper;
	}

	/**
	 * 获取jackSon ObjectMapper对象
	 * 
	 * @return
	 */
	public static ObjectMapper params() {
		if (mapper == null) {  
			mapper = new ObjectMapper();  
        } 
		return mapper;
	}

	/**
	 * List利用json，进行深拷贝.
	 * 
	 * @param src
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List<Map<String, Object>> deepListClone(List<Map<String, Object>> src) {
		List<Map<String, Object>> dest = null;

		try {
			String jsonStr = mapper.writeValueAsString(src);
			dest = mapper.readValue(jsonStr, List.class);
		} catch (Exception e) {
			logger.error("List利用json，进行深拷贝", e);
		}
		return dest;
	}

	/**
	 * List利用json，进行对象深拷贝.
	 * 
	 * @param src
	 * @return
	 */
	public static <T> List<T> deepListObjectClone(List<T> src, Class<T> clazz) {
		List<T> dest = null;

		try {
			String jsonStr = mapper.writeValueAsString(src);
			dest = mapper.readValue(jsonStr, getCollectionType(src.getClass(), clazz));
		} catch (Exception e) {
			logger.error("List利用json，进行深拷贝", e);
		}
		return dest;
	}

	/**
	 * List利用json，序列化.
	 * 
	 * @param src
	 * @return
	 */
	public static String jsonListSerializer(List<Map<String, Object>> src) {
		String jsonStr = null;
		try {
			jsonStr = mapper.writeValueAsString(src);

		} catch (Exception e) {
			logger.error("List利用json，序列化", e);
		}
		return jsonStr;
	}

	/**
	 * List列表转为json字符串.
	 * 
	 * @param src
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static String listToJsonStr(List src) {
		String jsonStr = null;
		try {
			jsonStr = mapper.writeValueAsString(src);

		} catch (Exception e) {
			logger.error(" List列表转为json字符串", e);
		}
		return jsonStr;
	}

	/**
	 * Map转为json字符串.
	 * 
	 * @param src
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public static String mapToJsonStr(Map src) {
		String jsonStr = null;
		try {
			jsonStr = mapper.writeValueAsString(src);

		} catch (Exception e) {
			logger.error("Map转为json字符串", e);
		}
		return jsonStr;
	}

	/**
	 * List利用json，反序列化.
	 * 
	 * @param src
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List<Map<String, Object>> jsonListUnSerializer(String jsonStr) {

		List<Map<String, Object>> dest = null;
		try {

			dest = mapper.readValue(jsonStr, List.class);
		} catch (Exception e) {
			logger.error(" List利用json，反序列化", e);
		}
		return dest;
	}

	/**
	 * List利用json，指定List元素类型，反序列化.
	 * 
	 * @param src
	 * @return
	 */
	public static <T> List<T> jsonListUnSerializer(String jsonStr, Class<T> elementType) {

		List<T> dest = null;
		try {
			dest = mapper.readValue(jsonStr, getCollectionType(List.class, elementType));
		} catch (Exception e) {
			logger.error("List利用json，指定List元素类型，反序列化", e);
		}
		return dest;
	}

	/**
	 * 获取泛型的Collection Type
	 * 
	 * @param collectionClass
	 *            泛型的Collection
	 * @param elementClasses
	 *            元素类
	 * @return JavaType Java类型
	 * @since 1.0
	 */
	public static JavaType getCollectionType(Class<?> collectionClass, Class<?>... elementClasses) {
		return mapper.getTypeFactory().constructParametricType(collectionClass, elementClasses);
	}

	/**
	 * List利用json，反序列化.
	 * 
	 * @param src
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List<Map<String, Object>> jsonListUnSerializer(JsonNode jsonNode) {

		List<Map<String, Object>> dest = null;
		try {
			dest = mapper.readValue(jsonNode, List.class);
		} catch (Exception e) {
			logger.error("List利用json，反序列化", e);
		}
		return dest;
	}

	/**
	 * Map利用json，序列化.
	 * 
	 * @param src
	 * @return
	 */
	public static String jsonMapSerializer(Map<String, String> src) {
		String jsonStr = null;
		try {
			jsonStr = mapper.writeValueAsString(src);

		} catch (Exception e) {
			logger.error("Map利用json，序列化", e);
		}
		return jsonStr;
	}

	/**
	 * Map利用json，反序列化.
	 * 
	 * @param src
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, Object> jsonMapUnSerializer(String jsonStr) {

		Map<String, Object> dest = null;
		try {

			dest = mapper.readValue(jsonStr, Map.class);
		} catch (Exception e) {
			logger.error("Map利用json，反序列化", e);
		}
		return dest;
	}

	/**
	 * OBJECT利用json，反序列化.
	 * 
	 * @param src
	 * @return
	 */
	public static <T> T jsonObjUnSerializer(String jsonString, Class<T> type) {

		try {
			return mapper.readValue(jsonString, type);
		} catch (Exception e) {
			logger.error("解析json jsonString=" + jsonString, e);
			return null;
		}
	}

	/**
	 * OBJECT利用json，指定类型引用TypeReference类型反序列化.
	 * 
	 * <pre>
	 * eg：
	 * List<A> lista3 = jsonObjUnSerializer(listj, new TypeReference<List<A>>() {});
	 * A a = jsonObjUnSerializer(listj, new TypeReference<A>() {});
	 * </pre>
	 * 
	 * @param jsonString
	 * @param typeReference
	 * @return
	 */
	public static <T> T jsonObjUnSerializer(String jsonString, TypeReference<T> typeReference) {

		try {
			return mapper.readValue(jsonString, typeReference);
		} catch (Exception e) {
			logger.error("OBJECT利用json，指定类型引用，new TypeReference<Map<String, ResultValue>>() { } jsonString="
					+ jsonString, e);
			return null;
		}
	}

	/**
	 * OBJECT利用json，指定类型引用TypeReference类型反序列化.
	 * 
	 * <pre>
	 * eg：
	 * List<A> lista3 = jsonObjUnSerializer(listj, new TypeReference<List<A>>() {});
	 * A a = jsonObjUnSerializer(listj, new TypeReference<A>() {});
	 * </pre>
	 * 
	 * @param jsonString
	 * @param typeReference
	 * @return
	 */
	public static <T> T jsonObjUnSerializer(JsonNode jsonNode, TypeReference<T> typeReference) {

		try {
			return mapper.readValue(jsonNode, typeReference);
		} catch (Exception e) {
			logger.error("OBJECT利用json，指定类型引用，new TypeReference<Map<String, ResultValue>>() { } ", e);
			return null;
		}
	}

	/**
	 * OBJECT利用json，反序列化.
	 * 
	 * @param src
	 * @return
	 */
	public static <T> T jsonObjUnSerializer(JsonNode jsonNode, Class<T> type) {

		try {
			try {
				return mapper.readValue(jsonNode, type);
			} catch (Exception e) {
				logger.error("解析json jsonString=" + jsonNode, e);
				return null;
			}

		} catch (Exception e) {
			logger.error("解析json jsonString=" + jsonNode, e);
			return null;
		}
	}

	/**
	 * OBJECT利用json，反序列化.
	 * 
	 * @param src
	 * @return
	 */
	public static <T> T jsonObjUnSerializer(JsonNode jsonNode, JavaType type) {

		try {
			try {
				return mapper.readValue(jsonNode, type);
			} catch (Exception e) {
				logger.error("解析json jsonString=" + jsonNode, e);
				return null;
			}

		} catch (Exception e) {
			logger.error("解析json jsonString=" + jsonNode, e);
			return null;
		}
	}

	/**
	 * Map利用json，反序列化.
	 * 
	 * @param src
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static Map<String, Object> jsonMapUnSerializer(JsonNode jsonNode) {

		Map<String, Object> dest = null;
		try {
			dest = mapper.readValue(jsonNode, Map.class);
		} catch (Exception e) {
			logger.error(" Map利用json，反序列化 jsonString=" + jsonNode, e);
		}
		return dest;
	}

	/**
	 * 将对象转换为json字符串
	 * 
	 * @param obj
	 * @return
	 */
	public static String jsonObjectSerializer(Object obj) {
		String jsonStr = null;
		try {
			jsonStr = mapper.writeValueAsString(obj);

		} catch (Exception e) {
			logger.error("将对象转换为json字符串", e);
		}
		return jsonStr;
	}

	/**
	 * 配置JSON类型转换过滤器.
	 * 
	 * @param obj
	 * @param excludeItem
	 * @param dateFormate
	 * @return
	 */
	public static String configJsonObjectSerializer(Object obj, String[] excludeItem, String dateFormate) {
		String jsonStr = null;
		try {
			// 设置排除字段
			if (ArrayUtils.isNotEmpty(excludeItem)) {
				SimpleFilterProvider fileter = new SimpleFilterProvider();
				fileter.addFilter("executeFilter", SimpleBeanPropertyFilter.serializeAllExcept(excludeItem));
				mapper.setFilters(fileter);
				mapper.setSerializerFactory(new BeanSerializerFactory(new ConfigImpl()) {
					@Override
					protected Object findFilterId(SerializationConfig config, BasicBeanDescription beanDesc) {
						return "executeFilter";
					}
				});
			}
			// 设置日期格式化
			if (StringUtils.isNotBlank(dateFormate)) {
				mapper.setDateFormat(new SimpleDateFormat(dateFormate));
			}

			jsonStr = mapper.writeValueAsString(obj);

		} catch (Exception e) {
			logger.error(" 配置JSON类型转换过滤器", e);
		}
		return jsonStr;
	}

	/**
	 * 将json字符串转换为对象
	 * 
	 * @param jsonStr
	 * @return
	 */
	public static Object jsonObject(String jsonStr) {
		Object dest = null;
		try {

			dest = mapper.readValue(jsonStr, Object.class);
		} catch (Exception e) {
			logger.error(" 将json字符串转换为对象", e);
		}
		return dest;
	}

	/**
	 * JSON对象转换.
	 * 
	 * @param obj
	 * @param excludeItem
	 * @param dateFormate
	 * @return
	 */
	public static Object configJsonObject(Object obj, String[] excludeItem, String dateFormate) {
		Object dest = null;
		try {
			String jsonStr = configJsonObjectSerializer(obj, excludeItem, dateFormate);
			if (jsonStr != null) {
				dest = jsonObject(jsonStr);
			}
		} catch (Exception e) {
			logger.error(" JSON对象转换.", e);
		}
		return dest;
	}
}
