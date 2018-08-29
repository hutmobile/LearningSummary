MusicPlayService#Exoplayer
===
利用Exoplayer和MediaBrowserService实现的音乐播放服务(二)
---
在Activity中初始化MediaBrowser
---
### Todo
- [ ] 获取音频焦点
- [ ] 列表加载
- [ ] 优化加载策略
### Sources
#### MediaBrowser init
```kotlin
 private fun initMediaBrowser() {
    browserSubscriptionCallback = object : MediaBrowserCompat.SubscriptionCallback() {
      override fun onChildrenLoaded(
        parentId: String,
        children: MutableList<MediaBrowserCompat.MediaItem>
      ) {
        logd("onChildrenLoaded parent id = $parentId children.size = ${children.size}")
        viewModel.loadData(children).exec().observe(this@MainActivity, Observer { result ->
          if (result) toast("load successfully") else toast("loaded failed")
        })
        logd("After exec")
      }
    }
    browserConnectionCallback = object : MediaBrowserCompat.ConnectionCallback() {
      override fun onConnected() {
        logd("onConnected")
        //必须在确保连接成功的前提下执行订阅的操作
        if (mediaBrowser.isConnected) {
          logd("MediaBrowser is connected")
          //mediaId即为MediaBrowserService.onGetRoot的返回值
          //若Service允许客户端连接，则返回结果不为null，其值为数据内容层次结构的根ID
          //若拒绝连接，则返回null
          val rootId: String? = mediaBrowser.root
          logd("Rood id = $rootId")
          //Browser通过订阅的方式向Service请求数据，发起订阅请求需要两个参数，其一为mediaId
          //而如果该mediaId已经被其他Browser实例订阅，则需要在订阅之前取消mediaId的订阅者
          //虽然订阅一个 已被订阅的mediaId 时会取代原Browser的订阅回调，但却无法触发onChildrenLoaded回调

          //ps：虽然基本的概念是这样的，但是Google在官方demo中有这么一段注释...
          // This is temporary: A bug is being fixed that will make subscribe
          // consistently call onChildrenLoaded initially, no matter if it is replacing an existing
          // subscriber or not. Currently this only happens if the mediaID has no previous
          // subscriber or if the media content changes on the service side, so we need to
          // unsubscribe first.
          //大概的意思就是现在这里还有BUG，即只要发送订阅请求就会触发onChildrenLoaded回调
          //所以无论怎样我们发起订阅请求之前都需要先取消订阅
          mediaBrowser.unsubscribe(rootId!!)
          //之前说到订阅的方法还需要一个参数，即设置订阅回调SubscriptionCallback
          //当Service获取数据后会将数据发送回来，此时会触发SubscriptionCallback.onChildrenLoaded回调
          mediaBrowser.subscribe(rootId, browserSubscriptionCallback)
          logd("MediaBrowser subscribe")

          //
          try {
            controllerCallback = viewModel.controllerCallback
            mediaController =
                MediaControllerCompat(this@MainActivity, mediaBrowser.sessionToken)
            mediaController.registerCallback(controllerCallback)
            viewModel.mediaController = mediaController
            logd("Register controller callback successfully")
          } catch (e: Exception) {
            if (BuildConfig.DEBUG)
              e.printStackTrace()
            logd("Register controller callback failed")
          }
        } else {
          logd("MediaBrowser was not connected")
        }
      }

      override fun onConnectionFailed() {
        loge("MediaBrowser connect failed")
      }

    }
    mediaBrowser =
        MediaBrowserCompat(
          this,
          ComponentName(this, PlayService::class.java),
          browserConnectionCallback,
          null
        )
    viewModel.mediaBrowser = mediaBrowser
  }
```

#### Activity Complete source code
```kotlin
package com.messy.lingplayer

import android.content.ComponentName
import android.os.Bundle
import android.support.v4.media.MediaBrowserCompat
import android.support.v4.media.session.MediaControllerCompat
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import com.messy.lingplayer.component.PagerAdapter
import com.messy.lingplayer.playlist.PlayListFragment
import com.messy.lingplayer.playui.PlayUiFragment
import com.messy.lingplayer.service.PlayService
import com.messy.lingplayer.utils.logd
import com.messy.lingplayer.utils.loge
import com.messy.lingplayer.utils.toast
import com.messy.lingplayer.view.ViewPager
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_main)
    viewModel = ViewModelProviders.of(this).get(SharedViewModel::class.java)
    initMediaBrowser()
    initView()
  }

  override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
    super.onRequestPermissionsResult(requestCode, permissions, grantResults)
    if (requestCode == REQUEST_READ_EXTERNAL_STORAGE) {
      fragments[0].onRequestPermissionsResult(requestCode, permissions, grantResults)
    }
  }

  private fun initMediaBrowser() {
    browserSubscriptionCallback = object : MediaBrowserCompat.SubscriptionCallback() {
      override fun onChildrenLoaded(
        parentId: String,
        children: MutableList<MediaBrowserCompat.MediaItem>
      ) {
        logd("onChildrenLoaded parent id = $parentId children.size = ${children.size}")
        viewModel.loadData(children).exec().observe(this@MainActivity, Observer { result ->
          if (result) toast("load successfully") else toast("loaded failed")
        })
        logd("After exec")
      }
    }
    browserConnectionCallback = object : MediaBrowserCompat.ConnectionCallback() {
      override fun onConnected() {
        logd("onConnected")
        //必须在确保连接成功的前提下执行订阅的操作
        if (mediaBrowser.isConnected) {
          logd("MediaBrowser is connected")
          //mediaId即为MediaBrowserService.onGetRoot的返回值
          //若Service允许客户端连接，则返回结果不为null，其值为数据内容层次结构的根ID
          //若拒绝连接，则返回null
          val rootId: String? = mediaBrowser.root
          logd("Rood id = $rootId")
          //Browser通过订阅的方式向Service请求数据，发起订阅请求需要两个参数，其一为mediaId
          //而如果该mediaId已经被其他Browser实例订阅，则需要在订阅之前取消mediaId的订阅者
          //虽然订阅一个 已被订阅的mediaId 时会取代原Browser的订阅回调，但却无法触发onChildrenLoaded回调

          //ps：虽然基本的概念是这样的，但是Google在官方demo中有这么一段注释...
          // This is temporary: A bug is being fixed that will make subscribe
          // consistently call onChildrenLoaded initially, no matter if it is replacing an existing
          // subscriber or not. Currently this only happens if the mediaID has no previous
          // subscriber or if the media content changes on the service side, so we need to
          // unsubscribe first.
          //大概的意思就是现在这里还有BUG，即只要发送订阅请求就会触发onChildrenLoaded回调
          //所以无论怎样我们发起订阅请求之前都需要先取消订阅
          mediaBrowser.unsubscribe(rootId!!)
          //之前说到订阅的方法还需要一个参数，即设置订阅回调SubscriptionCallback
          //当Service获取数据后会将数据发送回来，此时会触发SubscriptionCallback.onChildrenLoaded回调
          mediaBrowser.subscribe(rootId, browserSubscriptionCallback)
          logd("MediaBrowser subscribe")

          //
          try {
            controllerCallback = viewModel.controllerCallback
            mediaController =
                MediaControllerCompat(this@MainActivity, mediaBrowser.sessionToken)
            mediaController.registerCallback(controllerCallback)
            viewModel.mediaController = mediaController
            logd("Register controller callback successfully")
          } catch (e: Exception) {
            if (BuildConfig.DEBUG)
              e.printStackTrace()
            logd("Register controller callback failed")
          }
        } else {
          logd("MediaBrowser was not connected")
        }
      }

      override fun onConnectionFailed() {
        loge("MediaBrowser connect failed")
      }

    }
    mediaBrowser =
        MediaBrowserCompat(
          this,
          ComponentName(this, PlayService::class.java),
          browserConnectionCallback,
          null
        )
    viewModel.mediaBrowser = mediaBrowser
  }

  private fun initView() {
    mainViewPager.orientation = ViewPager.VERTICAL
    fragments = mutableListOf(PlayListFragment.newInstance(), PlayUiFragment.newInstance())
    mainViewPager.adapter = PagerAdapter(supportFragmentManager, fragments)
    waveView.bottomProportion = 0.4f
  }

  private lateinit var viewModel: SharedViewModel
  private lateinit var fragments: MutableList<Fragment>
  private lateinit var mediaBrowser: MediaBrowserCompat
  private lateinit var mediaController: MediaControllerCompat
  private lateinit var controllerCallback: MediaControllerCompat.Callback
  private lateinit var browserConnectionCallback: MediaBrowserCompat.ConnectionCallback
  private lateinit var browserSubscriptionCallback: MediaBrowserCompat.SubscriptionCallback
}

```
