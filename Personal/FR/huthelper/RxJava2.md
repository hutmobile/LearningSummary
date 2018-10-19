```
 APIUtils
                .getLessonAPI()
                .getLesson(studentId,remember_app_code)
                .compose(getActivity().<LessonResult>bindToLifecycle())
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .map(new Function<LessonResult, List<Lesson>>() {
                    @Override
                    public List<Lesson> apply(LessonResult lessonResult) throws Exception {
                        List<Lesson> lessonList = new ArrayList<>();
                        if (lessonResult.getCode() == 200){
                            List<LessonResult.DataBean> list = lessonResult.getData();
                            for (LessonResult.DataBean dataBean : list){

                                Lesson lesson = new Lesson();
                                lesson.setName(dataBean.getName());
                                lesson.setRoom(dataBean.getRoom());
                                lesson.setTeacher(dataBean.getTeacher());
                                lesson.setDjj(dataBean.getDjj());
                                lesson.setDsz(dataBean.getDsz());
                                lesson.setXqj(dataBean.getXqj());
                                lesson.setStudentId(dataBean.getXh());

                                List<Integer> zs = dataBean.getZs();
                                StringBuilder stringBuilder = new StringBuilder();

                                for (Integer integer : zs){
                                    stringBuilder.append(integer).append(",");
                                }
                                lesson.setZs(stringBuilder.toString());
                                lessonList.add(lesson);
                            }
                        }

                        //写入数据库
                        LessonDao lessonDao = daoSession.getLessonDao();

                        if (!ListUtil.isEmpty(lessonList)){
                            List<Lesson> list = lessonDao.queryBuilder()
                                    .where(LessonDao.Properties.StudentId.eq(studentId)).list();
                            for (Lesson oldLesson : list){
                                lessonDao.delete(oldLesson);
                            }
                            for (Lesson newLesson : lessonList){
                                lessonDao.insert(newLesson);
                            }
                        }
                        return null;
                    }
                }).subscribe(new Observer<List<Lesson>>() {
            @Override
            public void onSubscribe(Disposable d) {

            }

            @Override
            public void onNext(List<Lesson> lessonList) {
                if (getView() != null){
                    getView().closeLoading();

                    if (ListUtil.isEmpty(lessonList)){
                        getView().showMessage("未找到你的课表！");
                    }
                }
            }

            @Override
            public void onError(Throwable e) {
                if (getView() != null){

                    getView().closeLoading();
                    
                }
            }

            @Override
            public void onComplete() {

            }
        });
```
# 线程调度

1. subscribeOn()用于指定subscribe()时所发生的线程。
2. observeOn()用于observer()回调发生的线程

线程切换时注意项
---
1. subscribeOn()指定的就是发射事件的线程，observerOn()指定的就是订阅者接收事件的线程
2. 多次指定发射事件的线程只有第一次指定的有效，也就是说多次调用subscribeOn()只有第一次的有效，其余的会被忽略掉
3. 但多次指定订阅者接收线程实可以的，每调用一次observerOn()，下游的线程就会切换一次

RxJava中的线程：
---
1. Schedulers.io() 代表io操作的线程，通常用于网络，读写文件等io密集型的操作
2. Schedulers.computation() 代表CPU计算密集型的操作，例如需要大量计算的操作
3. Schedulers.newThread() 代表一个常规的新线程
4. AndroidSchedulers.mainThread() 代表Android的主线程

# 操作符

map
---
map操作符可以将一个Observable对象通过某种关系转换为另一个Observable对象。在2.X中和1.x中作用几乎一致，不同于2.x将1.x中的Func1和Func2改为了Function和BiFunction。

concat
---
concat可以做到不交错的发射两个甚至多个Observable的发射事件，并且只有前一个Observable终止（onComplete）后才会订阅下一个Observable。

采用concat操作符先读取缓存再通过网络请求获取数据
---
利用concat的必须调用onComplete后才能订阅下一个observable的特性，我们就可以先读取缓存数据，倘若获取到的缓存数据不是我们想要的，再调用 onComplete() 以执行获取网络数据的 Observable，如果缓存数据能应我们所需，则直接调用 onNext()，防止过度的网络请求，浪费用户的流量。
```
 Observable<FoodList> cache = Observable.create(new ObservableOnSubscribe<FoodList>() {
        @Override
        public void subscribe(@NonNull ObservableEmitter<FoodList> e) throws Exception {
            Log.e(TAG, "create当前线程:" + Thread.currentThread().getName());
            FoodList data = CacheManager.getInstance().getFoodListData();

            // 在操作符 concat 中，只有调用 onComplete 之后才会执行下一个 Observable
            if (data != null) {// 如果缓存数据不为空，则直接读取缓存数据，而不读取网络数据 
                isFromNet = false;
                Log.e(TAG, "\nsubscribe: 读取缓存数据:");
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        mRxOperatorsText.append("\nsubscribe: 读取缓存数据:\n");
                    }
                });

                e.onNext(data);
            } else {
                isFromNet = true;
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        mRxOperatorsText.append("\nsubscribe: 读取网络数据:\n");
                    }
                });
                Log.e(TAG, "\nsubscribe: 读取网络数据:");
                e.onComplete();
            }
        }
    });

    Observable<FoodList> network = Rx2AndroidNetworking
            .get("http://www.tngou.net/api/food/list")
            .addQueryParameter("rows", 10 + "")
            .build().getObjectObservable(FoodList.class);

    // 两个 Observable 的泛型应当保持一致
    Observable.concat(cache,network)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe(new Consumer<FoodList>() {
                @Override public void accept (@NonNull FoodList tngouBeen) throws Exception {
                    Log.e(TAG, "subscribe 成功:" + Thread.currentThread().getName());
                    if (isFromNet) {
                        mRxOperatorsText.append("accept : 网络获取数据设置缓存: \n");
                        Log.e(TAG, "accept : 网络获取数据设置缓存: \n" + tngouBeen.toString());
                        CacheManager.getInstance().setFoodListData(tngouBeen);
            }
            mRxOperatorsText.append("accept: 读取数据成功:" + tngouBeen.toString() + "\n");
            Log.e(TAG, "accept: 读取数据成功:" + tngouBeen.toString());
        }
    }
});

```

flatMap实现多个网络请求依次依赖
---
这种情况也在实际情况中比比皆是，例如用户注册成功后需要自动登录，只需要先通过注册接口注册用户信息，注册成功后马上调用登录接口进行自动登录即可。flatMap 恰好解决了这种应用场景，flatMap 操作符可以将一个发射数据的 Observable 变换为多个 Observables ，然后将它们发射的数据合并后放到一个单独的 Observable，利用这个特性，很轻松地达到了需求。

采用 interval 操作符实现心跳间隔任务
---

zip 操作符，实现多个接口数据共同更新 UI
---