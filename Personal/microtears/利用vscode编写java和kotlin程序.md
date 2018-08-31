# 在VSCode中编写Kotlin/Java

## 前言

不希望每次运行一下代码就要去启动Android Studio这个庞然大物，正好vscode可以做一个轻量级的IDE，所以配置了vscode用来编写Kotlin程序

## 环境配置

首先可以在Android Studio的安装目录下找到Kotlin Compiler：  
![1](https://s1.ax1x.com/2018/05/12/CBWw9J.png)  
![1](https://s1.ax1x.com/2018/05/12/CBW039.png)  
在环境变量中添加以下项：  
值为：Kotlin Compiler Path\bin  
例如：D:\Program Files\Android\Android Studio\plugins\Kotlin\kotlinc\bin  
![1](https://s1.ax1x.com/2018/05/12/CBW4gA.png)  
然后再控制台输入命令`kotlinc -version`检测环境是否配置妥当  
如果正常，则如下图所示  
![1](https://s1.ax1x.com/2018/05/12/CBhUSJ.png)  
如果出现这种情况  
![1](https://s1.ax1x.com/2018/05/12/CBhtW4.png)  
则是jdk版本配置不正确或者JAVA环境配置错误所致，重新配置即可（推荐使用jdk1.8）  

## 配置VSCODE

在vscode扩展中安装Kotlin Language和Code Runner这两个扩展包  
![1](https://s1.ax1x.com/2018/05/12/CB4bE6.png)  
![1](https://s1.ax1x.com/2018/05/12/CB4qUK.md.png)  
安装后重启加载扩展，就可以编写Kotlin代码并编译运行了,右键`Run Code`或者`Ctrl`+`Alt`+`N`运行程序，,OK，像这样  
![1](https://s1.ax1x.com/2018/05/12/CB7My4.png)  
但是我们发现，输出面板中文出现了乱码，可行的解决办法是在用户设置中添加一句`"code-runner.runInTerminal": true,`，表示让Kotlin程序通过Terminal运行，就不会出现中文乱码了  
效果如下：  
![1](https://s1.ax1x.com/2018/05/12/CB7alD.png)  
而且在程序目录下还会生成相应的jar包，如：  
![1](https://s1.ax1x.com/2018/05/12/CB7USO.png)  

## 总结

至此，vscode关于Kotlin的配置就已经完成了，__Enjoy Your Code！__