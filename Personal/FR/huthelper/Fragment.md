Fragment 切换判断界面是否可见 setUserVisibleHint使用场景
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

Fragment传递参数
===

LessonFragment
---
```
    public static LessonFragment newInstance(){
        //传递参数，当设备参数发生改变时确保传递的数据显示正确（如手机横竖屏切换）
        Bundle args = new Bundle();

        LessonFragment fragment = new LessonFragment();
        fragment.setArguments(args);
        return fragment;
    }

```

LessonActivity
---
```
    lessonFragment = LessonFragment.newInstance();
    getSupportFragmentManager().beginTransaction().replace(R.id.content,lessonFragment).commit();
```