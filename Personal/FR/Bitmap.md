android创建bitmap的多种方法
===
createBitmap(Bitmap source, int x, int y, int width, int height)      (这次拼图app用到，切图)
---
>createBitmap(Bitmap source, int x, int y, int width, int height)：从原位图中指定坐标点（x,y）开始，
从中挖取宽width、高height的一块出来，创建新的Bitmap对象
<br>
createScaledBitmap(Bitmap source, int dstWidth, int dstHeight, boolean filter)：对原位图进行缩放，
缩放成指定width、height大小的新位图对象
<br>
createBitmap(int width, int height, Bitmap.Config config)：创建一个宽width、高height的新位图
<br>
createBitmap(Bitmap source, int x, int y, int width, int height, Matrix matrix, boolean filter)：
从原位图中指定坐标点（x,y）开始，从中挖取宽width、高height的一块出来，创建新的Bitmap对象。并按Matrix指定的规则进行变换
<br>

BitmapFactory工具类，用于从不同的数据来解析、创建Bitmap对象
===
>decodeByteArray(byte[] data, int offset, int length)：从指定的字节数组的offset位置开始，
将长度为length的字节数据解析成Bitmap对象
<br>
decodeFile(String pathName)：从pathName指定的文件中解析、创建Bitmap对象
<br>
decodeFileDescriptor(FileDescriptor fd)：从FileDescriptor对应的文件中解析、创建Bitmap对象
<br>
decodeResource(Resources res, int id)：根据给定的资源ID从指定资源中解析、创建Bitmap对象
<br>
decodeStream(InputStream is)：从指定的输入流中解析、创建Bitmap对象
<br>

获取本地图片创建bitmap
---
```
bmp = BitmapFactory.decodeResourse(this.getResources(),R.id.image);
```
<br>
获取网络图片创建bitmap
---
```
URL conurl = new URL(url);
  HttpURLConnection con = (HttpURLConnection)conurl.openConnection();
  bmp = BitmapFactory.decodeStream(con.getInputStream());
```
