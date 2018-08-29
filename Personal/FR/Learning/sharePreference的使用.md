SharedPreferences
===
SharedPreferences类，它是一个轻量级的存储类，特别适合用于保存软件配置参数
---
>SharedPreferences保存数据，其背后是用xml文件存放数据，文件存放在/data/data/包名/shared_prefs目录下，类似键值对的方式来存储数据。

简单使用
===
可保存的类型
---
>string, int, float, long, boolean
```
  //获取sharedPreferences对象
  SharedPreferences sharedPreferences = getSharedPreferences("文件名",Context.MODE_PRIVATE);
  //获取editor对象
  SharedPreferences.Editor editor = sharedPreferences.edit();//获取编辑器
   //存储键值对
        editor.putString("name", "小明");
        editor.putInt("age", 24);
        editor.putBoolean("isMarried", false);
        editor.putLong("height", 175L);
        editor.putFloat("weight", 60f);
        editor.putStringSet("where", set);
        //提交
        editor.commit();//提交修改
