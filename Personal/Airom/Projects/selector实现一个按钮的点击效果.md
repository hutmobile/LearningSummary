给按钮都设置点击 selector 的，这样可以清楚的给用户提示，防止过快点击造成多次事件执行（防止按钮重复点击）
不过在 Android 项目中并不都是因为没有设置 selector 而导致用户感觉没有点击中这个按钮的，还有一种情况就是这个按钮的可点击热区太小了，或者较小的区域内承载了过多的可点击按钮。

针对按钮的可点击热区较小的情况，我觉得可以使用控件的 paddingxxx 属性替代部分 marginxxx 属性，margin属性指的控件之外的区域，padding则可以将这些区域归为自身所有，这样既可在不改变 UI 的情况下扩大点击热区。


方法：selector做遮罩，原图做background
建立一个圆形的selector，正常情况下是完全透明的，按下后透明度变小（针对imagebutton和imageview有用）

https://blog.csdn.net/jiankeufo/article/details/73845750


实现将文字在disable时置灰且不可点击，而enable时文字点亮且可点击的功能
https://www.jianshu.com/p/46a68f82eaf8


在selector中设置了点击效果和初始状态效果时，点击却没有反应，错误效果以及代码如下:
https://www.jianshu.com/p/a0ddba6d7969


TextView文字和背景点击效果（针对button和textview有用）
https://blog.csdn.net/lin_dianwei/article/details/79678062
上述文章中Android之drawable state各个属性详解
https://www.cnblogs.com/jenson138/p/4272802.html




