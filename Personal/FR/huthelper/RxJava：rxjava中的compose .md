1.实现一系列操作符的复用</Br>
2.不破化链式调用的结构

应用场景
---
rxlifecycle绑定生命周期的时候就是使用compose方法来复用一些处理逻辑

```
    public void login(final String username, String passsword) {

        APIUtils
                .getLoginAPI()
                .login(username, passsword)
                .compose(getActivity().<HttpResult<User>>bindToLifecycle())
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe()

    }
```
