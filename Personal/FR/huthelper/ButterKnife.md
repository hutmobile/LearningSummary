ButterKnife的注册与绑定
===
在Activity中绑定ButterKnife：
---
**由于每次都要在Activity中的onCreat()绑定Activity（所以可以写一个BaseActivity完成绑定，子类继承即可）绑定Activity必须在setContentView之后,使用ButterKnife.bind(this)进行绑定**</Br>
代码如下：
```
public class MainActivity extends AppCompatActivity{
    @Override 
    protected void onCreate(Bundle savedInstanceState) { 
        super.onCreate(savedInstanceState); 
        setContentView(R.layout.activity_main);
        //绑定初始化
        ButterKnife ButterKnife.bind(this);
    }
} 

```
在Fragment中绑定ButterKnife：
---
Fragment的生命周期不同于activity。在onCreateView()中绑定一个Fragment时，在onDestroyView()中将视图设置为null。当调用bind来绑定一个Fragment时，ButterKnife会返回一个Unbinder的实例。
在适当的生命周期（onDestroyView()）回调中调用unbinde方法进行Fragment解绑。使用ButterKnife.bind(this,view)进行绑定。</Br>
代码如下：
```
public class ButterKinfeFragment extends Fragment{

    private Unbinder unbinder;
    
    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
  
        View view = inflater.inflate(setLayoutId(),container,false);
        //返回一个Unbinder值（进行解绑），注意这里的this不能使用getActivity()  
        unbinder = ButterKnife.bind(this,view);
        return view;
    }

    /**
     * onDestroyView()中进行解绑操作
     */
    @Override
    public void onDestroyView() {
        super.onDestroyView();
        unbinder.unbind();
    }
}
```
