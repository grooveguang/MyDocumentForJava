1.什么是swagger?有什么优点？
   官方：Swagger是一个规范和完整的框架，用于生成、描述、调用和可视化 RESTful 风格的 Web 服务。总体目标是使客户端和文件系统作为服务器以同样的速度来更新。文件的方法，参数和模型紧密集成到服务器端的代码，允许API来始终保持同步。
  一句话概括：swagger用于定义API文档。

优点：
•	前后端分离开发
•	API文档非常明确
•	测试的时候不需要再使用URL输入浏览器的方式来访问Controller
•	传统的输入URL的测试方式对于post请求的传参比较麻烦（当然，可以使用postman这样的浏览器插件）
•	spring-boot与swagger的集成简单

2.Springboot集成swagger的具体步骤？
 搭建springboot框架的两种方式：
  （1） http://start.spring.io/  生成springboot项目
   （2）手工创建maven项目，加入springboot的jar包依赖，创建启动类，测试启动。
http://blog.csdn.net/lxhjh/article/details/51711148

 集成swagger
 Pom文件添加依赖：

       <dependency>
           <groupId>io.springfox</groupId>
           <artifactId>springfox-swagger2</artifactId>
           <version>2.2.2</version>
        </dependency>
        <dependency>
           <groupId>io.springfox</groupId>
           <artifactId>springfox-swagger-ui</artifactId>
           <version>2.2.2</version>
        </dependency>

Springboot启动类上引入注解@EnableSwagger2：
引入了一个注解@EnableSwagger2来启动swagger注解。
（启动该注解使得用在controller中的swagger注解生效，覆盖的范围由@ComponentScan的配置来指定，这里默认指定为根路径"com.study"下的所有controller）

或者创建SwaggerConfig配置类。

 
或者
 
对应的api文档效果
 


3.Swagger常用的注解？

*	@Api：用在类上，说明该类的作用
*	@ApiOperation：用在方法上，说明方法的作用
*	@ApiImplicitParams：用在方法上包含一组参数说明
*	@ApiImplicitParam：用在@ApiImplicitParams注解中，指定一个请求参数的各个方面 
 * paramType：参数放在哪个地方 
    * header-->请求参数的获取：@RequestHeader
    * query-->请求参数的获取：@RequestParam
    * path（用于restful接口）-->请求参数的获取：@PathVariable
    * body（不常用）
    * form（不常用）
o	name：参数名
o	dataType：参数类型
o	required：参数是否必须传
o	value：参数的意思
o	defaultValue：参数的默认值
•	@ApiResponses：用于表示一组响应
•	@ApiResponse：用在@ApiResponses中，一般用于表达一个错误的响应信息 
o	code：数字，例如400
o	message：信息，例如"请求参数没填好"
o	response：抛出异常的类
•	@ApiModel：描述一个Model的信息（这种一般用在post创建的时候，使用@RequestBody这样的场景，请求参数无法使用@ApiImplicitParam注解进行描述的时候） 
o	@ApiModelProperty：描述一个model的属性

 
 
 
 
 
 
 
 


参考资料：
http://www.cnblogs.com/xiaohanghang/p/6018654.html 
http://www.cnblogs.com/java-zhao/p/5348113.html 
http://blog.csdn.net/saytime/article/details/74937664 
