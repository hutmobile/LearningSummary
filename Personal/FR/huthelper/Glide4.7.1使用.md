#Glide 4.7.1 学习使用
##在项目中添加依赖
```
repositories {
  mavenCentral()
  google()
}

```
```
dependencies {
  implementation 'com.github.bumptech.glide:glide:4.7.1'
  annotationProcessor 'com.github.bumptech.glide:compiler:4.7.1'
}
```
Glide默认会导入Android的support-v4包。4.71版本默认导入的是v4包的27版本。如果你的项目中有v4包的别的版本，就会引起冲突发生错误如：
java.lang.NoSuchMethodError: No static method

###权限添加；视情况选择相应的权限
```
    <uses-permission android:name="android.permission.INTERNET"/>	
    //它可以监听用户的连接状态并在用户重新连接到网络时重启之前失败的请求    
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>	
    //用于硬盘缓存和读取    
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>    
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```
####基本使用
#####加载图片三步走，1.with,2.load,3.into;
```
String url = "";

Glide.with(this) //with()方法可以接收Contexr,Activity,Fragment类型的数据
     .load(url) //load()方法中除可以传入图片地址外，还可以传入图片文件File,resource,图片的byte数组等
     .into(imageView);
```
**注意with()方法中传入的实例会决定Glide加载图片的生命周期，如果传入的Activity实例或者Fragment实例，那么当这个Activity或者这个Fragment被销毁时，图片加载也会停止，如果传入的时ApplicationContext，那么只有当这个应用程序被杀死的时候，图片加载才会停止**

#####取消图片也是三步走，1.with(),2.load(),3.clear();
```
//一般很少用到，因为图会跟with(this)生命周期消亡而消亡
Glide.with(this)
     .load(url) 
     .clear();  
```
```
Glide中的大部分设置项都可以通过 RequestOptions 类和 apply() 方法来应用到程序中。 
RequestOptions options = new RequestOptions()                
       .placeholder(R.mipmap.ic_launcher)	        //加载成功之前占位图 
       .error(R.mipmap.ic_launcher)			 //加载错误之后的错误图   
       .override(400,400)					//指定图片的尺寸                
       //指定图片的缩放类型为fitCenter （等比例缩放图片，宽或者是高等于ImageView的宽或者是高。）                
       .fitCenter()                
       //指定图片的缩放类型为centerCrop （等比例缩放图片，直到图片的狂高都大于等于ImageView的宽度，然后截取中间的显示。）
       .centerCrop()                
       .circleCrop()                     //指定图片的缩放类型为circleCrop （圆形）
       .skipMemoryCache(true)							//跳过内存缓存   
       .diskCacheStrategy(DiskCacheStrategy.ALL)		//缓存所有版本的图像  
       .diskCacheStrategy(DiskCacheStrategy.NONE)		//跳过磁盘缓存
       .diskCacheStrategy(DiskCacheStrategy.DATA)		//只缓存原来分辨率的图
       .diskCacheStrategy(DiskCacheStrategy.RESOURCE)	//只缓存最终的图片 
        ;        
        Glide.with(this)
             .load(url)               
             .apply(options)     
            .into(imageView);

```
Glide可以加载GIF图片
```
//在with()方法的后面加入了一个asBitmap()方法，这个方法的意思就是说这里只允许加载静态图片，不需要Glide去帮我们自动进行图片格式的判断了。如果你传入的还是一张GIF图的话，Glide会展示这张GIF图的第一帧，而不会去播放它。对应的方法是asGif()
Glide.with(this)
    .asBitmap()
    .load(url)
    .into(imageView);
```
