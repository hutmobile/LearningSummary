> 1.Context类 抽象类，提供了一组通用的API

```
  public abstract class Context {
  > //获取系统级服务
    public abstract Object getSystemService(String name);   
  > //通过一个Intent启动Activity
    public abstract void startActivity(Intent intent);
  > //启动Service
    public abstract ComponentName startService(Intent service);
  > //根据文件名得到SharePreferences对象
    public abstract SharePreferences getSharedPreferances(String name,int mode);
    ...
  }
```
> 2.Activity类 、Service类 、Application类本质上都是Context子类

