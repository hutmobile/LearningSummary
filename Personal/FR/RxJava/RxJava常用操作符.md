创建
===
unsafeCreate()
---
创建一个Observable（被观察者），当被观察者（Observer）/订阅者（Subscriber）</Br>
subscribe(订阅)的时候就会依次发出三条字符串数据（"Hello","RxJava","Nice to meet you"）</Br>
最终onComplete</Br>
```
  Observable.unsafeCreate(new Observable.OnSubscribe<String>() { 
              @Override 
              public void call(Subscriber<? super String> subscriber) { 
                  subscriber.onNext("Hello"); 
                  subscriber.onNext("RxJava");
                  subscriber.onNext("Nice to meet you"); 
                  subscriber.onCompleted(); 
              }
          });

```

just
---
作用同上，订阅时依次发出三条数据，不过此方法参数可以有1-9条
```
Observable.just("Hello", "RxJava", "Nice to meet you")
```

from
---
作用同just不过是把参数封装成数组或者可迭代的集合在依次发送出来，突破了just9个参数的限制
```
 String[] strings = {"Hello", "RxJava", "Nice to meet you"};
 Observable.from(strings) 
        .subscribe(new Action1<String>() {
            @Override 
            public void call(String s) {
                System.out.println("onNext--> " + s); 
            } 
          }, new Action1<Throwable>() {
              @Override 
              public void call(Throwable throwable) {
                  System.out.println("onError--> " + throwable.getMessage());
              } 
          }, new Action0() { 
              @Override
              public void call() { 
                  System.out.println("onComplete");
              } 
          });

```

defer
---
延迟创建
```
   private String[] strings1 = {"Hello", "World"};
   private String[] strings2 = {"Hello", "RxJava"};
   
   private void test() {
        Observable<String> observable = Observable.defer(new Func0<Observable<String>>() {
            @Override
            public Observable<String> call() {
                return Observable.from(strings1);
            }
        });
        strings1 = strings2; //订阅前把strings给改了 
        observable.subscribe(new Action1<String>() {
            @Override
            public void call(String s) {
                System.out.println("onNext--> " + s);
            }
        }, new Action1<Throwable>() {
            @Override
            public void call(Throwable throwable) {
                System.out.println("onError--> " + throwable.getMessage());
            }
        }, new Action0() {
            @Override
            public void call() {
                System.out.println("onComplete");
            }
        });
    }
```
我们发现数据结果变成这样了
```
onNext--> Hello
onNext--> RxJava
onComplete
```
由此可以证明defer操作符起到的不过是一个“预创建”的作用，真正创建是发生在订阅的时候
