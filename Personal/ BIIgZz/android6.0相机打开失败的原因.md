### 现象
我在练习使用相机的时候，打开相机出现闪退的情况。

### 问题原因
从Android6.0开始，系统对用户权限更加重视，在Android6.0之前，应用在安装之前只需要把权限列出来给用户看一下，用户同意了这个应用就可以使用它需要的权限。但是到了Android6.0及以后一些敏感权限需要动态申请权限，用户可以同意也可以选择拒绝，同意了之后可以再系统应用权限设置关闭它的权限。当然这些应用权限如果不动态申请的话APP就会闪退了。

### 解决方案  

先编写拍照方法

```
    //拍照的代码
 private void takePhoto() {
        Intent takePictureIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
        if (takePictureIntent.resolveActivity(getPackageManager()) != null) {
            //创建一个File
            photoFile = ImageUtil.createImageFile();
            if (photoFile != null) {
                if (Build.VERSION.SDK_INT >= 24) {
                    //如果是7.0及以上的系统使用FileProvider的方式创建一个Uri
                    photoURI = FileProvider.getUriForFile(this, "com.hm.camerademo.fileprovider", photoFile);
                    takePictureIntent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
                    takePictureIntent.setFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION);
                } else {
                    //7.0以下使用这种方式创建一个Uri
                    photoURI = Uri.fromFile(photoFile);
                }
                //将Uri传递给系统相机
                takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT, photoURI);
                startActivityForResult(takePictureIntent, TAKE_PHOTO);
            }
        }
    }
```

1. 先 在AndroidManifest.xml中声明我们需要的读取内存权限
	

```
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

2. 调用ContextCompat.checkSelfPermission(Context context, String permission)检查是否有WRITE_EXTERNAL_STORAGE权限，如果没有就申请权限，否则直接拍照.
```
	if(ContextCompat.checkSelfPermission(MainActivity.this,Manifest.permission.WRITE_EXTERNAL_STORAGE)!=PackageManager.PERMISSION_GRANTED)
		{
		 //申请权限，REQUEST_TAKE_PHOTO_PERMISSION是自定义的常量 
		ActivityCompat.requestPermissions(this,new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE}, REQUEST_TAKE_PHOTO_PERMISSION); 
	 } 
 } else { 
	 //有权限，直接拍照 
	 takePhoto();
 }
```
3. 重写onRequestPermissionsResult(int requestCode, String[] permissions,int[] grantResults)方法，检查权限申请是否成功。
  

```
 @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        if (requestCode == REQUEST_TAKE_PHOTO_PERMISSION) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
            //申请成功，可以拍照
                takePhoto();
            } else {
                Toast.makeText(this, "拒绝授予权限", Toast.LENGTH_SHORT).show();
            }
            return;
        }
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
    }
```



###  其他类似情况的解决方案

| 权限组    |   权 限 |   Col3   |
| :-------- | --------:| :------: |
| CALENDAR| 	READ_CALENDAR |  field3  |
||WRITE_CALENDAR|
|CONTACTS|READ_CONTACTS|
||WRITE_CONTACTS|
||	GET_ACCOUNTS|
|LOCATION	|ACCESS_FINE_LOCATION|
||ACCESS_COARSE_LOCATION|
|MICROPHONE|RECORD_AUDIO|
|PHONE|READ_PHONE_STATE|
||	CALL_PHONE|
||READ_CALL_LOG|
||WRITE_CALL_LOG|
||ADD_VOICEMAIL|
||USE_SIP|
||PROCESS_OUTGOING_CALLS|
|SENSORS|BODY_SENSORS|
|SMS|SEND_SMS|
||RECEIVE_SMS|
||READ_SMS|
||RECEIVE_WAP_PUSH|
||RECEIVE_MMS|
|STORAGE|READ_EXTERNAL_STORAGE|
||WRITE_EXTERNAL_STORAGE|  

这是android中的9组24个危险权限，需要进行运行时权限处理，如果不在表中就只需要在AndroidManifest中添加权限声明就可以了。
