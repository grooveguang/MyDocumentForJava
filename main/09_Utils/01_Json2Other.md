JSON to Other
====
##
### [返回Utils目录](./UtilsDirectory.md) [回到首页目录](/README.md)

# 1.Gson
1.添加依赖

         <dependency>
			<groupId>com.google.code.gson</groupId>
			<artifactId>gson</artifactId>
			<version>2.2.4</version>
		</dependency>

2.转化方法

①.对象转Json: 

	Gson gson = new Gson();
	String json = gson.toJson(Object object);


②.Json转对象:

    gson.fromJson(String json, Class<T> classOfT) 



③.集合转Json: 

	Gson gson = new Gson();
	String json = gson.toJson(Object object);


④.Json转集合: 

	TypeToken<T> typeOfT = new TypeToken<T>(){};
	
	T fromJson = (T)gson.fromJson(json, typeOfT.getType());


# 2.Json-lib
1.添加依赖

        <dependency>
		    <groupId>net.sf.json-lib</groupId>
		    <artifactId>json-lib</artifactId>
		    <version>2.4</version>
		    <classifier>jdk15</classifier>
		</dependency>

2.转化方法

①	.对象转Json: 

    JSONObject fromObject = JSONObject.fromObject(Object object);
    String string = fromObject.toString();

②.Json转对象: 

    JSONObject fromObject2 = JSONObject.fromObject(string);
    Object bean =JSONObject.toBean(JSONObject jsonObject, Class beanClass)


③.集合转Json: 

    JSONArray fromObject = JSONArray.fromObject(Object object);
    String string = fromObject.toString();

④.Json转集合:

    JSONArray fromObject2 = JSONArray.fromObject(string);
    Collection collection = JSONArray.toCollection (JSONArray jsonArray, Class objectClass)

# 3.Fastjson
Fastjson是阿里巴巴公司开发的，Java语言编写的，JSON的处理器。
1.添加依赖

     <dependency>
		    <groupId>com.alibaba</groupId>
		    <artifactId>fastjson</artifactId>
		    <version>1.2.31</version>
    </dependency>

2.转化方法

①.对象转Json:
 
    JSON.toJSONString(Object object);

②.Json转对象: 

    JSON.parseObject(String text,Class<T> Class);

③.集合转Json:

    JSON.toJSONString(Object object)

④.Json转集合: 
    
    JSON.parseArray(String text,Class<T> Class);
