Recyclerview无法使用
在app目录下build.gradle内dependencies添加依赖库 compile 'com.android.support:recyclerview-v7:27.1.1'     Sync Now显示错误

解决办法：在android sdk目录下找到recyclerview-v7-27.1.1-sources.jar文件复制粘贴到app/libs文件夹
相关代码：
dependencies {
    implementation fileTree(dir: 'libs', include: ['*.jar'])
    implementation 'com.android.support:appcompat-v7:27.1.1'
    compile 'com.android.support:recyclerview-v7:27.1.1'
    implementation 'com.android.support.constraint:constraint-layout:1.1.0'
    testImplementation 'junit:junit:4.12'
    androidTestImplementation 'com.android.support.test:runner:1.0.2'
    androidTestImplementation 'com.android.support.test.espresso:espresso-core:3.0.2'
}





