2018.05.19
经常会出现用户按到home键，退出了界面，或者安卓系统意外回收了应用的进程，这种情况下，使用Bundle savedInstanceState就可以用户再次打开应用的时候恢复的原来的状态。

看一段代码：

package com.example.test.com;  
  
  
import android.app.Activity;  
import android.os.Bundle;  
import android.util.Log;  
import android.view.Window;  
  
public class MainActivity extends Activity {  
  
    @Override  
    protected void onCreate(Bundle savedInstanceState) {  
        super.onCreate(savedInstanceState);  
          
        requestWindowFeature(Window.FEATURE_NO_TITLE);  
        setContentView(R.layout.main);  
          
        //状态 判断  
        if (savedInstanceState != null) {  
            Log.d("HELLO", "HELLO：应用进程被回收后，状态恢复");  
            String string = savedInstanceState.getString("username");  
            if (string != null) {  
                Log.d("HELLO", "HELLO:" + string);  
            }  
        }  
  
    }  
  
    /** 
     * 当某个activity变得“容易”被系统销毁时，该activity的onSaveInstanceState就会被执行， 
     * 除非该activity是被用户主动销毁的，例如当用户按BACK键的时候 
     * 一个原则：即当系统“未经你许可”时销毁了你的activity，则onSaveInstanceState会被系统调用 
     * 情景： 
     * 1. 当用户按下HOME键时 
     * 2. 长按HOME键，选择运行其他的程序时。 
     * 3. 按下电源按键（关闭屏幕显示）时。 
     * 4. 从activity A中启动一个新的activity时。 
     * 5. 屏幕方向切换时，例如从竖屏切换到横屏时。 
     * 以上情景触发该函数，并且开发者可以保存一些数据状态 
     */  
    @Override     
    public void onSaveInstanceState(Bundle savedInstanceState) {     
      Log.d("HELLO", "HELLO：当Activity被销毁的时候，不是用户主动按back销毁，例如按了home键");  
      super.onSaveInstanceState(savedInstanceState);    
      savedInstanceState.putString("username", "initphp"); //这里保存一个用户名  
    }     
    
    /** 
     * onSaveInstanceState方法和onRestoreInstanceState方法“不一定”是成对的被调用的， 
     * onRestoreInstanceState被调用的前提是， 
     * activity A“确实”被系统销毁了，而如果仅仅是停留在有这种可能性的情况下， 
     * 则该方法不会被调用，例如，当正在显示activity A的时候，用户按下HOME键回到主界面， 
     * 然后用户紧接着又返回到activity A，这种情况下activity A一般不会因为内存的原因被系统销毁， 
     * 故activity A的onRestoreInstanceState方法不会被执行 
     */  
    @Override     
    public void onRestoreInstanceState(Bundle savedInstanceState) {     
      super.onRestoreInstanceState(savedInstanceState);   
      Log.d("HELLO", "HELLO:如果应用进程被系统咔嚓，则再次打开应用的时候会进入");  
    }     
}  

我们的具体操作： 

首先打开这个app应用
其次，按home键，例如意外中止，则会调用onSaveInstanceState方法。可以看到以下日志：

这个时候，如果直接去打开这个应用，可能系统并没有回收这个进程所在的资源，并不能体现出状态恢复的实验，我们可以通过DDMS中，中止这个APP的进程：

中止进程后，再打开应用进入，看看是否有日志：

可以看到上面 initphp这个username也获取到了，说明恢复了状态。恭喜，实验成功。
关键点在于：是否进程被系统回收掉
