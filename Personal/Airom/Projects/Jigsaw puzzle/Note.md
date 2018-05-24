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


状态栏与导航栏的坑

首先学习单词，Translucent：半透明

如果用        <item name="android:windowFullscreen">true</item>
或者                    | View.SYSTEM_UI_FLAG_FULLSCREEN
本质一样，都是Activity全屏显示，且状态栏被覆盖掉，状态栏默认隐藏，下拉状态栏会短暂显示，但背景是半透明（透明灰色），
或者没有全屏，只设置半透明状态栏        <!--<item name="android:windowTranslucentStatus" tools:targetApi="kitkat">true</item>-->

此时调用                window.setStatusBarColor(Color.TRANSPARENT);
或者
            //需要设置这个 flag 才能调用 setStatusBarColor 来设置状态栏颜色
            window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);        <item name="android:statusBarColor" tools:targetApi="lollipop">@android:color/transparent</item>
本质一样，把状态栏的半透明设置为全透明，都不会起作用！！！！！！！！！！！都不会起作用！！！！！！！！！！！TAT

同理，导航栏
如果用        <!--<item name="android:windowTranslucentNavigation" tools:targetApi="kitkat">true</item>-->
把导航栏这职位半透明后
此时调用                window.setNavigationBarColor(Color.TRANSPARENT);
或者            <item name="android:navigationBarColor" tools:targetApi="lollipop">@android:color/transparent</item>
本质一样，欲把状态栏的半透明设置为全透明，都不会起作用！！！！！都不会起作用！！！！！！TAT

而且
如果用        <item name="android:windowFullscreen">true</item>
或者                    | View.SYSTEM_UI_FLAG_FULLSCREEN
本质一样，都是Activity全屏显示，但是！！！但是！！！导航栏不自动隐藏，且活动被挤到导航栏上面！！！！！！

setSystemUiVisibility(int visibility)传入的实参类型如下：
1.View.SYSTEM_UI_FLAG_VISIBLE ：状态栏和Activity共存，Activity不全屏显示。也就是应用平常的显示画面

2.View.SYSTEM_UI_FLAG_FULLSCREEN ：Activity全屏显示，使状态栏出现的时候，不会重新调整activity的高度，状态栏覆盖在activity之上。

3. View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN ：Activity全屏显示，但是状态栏不会被覆盖掉，而是正常显示，只是Activity顶端布   局会被覆盖住

4.View.INVISIBLE ： Activity全屏显示，隐藏状态栏

参考：
https://www.jianshu.com/p/8b3ec46dac39
https://www.jianshu.com/p/11a2b780fd9b
https://www.jianshu.com/p/e27e7f09d1f7

https://blog.csdn.net/sdvch/article/details/44209959
https://blog.csdn.net/guolin_blog/article/details/51763825
动态状态栏颜色https://www.jianshu.com/p/a44c119d6ef7
android 变色状态栏https://blog.csdn.net/fdd11119/article/details/51364740
着色模式https://blog.csdn.net/u013647382/article/details/51603141


不确定正确与否https://blog.csdn.net/stevenhu_223/article/details/12428591

