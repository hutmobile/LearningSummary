```
java.lang.Object
  java.lang.ref.Reference<T>
直接已知子类： 
PhantomReference, SoftReference, WeakReference 
```
引用对象的抽象基类。此类定义了常用于所有引用对象的操作。因为引用对象是通过与垃圾回收器的密切合作来实现的，所以不能直接为此类创建子类。 </br>

| 方法摘要 |  |  |
| ------ | ------ | ------ |
| void | clear() | 清除此引用对象 |
| boolean | enqueue() | 将此引用对象添加到引用对象已向其注册的队列（如果有)|
| T | get() | 返回此引用对象的指示对象 |
| boolean | isEnqueued() | 由程序或垃圾回收器通知是否已将此引用对象加入队列 |

```
get
  public T get()
    返回此引用对象的指示对象。如果此引用对象已经由程序或垃圾回收器清除，则此方法将返回 null。 

    返回：
      此引用所引用的对象；如果此引用对象已经清除，则返回 null。
```

```
clear
  public void clear()
    清除此引用对象。调用此方法不会导致对象被加入队列。 
    只有 Java 代码才调用此方法；当垃圾回收器清除引用时，可以直接进行操作，无需调用此方法。 
```

```
isEnqueued
  public boolean isEnqueued()
    由程序或垃圾回收器通知是否已将此引用对象加入队列。如果创建此引用对象时没有在队列中注册它，则该方法将总是返回 false。 

    返回：
      当且仅当此引用对象已经加入队列时返回 true
```

```
enqueue
  public boolean enqueue()
    将此引用对象添加到引用对象已向其注册的队列（如果有）。
    只有 Java 代码才调用此方法；当垃圾回收器将引用加入队列时，可以直接进行操作，无需调用此方法。 


    返回：如果成功将此引用对象加入队列中，则返回 true；如果它已经加入队列或者在创建时没有在队列中注册它，则返回 false。
```
