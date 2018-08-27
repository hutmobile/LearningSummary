Gson中TypeToken如何实现获取参数类型
===
在使用GSON解析一段JSON数组时，需要借助TypeToken将期望解析成的数据类型传入到fromJson()方法中，如下：
```
List<Person> people = gson.fromJson(jsonData, new TypeToken<List<Person>>(){}.getType());
```
假设一段JSON格式的数据如下：
```
   [{"name":"Tom","age":"10"},
    {"name":"Lucy","age":"11"},
    {"name":"Lily","age":"11"}]
```
new TypeToken<List<Person>>(){}.getType()是怎么获取到泛型参数类型的呢？</Br>

首先，new TypeToken<List<Person>>(){}是一个匿名内部类，其等价MyTypeToken<List<Person>> extends TypeToken(){}，但是{}里是空的，既然什么都没有改变，为什么还要这么用呢？下面看源码
```
public class TypeToken<T> {
    final Class<? super T> rawType;
    final Type type;
    final int hashCode;

//这里的空参构造方法权限修饰符是protected,那木只有其子类可访问，预示着要使用子类构造。
    protected TypeToken() {
        this.type = getSuperclassTypeParameter(this.getClass());//这里传入的子类，后面2行不用看
        this.rawType = Types.getRawType(this.type);
        this.hashCode = this.type.hashCode();
    }

   ...

    static Type getSuperclassTypeParameter(Class<?> subclass) {
        Type superclass = subclass.getGenericSuperclass();//获取到子类的父类Type
        if(superclass instanceof Class) {
            throw new RuntimeException("Missing type parameter.");
        } else {
            ParameterizedType parameterized = (ParameterizedType)superclass;//将Type类型向下转型为参数化类型ParameterizedType
            return Types.canonicalize(parameterized.getActualTypeArguments()[0]);//这里getActualTypeArguments()返回的是一个数组，由于只有一个泛型参数,直接[0]。
        }
    }
```
