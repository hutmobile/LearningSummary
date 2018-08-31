# MusicPlayService#Exoplayer

## 利用Exoplayer和MediaBrowserService实现的音乐播放服务(三)

## 在Fragment中控制媒体播放

关于如何在activity和fragment中共享资源查看另一篇文章《在Activity和多个Fragment之间共享资源》

### Todo

- [ ] 获取音频焦点
- [ ] 列表加载
- [ ] 优化加载策略

### Sources

#### Fragment complete source code

```kotlin
package com.messy.lingplayer.playlist

import android.Manifest
import android.content.pm.PackageManager
import android.os.Bundle
import android.support.v4.media.MediaBrowserCompat
import android.support.v4.media.MediaMetadataCompat
import android.support.v4.media.session.MediaControllerCompat
import android.support.v4.media.session.PlaybackStateCompat
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import com.messy.lingplayer.R
import com.messy.lingplayer.REQUEST_READ_EXTERNAL_STORAGE
import com.messy.lingplayer.SharedViewModel
import com.messy.lingplayer.component.ViewAdapter
import com.messy.lingplayer.component.ViewHolder
import com.messy.lingplayer.utils.*
import kotlinx.android.synthetic.main.play_list_fragment.*

class PlayListFragment : Fragment() {

  override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
    return inflater.inflate(R.layout.play_list_fragment, container, false)
  }

  override fun onActivityCreated(savedInstanceState: Bundle?) {
    super.onActivityCreated(savedInstanceState)
    viewModel = ViewModelProviders.of(activity!!).get(SharedViewModel::class.java)
    // Use the ViewModel
    initView()
    bindData()
    initCallback()
  }

  override fun onStart() {
    super.onStart()
    logd("onStart")
    if (checkPermissions() && !viewModel.mediaBrowser.isConnected) {
      logd("Connect")
      viewModel.mediaBrowser.connect()
    }
  }

  override fun onDestroy() {
    super.onDestroy()
    logd("onDestroy")
    if (viewModel.mediaBrowser.isConnected) {
      logd("Disconnect")
      viewModel.mediaBrowser.disconnect()
    }
  }

  private fun initView() {
    logd("Play list fragment init view")
    playListView.apply {
      layoutManager = LinearLayoutManager(context!!)
      viewAdapter = ViewAdapter(R.layout.item_play_list)
      viewAdapter.setOnBindListener { viewHolder, item ->
        viewHolder.getView<TextView>(R.id.title).text = item.getTitle()
        viewHolder.getView<TextView>(R.id.artist).text = item.getArtist()
        viewHolder.getView<TextView>(R.id.filepath).text = item.getPath()
      }
      viewAdapter.setOnItemClickListener { view, position ->
        logd("onItemClick position=$position")
        viewModel.playWithPosition(position).exec().observe(this@PlayListFragment, Observer { result ->
          if (result) toast("play started") else toast("play failed")
        })
      }
      adapter = viewAdapter
    }
    toast("Scanning media library now,please wait")
    swipe.isRefreshing = true
    swipe.setOnRefreshListener {
      swipe.isRefreshing = false
    }
  }

  private fun initCallback() {
    logd("Init callback")
    viewModel.controllerCallback = object : MediaControllerCompat.Callback() {
      override fun onPlaybackStateChanged(state: PlaybackStateCompat?) {
        when (state!!.state) {

        }
      }

      override fun onMetadataChanged(metadata: MediaMetadataCompat?) {

      }
    }
  }

  private fun bindData() {
    logd("Bind data")
    viewModel.playList.observe(this, Observer { list ->
      logd("Update playlist list size = ${list.size}")
      swipe.isRefreshing = false
      viewAdapter.data.clear()
      viewAdapter.data.addAll(list)
      viewAdapter.notifyDataSetChanged()
    })
  }

  private fun checkPermissions(): Boolean {
    logd("Check permission")
    val permissions = mutableListOf<String>()
    if (ContextCompat.checkSelfPermission(
        context!!,
        Manifest.permission.READ_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED)
      permissions.add(Manifest.permission.READ_EXTERNAL_STORAGE)
    if (permissions.size > 0) {
      ActivityCompat.requestPermissions(activity!!, permissions.toTypedArray(), REQUEST_READ_EXTERNAL_STORAGE)
      return false
    }
    return true
  }

  override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
    super.onRequestPermissionsResult(requestCode, permissions, grantResults)
    when (requestCode) {
      REQUEST_READ_EXTERNAL_STORAGE -> {
        if (checkPermissions())
          viewModel.mediaBrowser.connect()
        else {
          toast("You refused reading file permission")
          activity!!.finish()
        }
      }
    }
  }

  private lateinit var viewAdapter: ViewAdapter<MediaBrowserCompat.MediaItem, ViewHolder>

  private lateinit var viewModel: SharedViewModel

  companion object {
    fun newInstance() = PlayListFragment()
  }
}

```
