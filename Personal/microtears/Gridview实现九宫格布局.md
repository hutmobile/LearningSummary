Gridview实现九宫格布局
===
由于GridView只支持指定列数和列宽，所以想要实现宽高一致的九宫格布局就需要在代码中动态修改view的宽度
假如GridView中ItemView布局如下：
```xml
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:descendantFocusability="blocksDescendants"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content">

    <ImageView
        android:id="@+id/image"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_centerInParent="true"
        android:clickable="false"></ImageView>

</RelativeLayout>
```
GridView布局文件如下：
```xml
<?xml version="1.0" encoding="utf-8"?>
<android.support.constraint.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@color/go"
    tools:context=".Going">

    <GridView
        android:id="@+id/plane"
        android:layout_width="0dp"
        android:layout_height="0dp"
        android:layout_marginBottom="32dp"
        android:layout_marginEnd="32dp"
        android:layout_marginStart="32dp"
        android:layout_marginTop="32dp"
        android:horizontalSpacing="0dp"
        android:numColumns="auto_fit"
        android:scrollbars="none"
        android:stretchMode="columnWidth"
        android:verticalSpacing="0dp"
        app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintDimensionRatio=""
        app:layout_constraintEnd_toEndOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toBottomOf="@+id/constraintLayout" />

</android.support.constraint.ConstraintLayout>
```
由于列数固定，列宽固定，所以我们可以确定GridView的宽度：
```kotlin
//获取内边距
val margin = plane.layoutParams as ViewGroup.MarginLayoutParams
val bad = margin.marginStart + margin.marginEnd
//获取屏幕宽度
var dis = this.resources.displayMetrics.widthPixels
val param = plane.layoutParams
//指定GridView宽度
param.width = dis - bad
```
然后根据ItemView指定GridView的高度
```kotlin
//由于ItemView只有一个简单的ImageView，所以此时的宽度之比即为GridView与Image的宽度之比
val b = param.width.toDouble() / bitmap.width
//根据刚才得到的壁纸重新指定GridView高度，这样就不会在现实的时候留有空隙
param.height = (bitmap.height * b + 0.5).toInt() //b== param.height / bitmap.height
```
接下来还需要在GridViewAdapter中做进一步修改，重新设定ItemView的宽高
GridViewAdapter中getView方法中实现重新设定：
```kotlin
override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
    var image = this.arr[position].bitmap
    var inflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
    //将第二个参数指定为null，表示不使用ItemView中的根部局为父布局
    var itemView = inflater.inflate(R.layout.itemView, null)
    //得到ImageView
    var imageView = itemView.image
    imageView.scaleType = ImageView.ScaleType.CENTER_CROP
    //setHeight
    val layoutParams = imageView.layoutParams
    //column，row为传入的列数和行数
    layoutParams.width = parent!!.width / column
    layoutParams.height = parent!!.height / row
    //setImageRes
    imageView.setImageBitmap(image)
    return itemView
}
```
最终效果图如下：<br>
![](https://s1.ax1x.com/2018/05/12/CBRSRs.png)
![](https://s1.ax1x.com/2018/05/12/CB2zGj.png)
