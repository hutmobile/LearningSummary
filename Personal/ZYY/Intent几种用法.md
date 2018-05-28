
1.调用拨号界面
  Intent intent = new Intent(Intent.Action_DIAL,Uri.parse("tel:123456"));
  startActivity(intent);
2.发送短信
  Intent intent = new Intent(Intent.Action_SENDTO,Uri.parse("sms:123456"));
  startActivity(intent);
3.打开网页
  Intent intent = new Intent(Intent.Action_VIEW,Uri.parse("http://www.baidu.com"));
  startActivity(intent);
4.播放音频
  Intent intent = new Intent(Intent.Action_VIEW);
  intent.setDataAndType(Uri.parse("file:///"+Environment.getExternalStorageDirectory().getAbsolutePath()+"132.mp3"),
    +"audio/*");
  startActivity(intent);
