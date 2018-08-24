2018.08.24

https://blog.csdn.net/youyou200609/article/details/53147052

NetworkSecurityConfig: No Network Security Config specified, using platform default 出现这个问题，一直不能解决
已经加了配置

<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />


一直报这个错误
D/NetworkSecurityConfig: No Network Security Config specified, using platform default

原来需要线程处理，android的线程和 java服务器端的是有区别的，
一直在使用 thread中使用，结果报错
原来需要
handler.sendMessage(msg);

new Thread() {
    public void run() {
        Message msg =new Message();
        try {

            Map<String,Object> map = new HashMap<>();
            map.put("num",2);
            String infoo = HttpClient.post("http://192.168.1.106:8080/star/findStar",map);
            msg.obj = infoo;
        } catch (Exception e) {
            Log.e("","",e);
        }
        handler.sendMessage(msg);

    }
}.start();
