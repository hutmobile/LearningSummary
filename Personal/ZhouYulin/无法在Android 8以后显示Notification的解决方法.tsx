学习第一行代码时，由于Notification在书中的实例无法在模拟器和手机上显示通知，经过网上的搜索，了解了原因。
第一行代码中的关于通知的写法已经过时，NotificationChannel是android8.0新增的特性，如果App的targetSDKVersion>=26，没有设置channel通知渠道的话，就会导致通知无法展示。
以下是可以同时在8.0版本或者8.0以下版本运用的方法：

    public static final String id="id";
    public static final String name="name";
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.button_noty:
                NotificationManager manager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
                if (Build.VERSION.SDK_INT >= 26) {
                    NotificationChannel channel = new NotificationChannel(id, name, NotificationManager.IMPORTANCE_HIGH);
                    manager.createNotificationChannel(channel);
                    Notification notification = new Notification.Builder(this, id)
                            .setContentTitle("通知")
                            .setContentText("测试内容测试内容测试内容测试内容API26")
                            .setSmallIcon(android.R.drawable.sym_def_app_icon)
                            .setAutoCancel(true)
                            .build();
                    manager.notify(1, notification);
                }
                else{
                    Notification notification = new NotificationCompat.Builder(this, id)
                            .setContentTitle("通知")
                            .setContentText("测试内容测试内容测试内容测试内容")
                            .setSmallIcon(android.R.drawable.sym_def_app_icon)
                            .setAutoCancel(true)
                            .build();
                    manager.notify(1, notification);
                }
        }
    }
