一.Android无UIFragment用法：findFragmentByTag
===
  当Fragment没有UI的时候如何在Activity中找到它，可以通过findFragmentByTag的方法
  
二.Fragment的生命周期
===
1.Fragment完整生命周期依次是： onAttach()、onCreate()、onCreateView()、onActivityCreated()、onStart()、onResume()、 
                             onPause()、onStop()、onDestroyView()、onDestroy()、onDetach() </Br>
                             
2.几个主要的方法： </Br>
                  onAttach():当碎片和活动建立关联的时候调用。 </Br>
                  onCreate():当碎片被建立的时候调用。 </Br>
                  onCreateView():为碎片创建视图（加载布局）时调用。 </Br>
                  onActivityCreated():确保与碎片相关联的活动一定已经创建完毕的时候调用。 </Br>
                  onDestroyView():当碎片管理的视图被移除的时候调用。 </Br>
                  onDetach():当碎片和活动解除关联的时候调用。</Br>
                  
3.创建时： onAttach()、onCreate()、onCreateView()、onActivityCreated()、onStart()、onResume()。</Br>

4.销毁时（没有用到返回栈）： onPause()、onStop()、onDestroyView()、onDestroy()、onDetach()。</Br>

5.重新返回到上一个Fragment（没有用到返回栈）： onAttach()、onCreate()、onCreateView()、onActivityCreated()、onStart()、onResume()。</Br>

6.当用到返回栈时  
```
    \\将Fragment增加到返回栈中：
    FragmentManager fm = getSupportFragment();
    FragmentTransaction ft = fm.beginTransaction();
    ft.replace(ID, 实例);
    ft.addToBackStack(null);//参数是描述返回栈的状态，一般为null。
    ft.commit();
```
销毁时（用到返回栈）： onPause()、onStop()、onDestroyView()。 </Br>
重新返回到上一个Fragment（用到返回栈）： onCreateView()、onActivityCreated()、onStart()、onResume()。</Br>

三.FragmentTransaction的主要方法
===
注意：我们操作的fragment会被增加到一个队列中，然后根据顺序显示该队列中已 经创建视图的fragmet（调用了onCreateView(……)）</Br>
入队的标准是：该fragment的onCreateView（……）被调用。 </Br>
出队的标准是：该fragment的onDetach（）被调用。
---
1.add(id, fragment) —— 增加framgent到队列中，并显示该fragment到指定布局中。 </Br>
生命周期调用： </Br>
当fragment与activity连接并被建立时（onAttach()、onCreate()被调用过） </Br>
onCreateView()、onActivityCreated()、onStart()、onResume()。 </Br>
当fragment与activity未连接并未被建立时（onAttach()、onCreate()未被调用过） </Br>
onAttach()、onCreate()、onCreateView()、onActivityCreated()、onStart()、onResume()。 </Br>
注意：同一个Fragmen不能增加到队列两次或多次。</Br>

2.show(fragment) —— 显示队列中的指定framgent。 </Br>
生命周期的调用： </Br>
当队列中不存在该fragment时，回调onAttach()、onCreate()。 </Br>
当队列中存在该fragment时并被调用过hide(fragment)时，回调onHiddenChange(boolean)。 </Br>
其他情况没有回调函数。</Br>

3.replace(id, fragment) —— 先检查队列中是否已经存在，存在就会崩溃，不存在就会进入队列并把其他fragment清出队列，最后显示该fragment到指定布局中。</Br> 
生命周期的调用：同add(id, fragment)。

4.remove(fragment) —— 销毁队列中指定的fragment。 </Br>
生命周期调用： </Br>
当队列中不存在该fragment时，不会有任何反应。 </Br>
当队列中存在该fragment时，fragment的生命周期执行情况主要依赖是否当前fragment进入到返回栈。</Br>

5.hide(fragment) —— 隐藏队列中指定的fragment，相当于调用视图的.setVisibility(View.GONE) </Br>
生命周期的调用： </Br>
当队列中存在该fragment时，回调onHiddenChange(boolen) </Br>
当队列中不存在该fragment时，回调onAttach()、onCreate()、onHiddenChange(boolen)。</Br>

6.detach(fragment) —— 销毁指定frament的视图，并且该fragment的onCreateVieew(……)不能再被调用（除非调用attach(fragment)重新连接）</Br> 
生命周期的调用： </Br>
当队列中存在该fragment时，回调onDestroyView() </Br>
当队列中不存在该fragment时，回调onAttach()、onCreate()。</Br>

7.attach(fragment) —— 创建指定fragment的视图。标识该fragment的onCreateView(……)能被调用。 </Br>
生命周期的调用： </Br>
当队列中存在该fragment时且被调用detach(fragment)时，回调createView()、onActivityCreated()、onResume()。 </Br>
当队列中不存在该fragment时，回调onAttach()、onCreate()。 </Br>
其他情况没有用。</Br>

8.addToBackStack(string) —— 使本次事务增加的fragment进入当前activity的返回栈中。当前参数是对返回栈的描述，没什么实际用途。传入null即可。</Br>

9.commit() —— 提交本次事务，可在非主线程中被调用。主要用于多线程处理情况。</Br>

10.commitNow() —— 提交本次事务，只在主线程中被调用。 这时候addToBackStack(string)不可用。</Br>

四.Android Fragment动态添加 FragmentTransaction FragmentManager 
===
1.获取FragmentManage的方式：
---
```
    getFragmentManager()
    //v4中FragmentActivity
    fm = getSupportFragmentManager()
```
2.主要的操作都是FragmentTransaction的方法
---
```
    FragmentTransaction ft = fm.benginTransatcion();//开启一个事务
　  ft.add() //往Activity中添加一个Fragment
　　ft.remove() //从Activity中移除一个Fragment，如果被移除的Fragment没有添加到回退栈（回退栈后面会详细说），这个Fragment实例将会被销毁。
　　ft.replace()//使用另一个Fragment替换当前的，实际上就是remove()然后add()的合体~
　　ft.hide() //当你的fragment数量固定很少时隐藏当前的Fragment，仅仅是设为不可见，并不会销毁，多的时候可能出现OOM异常,
　　ft.show()//显示之前隐藏的Fragment
　　detach()会将view从UI中移除,和remove()不同,此时fragment的状态依然由FragmentManager维护。
　　attach()重建view视图，附加到UI上并显示。
　　transatcion.commit()//提交一个事务
```  

