注意：我的万能adapter中集成了下拉刷新、上拉加载更多、另增header的功能，需要与我后面将写到的万能下拉刷新、上拉加载更多的RecyclerView搭配使用，如果你不需要下拉刷新和上拉加载更多可以无视其中相关的代码。
首先，我们知道我们对adapter中控件获取都是通过ViewHolder来的，所以我们首先要自定义ViewHolder，来完成各个控件的获取和初始化。正常情况下，我们是这样用的：
class HistoryGoodsHolder extends RecyclerView.ViewHolder {
        ImageView img;
        TextView name, summary, amount, price;

        public HistoryGoodsHolder(View itemView) {
            super(itemView);
            img = (ImageView) itemView.findViewById(R.id.item_history_rcv_goodsImg);
            name = (TextView) itemView.findViewById(R.id.item_history_rcv_goodsName);
            summary = (TextView) itemView.findViewById(R.id.item_history_rcv_goodsSummary);
            amount = (TextView) itemView.findViewById(R.id.item_history_rcv_goodsAmount);
            price = (TextView) itemView.findViewById(R.id.item_history_rcv_goodsPrice);
        }
    }

现在我们需要实现的是万能的adapter，所以holder必须实现可定制化，而不是这种固定死的，每个RecyclerView的item布局不一样就重新写个holder，这样就没有意义了，所以我们写的万能Holder中不能存在真实的控件id，因为一旦id固定，那么肯定得重复写holder，毕竟id不一样，holder就不一样了，所以我们可以通过一种方式，那就是findById方法里面的id不写死，而是用参数的方式传进去，这样可以写一个通用的Holer，不同的recyclerview可以传不同的id进去就行了。ViewHolder最终形态：
public class XJJBaseRvHolder extends RecyclerView.ViewHolder {
    private SparseArray<View> mViews;  //view的集合
    private View mConvertView;  //item的布局
    private Context mContext;  //上下文

    public XJJBaseRvHolder(Context context, View itemView) {
        super(itemView);
        mContext = context;
        mConvertView = itemView;
        mViews = new SparseArray<View>();
    }

    //获取item的布局
    public View getItemView(){
        return mConvertView;
    }

    //初始化控件，通过传进去id来初始化，使用泛型实现传递任何类型
    public <T extends View> T getView(int viewId)
    {
        View view = mViews.get(viewId);
        if (view == null)
        {
            view = mConvertView.findViewById(viewId);
            mViews.put(viewId, view);
        }
        return (T) view;
    }

    //快捷设置TextView的文本
    public XJJBaseRvHolder setText(int viewId, String text)
    {
        TextView tv = getView(viewId);
        tv.setText(text);
        return this;
    }

    //快捷设置ImageView的图片
    public XJJBaseRvHolder setSrc(int viewId, int resId)
    {
        ImageView view = getView(viewId);
        view.setImageResource(resId);
        return this;
    }

    //设置控件的点击事件
    public XJJBaseRvHolder setOnClickListener(int viewId, View.OnClickListener listener)
    {
        View view = getView(viewId);
        view.setOnClickListener(listener);
        return this;
    }

    //设置item的点击事件
    public XJJBaseRvHolder setItemOnClickListener(View.OnClickListener listener){
        mConvertView.setOnClickListener(listener);
        return this;
    }


ViewHolder搞定，接下来是adapter，ViewHolder是在adapter里面被引用的，如果我们在adapter里面实例化holder后传入id来初始化控件，肯定不行，因为如果在adapter里面传入id，那么adapter使用了真实的id，那么id不一样adapter又得不一样，还得重复写了，所以我们不能在adapter里面传入id来初始化item的控件，那么怎么实现呢？用接口来实现，具体如下： 
先写接口把Holder传递出去，然后初始化adapter的时候实现改接口。
public interface ItemDataListener<T> {//接口
        void setItemData(XJJBaseRvHolder holder, T t);
    }

public void setItemDataListener(ItemDataListener listener) {
        itemDataListener = listener;
    }

然后我们数据填充的时候需要先初始化控件的，所以我在onBindViewHolder里面调用接口，让初始化和数据填充在外面执行。
@Override
    public void onBindViewHolder(final XJJBaseRvHolder holder, int position) {
        if (getItemViewType(position) == TYPE_HEADER || getItemViewType(position) == TYPE_PULL_TO_REFRESH_HEADER) {//如果是头部，不做数据填充
            return;
        } else if (getItemViewType(position) == TYPE_FOOTER) {
            return;
        } else {
            if (itemDataListener == null) {
                return;
            }
            itemDataListener.setItemData(holder, datas.get(getRealPosition(holder)));
        }
    }

实现接口并初始化控件填充数据：
adapter.setItemDataListener(new XJJBaseRvAdapter.ItemDataListener<Integer>() {
            @Override
            public void setItemData(final XJJBaseRvHolder holder, Integer integer) {
                TextView textView = holder.getView(R.id.item_index_tv);
                textView.setText(String.valueOf(integer));
            }
});

以上就是控件初始化和数据填充的思路流程，可能讲的不是很清楚？水平有限啊，从小语文就不好啊，看不懂的你们可以看鸿洋大神的，这部分思路是借鉴鸿洋大神的。 
接下来，就是设正常的header、下拉刷新头、上拉加载更多footer了。 
首先需要3个变量代表四种类型（上面三种+正常数据）。
public static final int TYPE_HEADER = 0;  //正常头部
public static final int TYPE_PULL_TO_REFRESH_HEADER = 1;  //下拉刷新头部
public static final int TYPE_NORMAL = 2;  //正常数据
public static final int TYPE_FOOTER = 3;  //上拉footer

然后添加的实现方法：
//添加下拉刷新头
public void addPullToRefreshHeaderView(View
addPullToRefreshHeaderView) {
        if (headerView != null) return;  //如果已经先添加了headerView，就不能增加下拉头了
        if (pullToRefreshHeaderView != null || addPullToRefreshHeaderView == null) {
            return;
        }
        this.pullToRefreshHeaderView = addPullToRefreshHeaderView;
        notifyItemInserted(0);
}

//添加头部布局（非下拉头），仅限一个
public void addHeaderView(View addHeaderView) {
        if (addHeaderView == null || headerView != null) {
            return;
        }
        this.headerView = addHeaderView;
        notifyItemInserted(pullToRefreshHeaderView == null ? 0 : 1);
}

//添加footeer
public void addLoadMoreFooterView(View addLoadMoreFooterView) {
        if (loadMoreFooterView != null || addLoadMoreFooterView == null) {
            return;
        }
        this.loadMoreFooterView = addLoadMoreFooterView;
        notifyItemInserted(getItemCount() - 1);
}

然后设置ViewType:
@Override
public int getItemViewType(int position) {
        if (loadMoreFooterView != null && position == getItemCount() - 1) {
            return TYPE_FOOTER;
        }
        if (pullToRefreshHeaderView == null && headerView == null) {
            return TYPE_NORMAL;
        }
        if (pullToRefreshHeaderView == null && headerView != null) {
            if (position == 0) {
                return TYPE_HEADER;
            }
        }
        if (pullToRefreshHeaderView != null && headerView == null) {
            if (position == 0) {
                return TYPE_PULL_TO_REFRESH_HEADER;
            }
        }
        if (pullToRefreshHeaderView != null && headerView != null) {
            if (position == 0) return TYPE_PULL_TO_REFRESH_HEADER;
            if (position == 1) return TYPE_HEADER;
        }
        return TYPE_NORMAL;
}

接下来需要获取真实的position，因为正常情况下RecyclerView中position为0的item跟我们数据data（一般是List类型）的data.get(0)对应，但是由于添加了header所以header的position才是0，数据对应不上，所以我们得修改下position获取方式：
//获取真实的position（与datalist对应，因为添加了头部，会使得position和data对应不上）
public int getRealPosition(RecyclerView.ViewHolder holder) {
        int position = holder.getLayoutPosition();
        if (pullToRefreshHeaderView == null) {
            return headerView == null ? position : position - 1;
        } else {
            return headerView == null ? position - 1 : position - 2;
        }
}

然后呢，我们还要修改getItemCount，因为添加了header和footer，所以Item数量变了：
@Override
public int getItemCount() {
        if (pullToRefreshHeaderView == null) {
            if (headerView == null) {
                return loadMoreFooterView == null ? datas.size() : datas.size() + 1;
            } else {
                return loadMoreFooterView == null ? datas.size() + 1 : datas.size() + 2;
            }
        } else {
            if (headerView == null) {
                return loadMoreFooterView == null ? datas.size() + 1 : datas.size() + 2;
            } else {
                return loadMoreFooterView == null ? datas.size() + 2 : datas.size() + 3;
            }
        }
}

其次是onCreateViewHolder，也要根据不同类型生成不同的holder：
@Override
public XJJBaseRvHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        if (pullToRefreshHeaderView != null && viewType == TYPE_PULL_TO_REFRESH_HEADER) {//如果是下拉头
            DisplayMetrics dm = new DisplayMetrics();
            WindowManager wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
            wm.getDefaultDisplay().getMetrics(dm);
            LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(dm.widthPixels, ViewGroup.LayoutParams.WRAP_CONTENT);
            pullToRefreshHeaderView.setLayoutParams(layoutParams);
            return new XJJBaseRvHolder(context, pullToRefreshHeaderView);
        }
        if (headerView != null && viewType == TYPE_HEADER) {//如果是正常头
            DisplayMetrics dm = new DisplayMetrics();
            WindowManager wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
            wm.getDefaultDisplay().getMetrics(dm);
            LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(dm.widthPixels, ViewGroup.LayoutParams.WRAP_CONTENT);
            headerView.setLayoutParams(layoutParams);
            return new XJJBaseRvHolder(context, headerView);
        }
        if (loadMoreFooterView != null && viewType == TYPE_FOOTER) {
            DisplayMetrics dm = new DisplayMetrics();
            WindowManager wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
            wm.getDefaultDisplay().getMetrics(dm);
            LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(dm.widthPixels, ViewGroup.LayoutParams.WRAP_CONTENT);
            loadMoreFooterView.setLayoutParams(layoutParams);
            return new XJJBaseRvHolder(context, loadMoreFooterView);
        }
        View view = LayoutInflater.from(context).inflate(layoutId, parent, false);
        XJJBaseRvHolder holder = new XJJBaseRvHolder(context, view);
        return holder;
}

可能有的朋友看不明白，其实还是很简单的，多看两遍就明白了，我把总的贴出来吧。adapter最终形态：
public class XJJBaseRvAdapter<T> extends RecyclerView.Adapter<XJJBaseRvHolder> {

    protected Context context;
    protected ItemDataListener itemDataListener;
    private View pullToRefreshHeaderView, headerView, loadMoreFooterView;

    protected int layoutId;
    protected List<T> datas;
    public static final int TYPE_HEADER = 0;  //正常头部
    public static final int TYPE_PULL_TO_REFRESH_HEADER = 1;  //下拉刷新头部
    public static final int TYPE_NORMAL = 2;  //正常数据
    public static final int TYPE_FOOTER = 3;  //上拉footer

    public XJJBaseRvAdapter(Context context, int layoutId, List<T> datas) {
        this.context = context;
        this.layoutId = layoutId;
        this.datas = datas;
    }

    public void setDatas(List<T> datas) {
        this.datas = datas;
        notifyDataSetChanged();
    }

    //添加下拉刷新头
    public void addPullToRefreshHeaderView(View addPullToRefreshHeaderView) {
        if (headerView != null) return;  //如果已经先添加了headerView，就不能增加下拉头了
        if (pullToRefreshHeaderView != null || addPullToRefreshHeaderView == null) {
            return;
        }
        this.pullToRefreshHeaderView = addPullToRefreshHeaderView;
        notifyItemInserted(0);
    }

    //添加头部布局（非下拉头），仅限一个
    public void addHeaderView(View addHeaderView) {
        if (addHeaderView == null || headerView != null) {
            return;
        }
        this.headerView = addHeaderView;
        notifyItemInserted(pullToRefreshHeaderView == null ? 0 : 1);
    }

    //添加footeer
    public void addLoadMoreFooterView(View addLoadMoreFooterView) {
        if (loadMoreFooterView != null || addLoadMoreFooterView == null) {
            return;
        }
        this.loadMoreFooterView = addLoadMoreFooterView;
        notifyItemInserted(getItemCount() - 1);
    }

    public View getPullToRefreshHeaderView(){
        return pullToRefreshHeaderView;
    }

    public View getLoadMoreFooterView(){
        return loadMoreFooterView;
    }

    @Override
    public int getItemViewType(int position) {
        if (loadMoreFooterView != null && position == getItemCount() - 1) {
            return TYPE_FOOTER;
        }
        if (pullToRefreshHeaderView == null && headerView == null) {
            return TYPE_NORMAL;
        }
        if (pullToRefreshHeaderView == null && headerView != null) {
            if (position == 0) {
                return TYPE_HEADER;
            }
        }
        if (pullToRefreshHeaderView != null && headerView == null) {
            if (position == 0) {
                return TYPE_PULL_TO_REFRESH_HEADER;
            }
        }
        if (pullToRefreshHeaderView != null && headerView != null) {
            if (position == 0) return TYPE_PULL_TO_REFRESH_HEADER;
            if (position == 1) return TYPE_HEADER;
        }
        return TYPE_NORMAL;
    }

    //获取真实的position（与datalist对应，因为添加了头部，会使得position和data对应不上）
    public int getRealPosition(RecyclerView.ViewHolder holder) {
        int position = holder.getLayoutPosition();
        if (pullToRefreshHeaderView == null) {
            return headerView == null ? position : position - 1;
        } else {
            return headerView == null ? position - 1 : position - 2;
        }
    }

    public void setItemDataListener(ItemDataListener listener) {
        itemDataListener = listener;
    }

    @Override
    public XJJBaseRvHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        if (pullToRefreshHeaderView != null && viewType == TYPE_PULL_TO_REFRESH_HEADER) {//如果是下拉头
            DisplayMetrics dm = new DisplayMetrics();
            WindowManager wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
            wm.getDefaultDisplay().getMetrics(dm);
            LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(dm.widthPixels, ViewGroup.LayoutParams.WRAP_CONTENT);
            pullToRefreshHeaderView.setLayoutParams(layoutParams);
            return new XJJBaseRvHolder(context, pullToRefreshHeaderView);
        }
        if (headerView != null && viewType == TYPE_HEADER) {//如果是正常头
            DisplayMetrics dm = new DisplayMetrics();
            WindowManager wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
            wm.getDefaultDisplay().getMetrics(dm);
            LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(dm.widthPixels, ViewGroup.LayoutParams.WRAP_CONTENT);
            headerView.setLayoutParams(layoutParams);
            return new XJJBaseRvHolder(context, headerView);
        }
        if (loadMoreFooterView != null && viewType == TYPE_FOOTER) {
            DisplayMetrics dm = new DisplayMetrics();
            WindowManager wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
            wm.getDefaultDisplay().getMetrics(dm);
            LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(dm.widthPixels, ViewGroup.LayoutParams.WRAP_CONTENT);
            loadMoreFooterView.setLayoutParams(layoutParams);
            return new XJJBaseRvHolder(context, loadMoreFooterView);
        }
        View view = LayoutInflater.from(context).inflate(layoutId, parent, false);
        XJJBaseRvHolder holder = new XJJBaseRvHolder(context, view);
        return holder;
    }

    @Override
    public void onBindViewHolder(final XJJBaseRvHolder holder, int position) {
        if (getItemViewType(position) == TYPE_HEADER || getItemViewType(position) == TYPE_PULL_TO_REFRESH_HEADER) {//如果是头部，不做数据填充
            return;
        } else if (getItemViewType(position) == TYPE_FOOTER) {
            return;
        } else {
            if (itemDataListener == null) {
                return;
            }
            itemDataListener.setItemData(holder, datas.get(getRealPosition(holder)));
        }
    }

    @Override
    public int getItemCount() {
        if (pullToRefreshHeaderView == null) {
            if (headerView == null) {
                return loadMoreFooterView == null ? datas.size() : datas.size() + 1;
            } else {
                return loadMoreFooterView == null ? datas.size() + 1 : datas.size() + 2;
            }
        } else {
            if (headerView == null) {
                return loadMoreFooterView == null ? datas.size() + 1 : datas.size() + 2;
            } else {
                return loadMoreFooterView == null ? datas.size() + 2 : datas.size() + 3;
            }
        }
    }

    public interface ItemDataListener<T> {
        void setItemData(XJJBaseRvHolder holder, T t);
    }

}

用法：
XJJBaseRvAdapter adapter = new XJJBaseRvAdapter(this, R.layout.item_rcv, mdatas);//传入item布局
adapter.setItemDataListener(new XJJBaseRvAdapter.ItemDataListener<Integer>() {
            @Override
            public void setItemData(final XJJBaseRvHolder holder, Integer integer) {
                TextView textView = holder.getView(R.id.item_index_tv);//初始化控件
                textView.setText(String.valueOf(integer));
            }
        });

很简单的，初始化adapter时传入item的布局即可，然后实现接口在里面做数据处理即可。
如果大家有不懂的可以留言或者看鸿洋大神的相关博客，他那里比较详细，我这里需要是为了给后面的文章（万能的下拉刷新、上拉加载更多）做个铺垫，因为后面的跟这个万能adapter配合用的，以后用起来都方便。有不当之处还望见谅。
版权声明：本文为博主原创文章，未经博主允许不得转载。 https://blog.csdn.net/gsw333/article/details/75635604 
文章标签： android adapter recyclerview 万能适配 
