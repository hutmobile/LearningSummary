 ```
 @SerializedName(value = "user_id",alternate = {"id"})
 private String user_id;
 ```   
 这时候 id 可以被当作 user_id 或 id 了，具体是谁取决于遇到谁

 然后就是解析了，fromJson里第一个是需要解析的json文本，String格式，后面是实体类，这样之后json里的字段就和实体类里面的变量和其他类一一对应了
 ```
Gson gson = new Gson();

CityRoot cityRoot = gson.fromJson(resultCity, CityRoot.class);
```
