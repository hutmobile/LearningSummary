android创建bitmap的多种方法
===
createBitmap(Bitmap source, int x, int y, int width, int height)      (这次拼图app用到，切图)
---
>createBitmap(Bitmap source, int x, int y, int width, int height)：
从原位图中指定坐标点（x,y）开始，从中挖取宽width、高height的一块出来，创建新的Bitmap对象

>createScaledBitmap(Bitmap source, int dstWidth, int dstHeight, boolean filter)：
对原位图进行缩放，缩放成指定width、height大小的新位图对象

>createBitmap(int width, int height, Bitmap.Config config)：
创建一个宽width、高height的新位图

>createBitmap(Bitmap source, int x, int y, int width, int height, Matrix matrix, boolean filter)：
从原位图中指定坐标点（x,y）开始，从中挖取宽width、高height的一块出来，创建新的Bitmap对象。并按Matrix指定的规则进行变换

BitmapFactory工具类，用于从不同的数据来解析、创建Bitmap对象
===
>decodeByteArray(byte[] data, int offset, int length)：
从指定的字节数组的offset位置开始，将长度为length的字节数据解析成Bitmap对象

>decodeFile(String pathName)：
从pathName指定的文件中解析、创建Bitmap对象

>decodeFileDescriptor(FileDescriptor fd)：
从FileDescriptor对应的文件中解析、创建Bitmap对象

>decodeResource(Resources res, int id)：
根据给定的资源ID从指定资源中解析、创建Bitmap对象

>decodeStream(InputStream is)：
从指定的输入流中解析、创建Bitmap对象

获取本地图片创建bitmap
---

```
bmp = BitmapFactory.decodeResourse(this.getResources(),R.id.image);
```

获取网络图片创建bitmap
---

```
URL conurl = new URL(url);
  HttpURLConnection con = (HttpURLConnection)conurl.openConnection();
  bmp = BitmapFactory.decodeStream(con.getInputStream());
```

BitmapFactory.Options的几个重要参数
---
>inJustDecodeBounds:
如果将这个值设置为true，在解码的时候将不会返回bitmap，只会返回这个bitmap的尺寸（当你只想知道一个bitmap的尺寸，但又不想其加载到内存时）

>inSampleSize:
这个值是int，小于1的时候，将会被当做1处理，如果大于1，就会按比例（1/inSampleSize）缩小bitmap的宽和高、降低分辨率，大于1时这个值将会被处置为2的倍数
eg：width=100，height=100，inSampleSize=2，那么就会将bitmap处理为，width=50，height=50，宽高降为1 / 2，像素数降为1 / 4。

>inPreferredConfig:
这个值是设置色彩模式，默认值是ARGB_8888，在这个模式下，一个像素点占用4bytes空间，一般对透明度不做要求的话，一般采用RGB_565模式，这个模式下一个像素点占用2bytes

>inPremultiplied：
这个值和透明度通道有关，默认值是true，如果设置为true，则返回的bitmap的颜色通道上会预先附加上透明度通道

>inScaled：
设置这个Bitmap是否可以被缩放，默认值是true，表示可以被缩放

>outWidth和outHeight：
表示这个Bitmap的宽和高，一般和inJustDecodeBounds一起使用来获得Bitmap的宽高，但是不加载到内存
