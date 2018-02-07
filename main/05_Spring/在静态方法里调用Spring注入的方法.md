# 在静态方法里调用spring注入的方法
在静态方法里直接调用非静态方法是不行的。 
那如何调用spring注入的方法呢？ 
<br />

```java

@Component 
public class AutoLoginUtil { 
    @Autowired 
    private IUserService userService; 

    private static AutoLoginUtil autoLoginUtil; 

    @PostConstruct 
    public void init() { 
        autoLoginUtil = this; 
        autoLoginUtil.userService = this.userService; 
     } 

    public static void autoLogin() { 
        autoLoginUtil.userService.queryUserAutoLogin(); 
     } 
    } 

<br/>
```
IUserService userService是spring注入的方法。 
主要是init()和@PostConstruct注解。