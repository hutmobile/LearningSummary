fragment 切换判断界面是否可见 setUserVisibleHint使用场景
===
fragment生命周期依赖于宿主Activity</br>

setUserVisibleHint()
---
使用场景：当fragment结合viewpager使用的时候
```
    @Override
    public void setUserVisibleHint(boolean isVisibleToUser) {
        super.setUserVisibleHint(isVisibleToUser);
        if(getUserVisibleHint()){
            //界面可见
        }else{
           //界面不可见（相当于onpause）
        }
    }
```
