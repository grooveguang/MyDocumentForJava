String to Other
====
##
### [返回Utils目录](./UtilsDirectory.md) [回到首页目录](/README.md)
## 

--------------------------------------------------java中--------------------------------------------------------------
===

### 1.String转JSONObject

（1）.
```java
String jsonMessage = "{\"语文\":\"88\",\"数学\":\"78\",\"计算机\":\"99\"}";

JSONObject  myJson = JSONObject.fromObject(jsonMessage);
```

（2）.用阿里巴巴的fastjson的jar包

```java
String str = "{\"baid\":null,\"32d3:\":\"null\",433:\"0x32\",032:\"ju9fw\"}";
com.alibaba.fastjson.JSONObject jm = com.alibaba.fastjson.JSON.parseObject(str);
```
### 2.String转JSONArray

```java
String jsonMessage = "[{'num':'成绩', '外语':88, '历史':65, '地理':99, 'object':   {'aaa':'1111','bbb':'2222','cccc':'3333'}}," +
          "{'num':'兴趣', '外语':28, '历史':45, '地理':19, 'object':{'aaa':'11a11','bbb':'2222','cccc':'3333'}}," +
          "{'num':'爱好', '外语':48, '历史':62, '地理':39, 'object':{'aaa':'11c11','bbb':'2222','cccc':'3333'}}]";
 JSONArray myJsonArray = JSONArray.fromObject(jsonMessage);
 System.out.println(myJsonArray);
```

### 3.String转Map

(1)

```java
String jsonMessage = "{\"语文\":\"88\",\"数学\":\"78\",\"计算机\":\"99\"}";

JSONObject  myJson = JSONObject.fromObject(jsonMessage);

Map m = myJson; 
```

（2）用阿里巴巴的fastjson的jar包

```java
String str = "{\"baid\":null,\"32d3:\":\"null\",433:\"0x32\",032:\"ju9fw\"}";
Map mapTypes = com.alibaba.fastjson.JSON.parseObject(str);
```

(3) (需要引入jackjson的core、databind、annotations三个jar包  )

```java
String json = "{\"PayPal key2\":\"PayPal value2\",\"PayPal key1\":\"PayPal value1\",\"PayPal key3\":\"PayPalvalue3\"}";  

ObjectMapper mapper = new ObjectMapper();    
 Map<String,Object> m = mapper.readValue(json, Map.class);  
```

(4)(特殊格式的String)

```java
String a ="{se=2016, format=xml, at=en co=3}";
a =  a.substring(1, a.length()-1);
Map docType = new HashMap();  
Java.util.StringTokenizer items;  
for(StringTokenizer entrys = new StringTokenizer(a, ", ");entrys.hasMoreTokens();   
docType.put(items.nextToken(), items.hasMoreTokens() ? ((Object) (items.nextToken())) : null)){  
     items = new StringTokenizer(entrys.nextToken(), "=");  
   }
```

### 4.JSONObject、JSONArray，Map转String

```java
JSONObject——String：
System.out.println(myJsonObject);//可直接输出JSONObject的内容
myJsonObject.toString();
JSONArray——String：
System.out.println(myJsonArray);//可直接输出myJsonArray的内容
myJsonArray.toString();
Map——String:
System.out.println(map);//可直接输出map的内容
map.toString();
```

### 5.JSONObject转JSONArray



### 6.JSONObject转Map

```java
JSONObject  myJson = JSONObject.fromObject(jsonString);

Map m = myJson; 
```

### 7.JSONArray转JSONObject

```java
  for(int i=0 ; i < myJsonArray.length() ;i++)
   {
    //获取每一个JsonObject对象
    JSONObject myjObject = myJsonArray.getJSONObject(i);

}
```


### 8.JSONArray转Map





### 9.Map转JSONObject

```java
JSONObject json = JSONObject.fromObject( map );   

或

String jsonString = JSON.toJSONString(map,SerializerFeature.WriteMapNullValue,SerializerFeature.WriteNullStringAsEmpty);

JSONObject jm = JSON.parseObject(str);

(此为alibaba的fastjson)
```


### 10.Map转JSONArray

	JSONArray.fromObject(map);

### 11.List转JSONArray

	JSONArray jsonArray2 = JSONArray.fromObject( list );      



### 12.JSONArray转List

```java
List<Map<String,Object>> mapListJson = (List)jsonArray;

或

public static List<Map<String, Object>> jsonArrayToList(JSONArray ja){  
        return JSONArray.toJavaObject(ja, List.class);  
    } 
```


### 13.String转数组

```java
String string = "a,b,c";
String [] stringArr= string.split(",");  //注意分隔符是需要转译滴...

//如果是"abc"这种字符串,就直接
String string = "abc" ;
char [] stringArr = string.toCharArray(); //注意返回值是char数组

//如果要返回byte数组就直接使用getBytes方法就ok了~~
String string = "abc" ;
byte [] stringArr = string.getBytes();

//数组转String
char[] data={a,b,c}; 
String s=new String(data); 
```


### 14.java实体类的List转String

JSON与String关系比较近，而JSON的子类JSONArray又和List关系比较近，故把JSONArray做中介过渡：

```java
import com.alibaba.fastjson.JSONArray;

public String list2str(List<?> list){
JSONArray jsonArray = (JSONArray) JSONArray.toJSON(list);   //List转JSONArray
System.out.println(jsonArray.toString());
return jsonArray.toJSONString();    //JSONArray比较容易转String
}
```

### 15.Array、List、Set之间转换：

```java
String[] arr = new String[]{"Tom", "Bob", "Jane"};
//Array转List
List<String> arr2list = Arrays.asList(arr);
//Array转Set
Set<String> arr2set = new HashSet<String>(Arrays.asList(arr));
//List转Array
Object[] list2arr = arr2list.toArray();
//List转Set
Set<String> list2set = new HashSet<>(arr2list);
//Set转Array
Object[] set2arr = list2set.toArray();
//Set转List
List<String> set2list = new ArrayList<>(arr2set);
List<String> list = new ArrayList<String>(new HashSet<String>());//
```

--------------------------------------------js中---------------------------------------
===

[js中自定义的map请参考](http://blog.csdn.net/superit401/article/details/72842469)



### 1.json转Map（并获取key和value）

```java
var str = JSON.stringify(json);
 str = '{ "10.10.11.1": { "target_1": "34.2","target_3": "70.83","target_2": "50.51"}}';
var map = eval("("+str+")");
```

//以下为获取Map的key-value：

```java
for (var key in map) {  
var a = map[key];
for (var k in a) {  
alert(k+'---'+a[k]);
}   
  }  
```
[参考](http://www.bkjia.com/webzh/899371.html)



### 2.Map转json：

不能直接map转json：var mjson = JSON.parse(map);

也不能var mjson = $.parseJSON(map);//结果为null

只能分两步走：

	var mstr = JSON.stringify(map);

	var jsonstr = JSON.parse(mstr);

（注：有的浏览器不支持JSON.parse()方法，使用jQuery.parseJSON()方法时，在浏览器支持时会返回执行JSON.parse()方法的结果，否则会返回类似执行eval()方法的结果）

[参考](http://www.jb51.net/article/87642.htm)

### 3.json转String：

	JSON.stringify(json);



### 4.String转json：

```java
var str = '{ "10.10.11.1": { "target_1": "34.2","target_3": "70.83","target_2": "50.51"}}';

var jsonstr = JSON.parse(str);
```


### 5.Map转String：

	var mstr = JSON.stringify(map);

### 6.String转Map：

```java
var str = '{ "10.10.11.1": { "target_1": "34.2","target_3": "70.83","target_2": "50.51"}}';
var map = eval("("+str+")");
```