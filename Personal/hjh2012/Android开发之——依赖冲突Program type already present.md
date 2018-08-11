2018.08.11
bmob包冲突
前言
实际开发中，为了提高开发速度和效率，总避免不了引用第三方提供的依赖和类库，如果含有相同依赖的类库被我们引用时，而他们的版本又不相同，就有可能会导致一系列问题和异常，本文结合本人时间总结和他人经验，稍作总结。
问题
依赖
下面是一个项目build.gradle中的依赖，我们简单做一下分类

网络相关
okhttp
retrofit
http-legacy
常用类库
rxpermission(权限监测)
leakcanary(内存泄漏)
BaseRecycleViewAdapterHelper(star较多的Adapter)
rxjava2
smartRefreshLayout(刷新)
不常用
bmob(消息推送)
jsoup(html解析器)
异常
当我们运行时，会发生异常

查看异常
自带工具查看
如果你觉得标识的不太清晰，可以点击如图所示图标，展开信息

通过指令将异常保存
gradlew build --stacktrace > logs.txt 2>logErrors.txt
编译前，请确认gradle环境变量已配置，关于build Task请查看Gradle总结。

通过上述指令，将信息分别保存到上述文件中(默认项目根目录)：
logs.txt:编译过程信息
logErrors.txt：异常信息
logs、logErrors信息如下：

分析异常
在logErrors中看到Program type already present: okio.AsyncTimeout$1，如何查看是否有多个的Okio文件呢？
通过搜索栏查看
双击Shift，在搜索框中输入Okio，可以看到有2条okio的信息

在Terminal中输入指令
gradlew -q app:dependencies

在External Libraries中查看对应依赖

解决
Group与module的区别
要解决上述问题，首先要明白Group与module的区别，然而搜索了一遍，好像网上没有给出比较清晰的解释，而这些又是解决依赖冲突这些问题首先要明白的问题，本人在摸索中，稍微总结了一下(如有问题，还请包含)
Module
具有独立功能的模块
Module中可能还包含有Module
implementation分号之后的部分
Group
Module的集合
implementation分号之前的部分
实例分析
以下图为例，加入我们要了解com.android.support:design:26.1.0中，group和module分别是哪些呢？

在Terminal中输入指令
gradlew -q app:dependencies

在 Maven Repository中查找com.android.support:design:26.1.0
可以清晰的看到，group为：com.android.support，
module为下面的内容：
support-v4
appcompat-v7
recyclerview-v7
transition

解决依赖
解决依赖本文提供两种方式
exclude方式
特点：
配置较为麻烦，需要在引起冲突的每个依赖上进行exclude操作
配置繁琐，不美观

通过configurations方式
特点：
在configurations中，统一指定要配置的方式
配置简单，较为整洁

通过configurations.all同一版本


版权声明：本文为博主原创文章，未经博主允许不得转载。 https://blog.csdn.net/Calvin_zhou/article/details/80880501 
