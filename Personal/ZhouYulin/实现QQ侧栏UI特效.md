学习了一天属性动画方面的知识，为了能更好理解，我尝试去实现当前QQ的抽屉动画。
仔细观察，当前QQ滑动拉出侧栏时并不像是拉出抽屉，而像是一个布局覆盖着另一个布局，拉动侧栏只像是把上面的布局推开。
所以布局如下
```xml
<?xml version="1.0" encoding="utf-8"?>
<android.support.v4.widget.DrawerLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:id="@+id/drawerlayout"
    tools:context=".MainActivity">
    <RelativeLayout
        android:layout_width="match_parent"
        android:layout_height="match_parent">
        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="match_parent">
        </LinearLayout>
        <RelativeLayout
            android:layout_width="match_parent"
            android:layout_height="match_parent">
        </RelativeLayout>
    </RelativeLayout>
    <fragment
        android:name="com.example.qqdrawer.Fragleft"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:layout_gravity="left" />
</android.support.v4.widget.DrawerLayout>
```
主页面用了RelativeLayout，在里面又定义了2个布局，百度查询得知，在相对布局下，上面的控件会在下面的控件的底部
侧栏用了fragment。
```JAVA
layout.measure(0,0);
final float width=layout1.getMeasuredWidth()*0.2f;//可以底部获取布局的宽度
layout.setTranslationX(-width);                  //将底部布局向做移动宽度的0.2倍
        ```
接下来只需使用addDrawerListener设置监听抽屉，然后重写onDrawerSlide来移动控件
```JAVA
@Override
            public void onDrawerSlide(View view, float v) {
                layout1.setTranslationX(-width+width*v);
                layout2.setTranslationX(view.getMeasuredWidth()*v);
            }
```


大功告成！这样就简单实现了。

![](https://github.com/Zhouyulin1220/Gobang/blob/master/qq_2.gif)


如果再利用setAlpha()和setScale()来对控件进行缩放和透明设置，还能实现如图效果
![](https://github.com/Zhouyulin1220/Gobang/blob/master/qq_1.gif)
