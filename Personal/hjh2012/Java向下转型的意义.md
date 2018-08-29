2018.05.30
一开始学习 Java 时不重视向下转型。一直搞不清楚向下转型的意义和用途，不清楚其实就是不会，那开发的过程肯定也想不到用向下转型。
其实向上转型和向下转型都是很重要的，可能我们平时见向上转型多一点，向上转型也比较好理解。 
但是向下转型，会不会觉得很傻，我是要用子类实例对象，先是生成子类实例赋值给父类引用，在将父类引用向下强转给子类引用，这不是多此一举吗？我不向上转型也不向下转型，直接用子类实例就行了。 
我开始学习Java时也是这么想的，这误区导致我觉得向下转型就是没用的。 
随着技术的提升，我在看开源的项目学习，发现很多地方都用了向下转型的技术，这就让我重视了起来，想要重新来复习（学习）这个知识点。也是搜索了许多博客文章，但都没具体说明向下转型，只是给了例子演示怎么使用，反而是向上转型讲了一堆（可能是我没找到）。
这篇博客就是讲向下转型的，那我们就来学习下向下转型，了解下这种特性的意义和使用场景
新建一个电子产品接口，如下：
public interface Electronics{

}

很简单，什么方法都没有。
新建一个Thinkpad笔记本类，并实现电子产品接口：
public class Thinkpad implements Electronics{

    //Thinkpad引导方法
    public void boot(){
        System.out.println("welcome,I am Thinkpad");        
    }

    //使用Thinkpad编程  
    public void program(){
        System.out.println("using Thinkpad program");
    }

}

新建一个Mouse鼠标类，并实现电子产品接口：
public class Mouse implements Electronics{

    //鼠标移动
    public void move(){
        System.out.println("move the mouse");       
    }

    //鼠标点击  
    public void onClick(){
        System.out.println("a click of the mouse");
    }

}

新建一个Keyboard键盘类，并实现电子产品接口：
public class Keyboard implements Electronics{

    //使用键盘输入    
    public void input(){
        System.out.println("using Keyboard input");
    }

}

这里子类比较多，是为了更好的理解。每个类的方法的逻辑实现也很简单。打印了一行信息
接下来，我们想象一个情景：我们去商城买电子产品，电子产品很多吧，比如笔记本电脑，鼠标，键盘，步步高点读机哪里不会点哪里，我们用的手机，等等，这些都属于电子产品。电子产品是抽象的。好，那么我们决定买一台Thinkpad，一个鼠标和一个键盘。 
这时，我们需要一个购物车来装这些电子产品吧。我们可以添加进购物车，然后通过购物车还能知道存放的电子产品数量，能拿到对应的电子产品。 
那么，一个购物车类就出来了，如下：
import java.util.ArrayList;
import java.util.List;

public class ShopCar{

    private List<Electronics> mlist = new ArrayList<Electronics>();

    public void add(Electronics electronics){

        mlist.add(electronics);

    }

    public int getSize(){

        return mlist.size();
    }


    public Electronics getListItem(int position){

        return mlist.get(position);

    }


}

List 集合是用来存放电子产品的，add 方法用来添加电子产品到购物车，getSize 方法用来获取存放的电子产品数量，getListItem 方法用来获取相应的电子产品。
可以看到 List<Electronics> 用了泛型的知识，至于为什么要用泛型？这个不做介绍了，泛型很重要的。 
而我觉得比较疑惑的是为什么是放 Electronics 的泛型，而不是放Thinkpad，Mouse，Keyboard，Phone等？ 
那么如果是List<Thinkpad>，肯定是放不进鼠标Mouse的吧，难道要生成3个集合？这里是定义了3个电子产品类，但是我如果有100种电子产品呢，要定义100个集合? 
这太可怕了。所以之前，我们写了一个Electronics接口，提供了一个Electronics的标准，然后让每一个Electronics子类都去实现这个接口。
实际上这里又涉及到了向上转型的知识点，我们虽然在add 方法将子类实例传了进来存放，但子类实例在传进去的过程中也进行了向上转型 
所以，此时购物车里存放的子类实例对象，由于向上转型成Electronics，已经丢失了子类独有的方法，以上述例子来分析，Thinkpad实例就是丢失了boot() 和program() 这两个方法，而Mouse实例就是丢失了move()和onClick()这两个方法
但是实际使用Thinkpad或Mouse或Keyboard时，这种情况肯定不是我们想要的
接着我们写一个测试类 Test 去测试购物车里的电子产品。
测试类 Test 如下：
public class Test{

    public static final int THINKPAD = 0;
    public static final int MOUSE = 1;
    public static final int KEYBOARD = 2;

    public static void main(String[] args){

        //添加进购物车
        ShopCar shopcar = new ShopCar();
        shopcar.add(new Thinkpad());
        shopcar.add(new Mouse());
        shopcar.add(new Keyboard());

        //获取大小
        System.out.println("购物车存放的电子产品数量为 ——> "+shopcar.getSize());


        //开始测试thinkpad电脑
        Thinkpad thinkpad = (Thinkpad)shopcar.getListItem(THINKPAD);
        thinkpad.boot();
        thinkpad.program();

        System.out.println("-------------------");

        //开始测试Mouse鼠标
        Mouse mouse = (Mouse)shopcar.getListItem(MOUSE);
        mouse.move();
        mouse.onClick();

        System.out.println("-------------------");

        //开始测试Keyboard键盘
        Keyboard keyboard = (Keyboard)shopcar.getListItem(KEYBOARD);
        keyboard.input();
    }

}

运行截图： 

 
举个例子分析就好

//开始测试thinkpad电脑
Thinkpad thinkpad = (Thinkpad)shopcar.getListItem(THINKPAD);
thinkpad.boot();
thinkpad.program();

shopcar.getListItem(THINKPAD)这句代码是获取到Electronics类型的实例。不是Thinkpad的实例
通过向下转型，赋值给子类引用
Thinkpad thinkpad = (Thinkpad)shopcar.getListItem(THINKPAD);

这样子类实例又重新获得了因为向上转型而丢失的方法（boot 和program）
总结一下吧，很多时候，我们需要把很多种类的实例对象，全部扔到一个集合。（这句话很重要） 
在这个例子里就是把Thinkpad笔记本，Mouse鼠标，KeyBoard键盘等实例对象，全部扔到一个Shopcar购物车集合。 
但是肯定不可能给他们每个种类都用一个独立的集合去存放吧，这个时候我们应该寻找到一个标准，接口就是一个标准。这些都是各种电子产品，抽象成电子产品。然后一个Electronics接口就出来了。 
在回到刚才，我们把很多种类的实例对象全部扔到一个集合。或许这样比较好理解：把很多种类的子类实例对象全部扔到存放父类实例的集合。 
经过了这个过程，子类实例已经赋值给了父类引用（即完成了向上转型），但很遗憾的丢失了子类扩展的方法。 
很好的是Java语言有个向下转型的特性，让我们可以重新获得丢失的方法，即强转回子类 
所以我们需要用到子类实例的时候，就从那个父类集合里拿出来向下转型就可以了，一样可以使用子类实例对象
……
我在搜索java向下转型的意义时，得到一个比较好的答案是这样的： 
最大的用处是java的泛型编程，用处很大，Java的集合类都是这样的。
而在Android开发中，我们在Layout文件夹，用xml写的控件。为什么能在Activity等组件中通过 findViewById() 方法找到呢？为什么 findViewById(R.id.textview) 方法传入TextView的id后，还要转型为TextView呢？这就是 Java 向下转型的一个应用
