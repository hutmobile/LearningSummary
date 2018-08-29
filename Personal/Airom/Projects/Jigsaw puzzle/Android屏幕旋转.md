---
Android屏幕旋转
~~~
默认情况下，当用户手机的重力感应器打开后，旋转屏幕方向，会导致当前activity发生onDestroy-> onCreate，这样会重新构造当前activity和界面布局，所以应该在Activity销毁前保存当前活动的状态，在Activity再次 Create的时候载入配置
(给每个Activity加上 android:configChanges=”keyboardHidden|orientation”属性)。
在需要控制屏幕显示方向的Activity中重写 onConfigurationChanged(Configuration newConfig)方法



强制竖屏或横屏方法
activity中加上android:screenOrientation属性。他有下面几个參数：

"unspecified":默认值 由系统来推断显示方向.判定的策略是和设备相关的，所以不同的设备会有不同的显示方向.
"landscape":横屏显示（宽比高要长）
"portrait":竖屏显示(高比宽要长)
"user":用户当前首选的方向
"behind":和该Activity以下的那个Activity的方向一致(在Activity堆栈中的)
"sensor":有物理的感应器来决定。假设用户旋转设备这屏幕会横竖屏切换。
"nosensor":忽略物理感应器。这样就不会随着用户旋转设备而更改了（"unspecified"设置除外）。


 结合OrientationEventListener,自定义旋转监听设置（ 参考地址4）




参考链接
https://www.cnblogs.com/bluestorm/p/3665890.html
http://blog.51cto.com/2960629/701227
https://www.cnblogs.com/gccbuaa/p/6708317.html
http://www.jb51.net/article/64735.htm
~~~
