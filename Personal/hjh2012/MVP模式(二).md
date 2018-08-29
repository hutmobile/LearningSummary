2018.08.14

https://blog.csdn.net/dfskhgalshgkajghljgh/article/details/51317956

本篇博文通过对google官方demo：https://github.com/googlesamples/android-architecture/tree/todo-mvp/的理解，用自己的demo更好的讲解mvp的概念，帮助大家如何针对一个Activity页面去编写针对MVP风格的代码。
一、MVP模式介绍
随着UI创建技术的功能日益增强，UI层也履行着越来越多的职责。为了更好地细分视图(View)与模型(Model)的功能，让View专注于处理数据的可视化以及与用户的交互，同时让Model只关系数据的处理，基于MVC概念的MVP(Model-View-Presenter)模式应运而生。
在MVP模式里通常包含4个要素：
(1) View :负责绘制UI元素、与用户进行交互(在Android中体现为Activity);
(2) View interface :需要View实现的接口，View通过View interface与Presenter进行交互，降低耦合，方便进行单元测试;
(3) Model :负责存储、检索、操纵数据(有时也实现一个Model interface用来降低耦合);
(4) Presenter :作为View与Model交互的中间纽带，处理与用户交互的负责逻辑。


二、为什么使用MVP模式
在Android开发中，Activity并不是一个标准的MVC模式中的Controller， 它的首要职责是加载应用的布局和初始化用户界面，并接受并处理来自用户的操作请求，进而作出响应。随着界面及其逻辑的复杂度不断提升，Activity类的职责不断增加，以致变得庞大臃肿。当我们将其中复杂的逻辑处理移至另外的一个类（Presenter）中时，Activity其实就是MVP模式中View，它负责UI元素的初始化，建立UI元素与Presenter的关联（Listener之类），同时自己也会处理一些简单的逻辑（复杂的逻辑交由Presenter处理）.
另外，回想一下你在开发Android应用时是如何对代码逻辑进行单元测试的？是否每次都要将应用部署到Android模拟器或真机上，然后通过模拟用户操作进行测试？然而由于Android平台的特性，每次部署都耗费了大量的时间，这直接导致开发效率的降低。而在MVP模式中，处理复杂逻辑的Presenter是通过interface与View(Activity)进行交互的，这说明了什么？说明我们可以通过自定义类实现这个interface来模拟Activity的行为对Presenter进行单元测试，省去了大量的部署及测试的时间。

三、MVP与MVC的异同
MVC模式与MVP模式都作为用来分离UI层与业务层的一种开发模式被应用了很多年。在我们选择一种开发模式时，首先需要了解一下这种模式的利弊：
无论MVC或是MVP模式都不可避免地存在一个弊端：额外的代码复杂度及学习成本。
但比起他们的优点，这点弊端基本可以忽略了：
(1)降低耦合度
(2)模块职责划分明显
(3)利于测试驱动开发
(4)代码复用
(5)隐藏数据
(6)代码灵活性
1
2
3
4
5
6
对于MVP与MVC这两种模式，它们之间也有很大的差异。有一些程序员选择不使用任何一种模式，有一部分原因也许就是不能区分这两种模式差异。以下是这两种模式之间最关键的差异：
MVP模式：
1.View不直接与Model交互 ，而是通过与Presenter交互来与Model间接交互
2.Presenter与View的交互是通过接口来进行的，更有利于添加单元测试
3.通常View与Presenter是一对一的，但复杂的View可能绑定多个Presenter来处理逻辑     
1
2
3
MVC模式：
1.View可以与Model直接交互
2.Controller是基于行为的，并且可以被多个View共享
3.可以负责决定显示哪个View
1
2
3

四、利用MVP进行Android开发的例子
用mvp模式实现：通过输入用户名跟密码，点击登录，登录成功后，清除输入信息，并提示成功。 
1. 运行效果先看下： 
 
2.目录结构： 
 
可以发现，View不直接与Model交互 ，而是通过与Presenter交互来与Model间接交互并且Presenter与Model、View都是通过接口来进行交互的，既降低耦合也方便进行单元测试。
3.具体实现： 
1）首先实体类LoginResponse 不用考虑这个肯定有，其次从效果图可以看到至少有一个业务方法login()，这两点没什么难度，我们首先完成：
/**
 * <功能详细描述>
 *
 * @author caoyinfei
 * @version [版本号, 2016/5/4]
 * @see [相关类/方法]
 * @since [产品/模块版本]
 */
public class LoginResponse {
    private String resutlCode;

    private String resultInfo;

    public String getResutlCode() {
        return resutlCode;
    }

    public String getResultInfo() {
        return resultInfo;
    }

    public void setResutlCode(String resutlCode) {
        this.resutlCode = resutlCode;
    }

    public void setResultInfo(String resultInfo) {
        this.resultInfo = resultInfo;
    }
}

2）模型类（Model层） 
模型实现类通常是对本地数据库的操作或者是通过网络请求获取网络数据的操作 。
/**
 * @Title:
 * @Description: 模型抽象类
 * @Author:cyf
 * @Since:2016/11/23
 * @Version:
 */

public interface LoginTaskDataSource {
    /**
     * 保存登录信息到本地
     * @param loginResponse
     */
    void saveLoginResponse(LoginResponse loginResponse);

    /**
     * 登录请求
     * @param loginReq
     * @param callback
     */
    void login(LoginReq loginReq, NetTasksCallback callback);

    /**
     * 网络请求回调
     */
    interface NetTasksCallback {

        void onSuccess(LoginResponse loginResponse);

        void onFailure(String errorMsg);
    }

}

/**
 * model层，处理数据(包括网络，数据库等等)
 * 主要就是把presenter层拆分，以后网络框架，数据库换框架，不用动业务代码，只需要改Repository层代码
 */
public class LoginTasksRepository implements LoginTaskDataSource {


    @Override
    public void saveLoginResponse(LoginResponse loginResponse) {

    }

    @Override
    public void login(LoginReq loginReq, NetTasksCallback callback) {
        //开启网络请求
        /**
         * 网络请求，这边暂时省略
         */

        //成功后，回调到presenter层中
        LoginResponse response = new LoginResponse();
        response.setResultInfo(loginReq.getName() + "====" + loginReq.getPassword() + "====登录成功");
        response.setResutlCode("0");
        callback.onSuccess(response);
    }

}
3）再来看看View接口： 
上面我们说过，Presenter与View交互是通过接口。所以我们这里需要定义一个IUserLoginView ，难点就在于应该有哪些方法，我们这个是登录页面，其实有哪些功能，就应该有哪些方法，比如登录成功，失败，弹出加载框这些都要通知ui（Activity）去更新。所以定义了如下方法：
/**
 * <功能详细描述>
 *
 * @author caoyinfei
 * @version [版本号, 2016/5/4]
 * @see [相关类/方法]
 * @since [产品/模块版本]
 */
public interface IMvpView {
    void onError(String errorMsg, String code);

    void onSuccess();

    void showLoading();

    void hideLoading();
}

public interface IUserLoginView extends IMvpView {
    void clearEditContent();
}

4）Presenter 
Presenter是用作Model和View之间交互的桥梁。
/**
 * <基础业务类>
 *
 * @author caoyinfei
 * @version [版本号, 2016/6/6]
 * @see [相关类/方法]
 * @since [V1]
 */
public interface Presenter<V> {
    void attachView(V view);

    void detachView(V view);

    String getName();
}

/**
 * <基础业务类>
 *
 * @author caoyinfei
 * @version [版本号, 2016/6/6]
 * @see [相关类/方法]
 * @since [V1]
 */
public abstract class BasePresenter<V extends IMvpView> implements Presenter<V> {
    protected V mvpView;

    public void attachView(V view) {
        mvpView = view;
    }

    @Override
    public void detachView(V view) {
        mvpView = null;
    }

    @Override
    public String getName() {
        return mvpView.getClass().getSimpleName();
    }
}

/**
 * <绑定View层和Model层>
 *
 * @author caoyinfei
 * @version [版本号, 2016/5/4]
 * @see [相关类/方法]
 * @since [产品/模块版本]
 */
public class LoginPresenter extends BasePresenter<IUserLoginView> {

    private LoginTasksRepository loginTaskDataSource;

    public LoginPresenter() {
        loginTaskDataSource = new LoginTasksRepository();
    }

    public void login(LoginReq loginReq) {
        loginTaskDataSource.login(loginReq, new LoginTaskDataSource.NetTasksCallback() {

            @Override
            public void onSuccess(LoginResponse loginResponse) {
                mvpView.hideLoading();
                mvpView.onSuccess(loginResponse);
            }

            @Override
            public void onFailure(String errorMsg) {

            }
        });
    }
}

5）activity实现代码
/**
 * <登录界面>
 *
 * @author caoyinfei
 * @version [版本号, 2016/5/4]
 * @see [相关类/方法]
 * @since [产品/模块版本]
 */
public class MainActivity extends Activity implements View.OnClickListener, IUserLoginView {
    /**
     * 用户名
     */
    private EditText userName;
    /**
     * 密码
     */
    private EditText passWord;
    /**
     * 登录按钮
     */
    private Button button;

    private LoginPresenter mUserLoginPresenter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        initView();
        loadData();
    }

    /**
     * 初始化布局组件
     */
    private void initView() {
        userName = (EditText) findViewById(R.id.user_name);
        passWord = (EditText) findViewById(R.id.password);
        button = (Button) findViewById(R.id.login);

        /**
         * 添加按钮点击事件
         */
        button.setOnClickListener(this);
    }

    /**
     * 初始化数据
     */
    private void loadData() {
        mUserLoginPresenter = new LoginPresenter();
        mUserLoginPresenter.attachView(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.login:
                LoginReq loginReq = new LoginReq();
                loginReq.setName(userName.getText().toString());
                loginReq.setPassword(passWord.getText().toString());
                mUserLoginPresenter.login(loginReq);
                break;
            default:
                break;
        }
    }

    @Override
    public void onError(String errorMsg, String code) {

    }

    @Override
    public void onSuccess(Object response) {
        if (response instanceof LoginResponse) {
            LoginResponse loginResponse = (LoginResponse) response;
            Toast.makeText(this, loginResponse.getResultInfo(), 1).show();
        }
    }

    @Override
    public void showLoading() {

    }

    @Override
    public void hideLoading() {

    }

    @Override
    public void clearEditContent() {
        userName.setText("");
        passWord.setText("");
    }

    @Override
    protected void onDestroy() {
    mUserLoginPresenter.detachView(this);//Presenter对象持有Activity对象，这条GC链不剪断，Activity就无法被完整回收,造成内存泄漏
        super.onDestroy();
    }
}


个人理解，如有不同见解，欢迎留言~~ 
代码下载地址：http://download.csdn.net/detail/dfskhgalshgkajghljgh/9698405
版权声明：本文为博主原创文章，未经博主允许不得转载。 https://blog.csdn.net/dfskhgalshgkajghljgh/article/details/51317956 
