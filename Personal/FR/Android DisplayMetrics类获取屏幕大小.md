第一种方法
=========
```
WindowManager wm = (WindowManager)context.getSystemService(Context.WINDOW_SERVICE);
DisplayMetrics metrics = new DisplayMetrics();
wm.getDefaultDisplay().getMetrics(metrics);
```
第二种方法
=========
```
DisplayMetrics metrics = new DisplayMetrics();
getWindowManager().getDefaultDisplay().getMetrics(metrics);
```
第三种方法
=========
```
DisplayMetrics metrics = Context.getResources().getDisplayMetrics();
```
获取宽、高
----------
```
    //手机屏幕的分辨率，物理宽高值如1080*1920
    int width = metrics.widthPixels; //屏幕像素的宽度，单位（px）
    int height = metrics.heightPixels; //表示屏幕的像素高度，单位（px）
    
    float density = metrics.density;    //显示器的逻辑密度
```
