Toolbar
===
> 为了能让Toolbar单独使用深色主题，使用android:theme属性，将Toolbar的主题指定成ThemeOverlay.AppCompat.Dark.ActionBar,但是这样指定完之后会出现新问题，如果Toolbar中有菜单按钮，那么弹出的菜单项也会变成深色主题，这时可以使用app:popupTheme属性单独将弹出的菜单项指定成淡色主题

关于错误：android.widget.Toolbar无法转换为android.support.v7.widget.Toolbar
---
>原因是导入库错误，
删掉

import android.widget.Toolbar;
增加 


import android.support.v7.widget.Toolbar;
