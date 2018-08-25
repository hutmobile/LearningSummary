在Activity和多个Fragment之间共享资源
===
Android Studio 默认生成的代码一般是这样的：
```kotlin
package com.messy.lingplayer.playui

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProviders
import com.messy.lingplayer.R
import com.messy.lingplayer.SharedViewModel

class PlayUiFragment : Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.play_ui_fragment, container, false)
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        viewModel = ViewModelProviders.of(this).get(SharedViewModel::class.java)
        // TODO: Use the ViewModel
    }

    private lateinit var viewModel: SharedViewModel

    companion object {
        fun newInstance() = PlayUiFragment()
    }

}

```
关键在于这一句
```kotlin
viewModel = ViewModelProviders.of(this).get(SharedViewModel::class.java)
```
其中ViewModelProviders.of(this)表示将viewModel绑定到这个Fragment的生命周期（这里的this便表示当前的Fragment对象）我们可以将this改为activity，即将viewModel绑定到Fangment所在的Activity的生命周期上，即
```kotlin
viewModel = ViewModelProviders.of(activity!!).get(SharedViewModel::class.java)
```
然后再相应的Activity中绑定SharedViewModel：
```kotlin
 override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_main)
    viewModel = ViewModelProviders.of(this).get(SharedViewModel::class.java)
    initMediaBrowser()
    initView()
  }
```
那么便可在Activity的整个生命周期之内和多个Fragment共享资源

##原理
>ViewModel的生命周期依赖于对应的Activity或Fragment的生命周期。通常会在Activity第一次onCreate()时创建ViewModel，ViewModel的生命周期一直持续到Activity最终销毁或Frament最终detached，期间由于屏幕旋转等配置变化引起的Activity销毁重建并不会导致ViewModel重建。借用官方示意图来解释一下：

![](https://s1.ax1x.com/2018/08/25/PHcjGd.png)

这样就可以避免在Activity直接利用接口进行回调