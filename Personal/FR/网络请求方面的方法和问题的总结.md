1.oKHttp发送网络请求(Util)
===
```
    public static void sendOkHttpRequest(String address,okhttp3.Callback callback){
        OkHttpClient client = new OkHttpClient();
        Request request = new Request.Builder().url(address).build();//设置目标的网络地址
        client.newCall(request).enqueue(callback); //发送请求并获取服务器返回的数据
    }
``` 
> OkHttp的execute的方法是同步方法,enqueue的方法是异步方法
