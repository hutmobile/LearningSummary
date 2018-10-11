三个参数的inflate方法
===
```
public View inflate(@LayoutRes int resource, @Nullable ViewGroup root, boolean attachToRoot)
```
1.当root不为null，attachToRoot为true时
---
表示resource指定的布局添加到root中，添加的过程中resourse所指的布局的根节点的各个属性都是有效的</Br>

2.root不为null，attachToRoot为false时
---
如果root不为null，而attachToRoot为false的话，表示不将第一个参数所指定的View添加到root中</Br>
(这个时候我需要手动的将inflate加载进来的view添加到ll容器中，因为inflate的最后一个参数false表示不将linealayout添加到ll中)
```
子布局.addView(父布局)
```
