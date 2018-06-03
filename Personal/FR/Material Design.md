Toolbar
===
> 为了能让Toolbar单独使用深色主题，使用android:theme属性，将Toolbar的主题指定成ThemeOverlay.AppCompat.Dark.ActionBar,但是这样指定完之后会出现新问题，如果Toolbar中有菜单按钮，那么弹出的菜单项也会变成深色主题，这时可以使用app:popupTheme属性单独将弹出的菜单项指定成淡色主题

关于错误：android.widget.Toolbar无法转换为android.support.v7.widget.Toolbar
---
>原因是导入库错误
删掉
import android.widget.Toolbar;
增加 
import android.support.v7.widget.Toolbar;

DrawerLayoutt(滑动菜单)
===
>1.layout_gravity属性必须指定

2.
```
  ActionBar actionBar = getSupportActionBar();
  if(actionBar != null){
    // 给左上角图标的左边加上一个返回的图标
    actionBar.setDisplayHomeAsUpEnable(true);
    actionBar.setHomeAsUpIndicator(R.drawable. ...);
  }
```
3.关于ActionBar中setDisplayHomeAsUpEnabled(true)等方法的问题
---
>(1) actionBar.setDisplayHomeAsUpEnabled(true)    //给左上角图标的左边加上一个返回的图标 

>(2) actionBar.setDisplayShowHomeEnabled(true)   //使左上角图标是否显示，如果设成false，则没有程序图标，仅仅就个标题，否则，显示应用程序图标，对应id为Android.R.id.home

>(3) actionBar.setDisplayShowCustomEnabled(true)  //使自定义的普通View能在title栏显示，即actionBar.setCustomView能起作用

>(4)setHomeButtonEnabled和setDisplayShowHomeEnabled共同起作用，如果setHomeButtonEnabled设成false，即使setDisplayShowHomeEnabled设成true，图标也不能点击

设置toolbar和系统状态栏颜色一致
===

>1. 在代码中添加如下代码：
```
   if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
       WindowManager.LayoutParams localLayoutParams = getWindow().getAttributes();
       localLayoutParams.flags = (WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS | localLayoutParams.flags);
       }
```
>2.在toolbar中加入如下代码
```
    android:fitsSystemWindows="true"
```
