# QQ_SDK和ANDROID_SDK_28的兼容问题

Android 最新的SDK早就出来了，版本号为28，包含了很多新东西，用起来是爽了，可其中的坑是一个接一个的，今天主要说下集成QQ_SDK的时候遇到的一些问题

首先是Android这次在SDK_28中移除了QQ_SDK还在使用的Apache_HTTP组件，so，如果你想用上最新的SDK而且还要集成QQ登陆等功能，那么你需要这样做：
在你的app下的build.gradle中添加下面这句话。

```Groovy
android {
    //QQ_SDK使用了AndroidX去掉的Apache_Http组件
    useLibrary 'org.apache.http.legacy'
}
```

其次还使用了这些被移除的组件：
同样在下面的位置添加相应的依赖。

```Groovy
dependencies {
    implementation 'org.jbundle.util.osgi.wrapped:org.jbundle.util.osgi.wrapped.org.apache.http.client:4.1.2'
    //noinspection DuplicatePlatformClasses
    implementation 'commons-logging:commons-logging:1.2'
}
```

但如果你的项目开启了混淆，你会发现即是这样做了之后还是会报错，你还需要在你的混淆规则里添加以下规则：

```proguard-rules
#
-keep class org.apache.** {*;}
-dontwarn org.apache.**
-keep class org.apache.http.** { *; }
-keep class android.net.http.** { *; }
-dontwarn org.apache.http.**
-dontwarn android.net.http.**
```

OK 解下来就可以正常使用了

下次再讲SDK_28中的新控件在使用方面的坑。
