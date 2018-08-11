1.百度地图中registerLocationListener 过时
===
>解决方法：
 将原代码中
```
  public class MyLocationListener implements BDLocationListener
```
  >改为
```  
  public class MyLocationListener extends BDAbstractLocationListener
```
  
