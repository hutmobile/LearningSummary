Looper
===
什么时候需要 Looper
---
　　Looper用于封装了android线程中的消息循环，默认情况下一个线程是不存在消息循环（message loop）的，需要调用Looper.prepare()来给线程创建一个消息循环，调用Looper.loop()来使消息循环起作用，使用Looper.prepare()和Looper.loop()创建了消息队列就可以让消息处理在该线程中完成。
  
使用Looper需要注意什么
---
　写在Looper.loop()之后的代码不会被立即执行，当调用后mHandler.getLooper().quit()后，loop才会中止，其后的代码才能得以运行。Looper对象通过MessageQueue来存放消息和事件。一个线程只能有一个Looper，对应一个MessageQueue。
 
 ```
 ...
         new Thread(new Runnable() {

            @Override
            public void run() {
            
                Looper.prepare();
                //代码1...
                Looper.loop();
                //代码2...
            }
        }).start();
...
```        
