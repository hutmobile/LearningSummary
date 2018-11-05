View的测量onMeasure()与MeasureSpec
===
一、MeasureSpec的概念
---
MeasureSpec的值由specSize和soecMode共同组成，其中specSize记录的是大小，specMode记录的是规格。

二、SpecMode的三种模式
---
1.EXACTLY</Br>
当我们将控件的layout_width属性或者layout_height属性指定为具体的数值时，比如android:layout_width="200dp",或者指定match_parent时，系统会使用这个模式

2.AT_MOST</Br>
当控件的layout_width属性或者layout_height属性设置为wrap_content时，控件大小一般会随着内容的大小而变化，不会超过父控件的大小

3.UNSPECIFIED</Br>
可以将视图按照自己的意愿设置成任意的大小，没有任何限制。一般在绘制自定义View的时候才使用