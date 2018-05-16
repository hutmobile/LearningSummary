目前遇到到过的形式

view=inflater.inflate(int resource,ViewGroup root,false);

view=LayoutInflater.from(context).inflate(int resource.ViewGroup root,parent,false);

LayoutInflater.from(context)作用是从context中获得一个布局管理器

参数方法：

public View inflate (int resource, ViewGroup root, boolean attachToRoot)

第一个参数是指想要传入填充的布局,一般在layout文件下

第二个参数指的是第一个参数填充的视图将要放入到的根视图

如果该参数为null，此时在布局中定义的LayoutParams(位置，高度，宽度)属性会失效,此时系统会载入一个默认设置的ViewGroup,也就是此时载入的新视图的高度和宽度等会是默认值，同时第三个参数失去效果

第三个参数指是将传入的视图是否绑定到root视图下

如果为false，root视图将为resource视图提供LayoutParams参数的控件

如果为true，将指定root为载入的布局的父布局

public View inflate (int resource, ViewGroup root)

参数作用同上，不同的是该inflate的attachToRoot默认为true
