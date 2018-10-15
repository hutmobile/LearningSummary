# 导致内存泄漏的例子：
```
A a = new A();
B b = new B(a);
a = null;
```
A对象的引用a置空时，a不再指向对象A的地址（当一个对象不再被其他对象引用的时候，会被GC回收）然而此时当a = null，A对象也不可能被回收，因为B依然依赖A，这时会造成内存泄漏。
## 使用WeakReference解决
```
public class B
{
    WeakReference<A> weak;
    public B(A a){
        WeakReference<A> weak = new WeakReference<A>(a);
    }
    public A getA(){
        return weak.get();
    }
}
A a = new A();
B b = new B(a);
a = null;
b.getA();  //返回null
```

