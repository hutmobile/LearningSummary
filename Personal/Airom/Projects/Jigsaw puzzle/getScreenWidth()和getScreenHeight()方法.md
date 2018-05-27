getScreenWidth()和getScreenHeight()方法
---

~~~
以下This works better in my case. No need for context

    public static int getScreenWidth() {
        screenWidth = Resources.getSystem().getDisplayMetrics().widthPixels;
        return screenWidth;
    }
    //此方法不包含导航栏高度
    public static int getScreenHeight() {
        screenHeight = Resources.getSystem().getDisplayMetrics().heightPixels;
        return screenHeight;
    }


或者
//        DisplayMetrics metrics =new DisplayMetrics();
//        getWindowManager().getDefaultDisplay().getRealMetrics(metrics);
//        screenWidth = metrics.widthPixels;
//        screenHeight = metrics.heightPixels;

如果想获取包含导航栏在内的高度，如下
WindowManager windowManager =
        (WindowManager) BaseApplication.getApplication().getSystemService(Context.WINDOW_SERVICE);
    final Display display = windowManager.getDefaultDisplay();
    Point outPoint = new Point();
    if (Build.VERSION.SDK_INT >= 19) {
        // include navigation bar
        display.getRealSize(outPoint);
    } else {
        // exclude navigation bar
        display.getSize(outPoint);
    }
    if (outPoint.y > outPoint.x) {
        mRealSizeHeight = outPoint.y;
        mRealSizeWidth = outPoint.x;
    } else {
        mRealSizeHeight = outPoint.x;
        mRealSizeWidth = outPoint.y;
    }

~~~
