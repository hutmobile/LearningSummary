android种fitsSystemWindows的用处
===
在android的XML中设置fitsSystemWindows：</Br>
fitsSystemWindows只作用在sdk>=19的系统上（4.4）
```
android : fitsSystemWindows = "true"
```
这个属性可以给任何view设置，,只要设置了这个属性此view的所有padding属性失效，只有在设置了透明状态栏(StatusBar)或者导航栏(NavigationBar)此属性才会生效。