利用OkHttp3,Gson和Glide显示Unsplash网站的图片
===
### 1. OkHttp简介
[OkHttp](https://github.com/square/okhttp)是一个处理网络请求的开源项目，Android 当前最火热网络框架，由移动支付Square公司贡献。
### 2. Glide简介
[Glide](https://github.com/bumptech/glide)是Google推荐的一套快速高效的图片加载框架，作者是bumptech，功能强大且使用方便，实际的android应用开发中，有不少的开发者在使用它。
### 3. Gson简介
[Gson](https://github.com/google/gson)是Google公司发布的一个开源源代码的Java库，主要用途为串行化Java对象为JSON字符串，或反串行化Json字符串成Java对象。    
### 4. Unsplash API申请
[Unsplash developers](https://unsplash.com/developers)<br>
![](https://s1.ax1x.com/2018/05/26/CfO7Px.png)<br>
首先注册Unsplash Developer账号并登陆<br>
![](https://s1.ax1x.com/2018/05/26/ChAhUf.png)<br>
然后选择your apps，进入之后页面如下图所示<br>
![](https://s1.ax1x.com/2018/05/26/CfOfr4.png)
点击New Application并填写相关信息，然后选择你创建的applications，找到分配的KEY并保存下来<br>
![](https://s1.ax1x.com/2018/05/26/CfOhqJ.png)
### 5. 利用OkHttp3向服务器获取数据并利用Gson解析
```kotlin
private fun getImages() {
        load {
            //ACCESSS_KEY就是刚才保存下来的值，这里只获取了默认最新的10张图片，关于更多用法可以参照Unsplash API文档修改
            val url = "https://api.unsplash.com/photos?client_id=ACCESSS_KEY"
            val request = Request.Builder().url(url).build()
            lateinit var response: Response
            try {
                response = client.newCall(request).execute()
                if (response.isSuccessful) {
                    val gson = Gson()
                    val json = response.body()!!.string()
                    gson.fromJson<List<Unsplash>>(json, getType<List<Unsplash>>()).forEach { if (!images.contains(it)) images.add(it) }
                    response.body()!!.close()
                }
            } catch (e: Exception) {
                println(e.printStackTrace())
            }
        } then {
            (unsplash.adapter as QuickAdapter).replaceData(images)
        }
    }
```
### 6. Glide加载图片
```kotlin
//这里的RecyclerAdapter继承自BRVAH，故实际操作在convert方法中进行
override fun convert(helper: BaseViewHolder, item: Unsplash) {
    //其他控件信息的修改
        helper.setText(R.id.like_count, item.likes.toString())
                .setText(R.id.size, "${item.height}x${item.width}")
                .setText(R.id.name, item.user.name)
                .setText(R.id.color, item.color)
                .setTextColor(R.id.color, KtColorUtil.getReverseForegroundColor(Color.parseColor(item.color)))
                .setShapeColor(R.id.color, Color.parseColor(item.color))
                .setShapeColor(R.id.name, Color.parseColor("#5dffffff"))
                .setShapeColor(R.id.size, Color.parseColor("#500084ff"))
                .addOnClickListener(R.id.fav)
        val result = DataSupport.select("photoid").where("photoid=?", item.photoid).limit(1).find(Unsplash::class.java).toList()
        if (!result.isEmpty()) item.isFav = true else item.isFav = false
        if (item.isFav) helper.setBackgroundRes(R.id.fav, R.drawable.baseline_bookmark_white_24dp)
        else helper.setBackgroundRes(R.id.fav, R.drawable.baseline_bookmark_border_white_24dp)
        val option = RequestOptions.centerCropTransform()
        //把显示图片交给Glide去完成
        Glide.with(mContext).load(item.urls.small).apply(option).into(helper.getView(R.id.image))
    }
``` 
### 7. 最终效果
![](https://s1.ax1x.com/2018/05/26/CfOoI1.png)![](https://s1.ax1x.com/2018/05/26/CfO5Z9.png)
