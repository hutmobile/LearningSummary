##  如何动态设置view或者布局的属性
有时我们需要在应用中动态改变图片或某一块布局的大小。这就不能用XML文件写成固定值，而需要在java代码中动态设置。

1. 获取你要进行改变的控件的布局

```
 RelativeLayout.LayoutParams params = (RelativeLayout.LayoutParams)imageView.getLayoutParams();
```
   然而这时候你一定要注意强制类型转换时的LayoutParams类型，因为android中存在3种LayoutParams，即RelativeLayout.LayoutParams、LinearLayout.LayoutParams、ViewGroup.LayoutParams，那么我们该用哪一个呢？
   
*要看你要操作的view在布局文件中的父控件是什么类型的，若父控件是RelativeLayout则需要强制转换为RelativeLayout.LayoutParams，其它类型依次类推。*  

        
2. 接来下设置布局或者控件的属性

```
  Params.height = 100;
```
      
除了高度还有很多属性可以设置。

3.最后设置下控件的布局就可以了

```
imageView.setLayoutParams(params);
```

