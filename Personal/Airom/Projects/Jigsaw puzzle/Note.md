android:hint
    xml文件EditText中android:hint设置当EditText内容为空时显示的文本，只在EditText为空时显示，输入字符的时候就消失，不影响EditText的文本。
FullscreenActivity默认保持屏幕常亮

    <!-- Application theme. 自定义style，无状态栏标题栏-->
    <style name="AppTheme.NoBar">
        <!-- All customizations that are NOT specific to a particular API-level can go here. -->
        <!-- 隐藏状态栏 -->
        <item name="android:windowFullscreen">true</item>
        <!-- 隐藏标题栏 -->
        <item name="windowNoTitle">true</item>

        <item name="windowActionBar">true</item>

    </style>


        ActionBar actionBar = getSupportActionBar();
        if (actionBar != null) {
            actionBar.hide();
        }
        
        
如何完美隐藏底部虚拟导航栏
https://blog.csdn.net/qq_28484355/article/details/78355816
透明度与十六进制代码转换
https://blog.csdn.net/sky1203850702/article/details/44916819


SYSTEM_UI_FLAG_IMMERSIVE不自动隐藏，会触发任何的监听器
SYSTEM_UI_FLAG_IMMERSIVE_STICKY自动隐藏，不会触发任何的监听器
在android4.4及以上版本中为setSystemUiVisibility()方法引入了一个新的flag:SYSTEM_UI_FLAG_IMMERSIVE，它可以使你的app实现真正意义上的全屏体验。当SYSTEM_UI_FLAG_IMMERSIVE、SYSTEM_UI_FLAG_HIDE_NAVIGATION 和SYSTEM_UI_FLAG_FULLSCREEN三个flag一起使用的时候，可以隐藏状态栏与导航栏，同时让你的app可以捕捉到用户的所有触摸屏事件。

当沉浸式全屏模式启用的时候，你的activity会继续接受各类的触摸事件。用户可以通过在状态栏与导航栏原来区域的边缘向内滑动让系统栏重新显示。这个操作清空了SYSTEM_UI_FLAG_HIDE_NAVIGATION(和SYSTEM_UI_FLAG_FULLSCREEN，如果有的话)两个标志，因此系统栏重新变得可见。如果设置了的话，这个操作同时也触发了View.OnSystemUiVisibilityChangeListener。然而， 如果你想让系统栏在一段时间后自动隐藏的话，你应该使用SYSTEM_UI_FLAG_IMMERSIVE_STICKY标签。请注意，'sticky'版本的标签不会触发任何的监听器，因为在这个模式下展示的系统栏是处于暂时的状态。

https://blog.csdn.net/sdvch/article/details/44209959
https://blog.csdn.net/xiaonaihe/article/details/54929504
https://www.jianshu.com/p/e27e7f09d1f7
