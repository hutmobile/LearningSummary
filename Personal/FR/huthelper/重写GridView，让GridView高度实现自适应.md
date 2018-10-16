# 重写GridView的测量方法
```
public class MyGridView extends GridView {

    public MyGridView(Context context) {
        super(context);
    }

    public MyGridView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public MyGridView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        int heightSpec = MeasureSpec.makeMeasureSpec(Integer.MAX_VALUE >> 2,MeasureSpec.AT_MOST);
        super.onMeasure(widthMeasureSpec, heightMeasureSpec);
    }
}
```
## MeauseSpec
### MeasureSpec的构成
MeasureSpec代表一个32位的int值，前两位代表specMode，后30位代表SpaceSize，其中SpaceMode代表测量的模式，specSize值在是在测量模式下的规格大小</Br>

三种测量模式：</Br>
1. EXACTLY: 父容器已经检测出子View所需要的精确大小，这个时候view的大小即为SpecSize的大小，他对应于布局参数中的MATCH_PARENT,或者精确大小值</Br>
<<<<<<< HEAD

2. AT_MOST: 父容器指定了一个大小，即SpecSize，子view的大小不能超过这个SpecSize的大小</Br>

=======
2. AT_MOST: 父容器指定了一个大小，即SpecSize，子view的大小不能超过这个SpecSize的大小</Br>
>>>>>>> fbd029d06c6d3d375c3511cd9178a32ff1ebad42
3. UNSPECIFIED: 表示子View想多大都可以</Br>

