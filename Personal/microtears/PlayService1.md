MusicPlayService#Exoplayer
===
利用Exoplayer和MediaBrowserService实现的音乐播放服务(一)
---
###Todo
- [ ] 获取音频焦点
- [ ] 列表加载
- [ ] 优化加载策略
###Sources

####MediaControl Callback 
```kotlin
 inner class SessionCallback : MediaSessionCompat.Callback() {

    override fun onPlay() {
      logd("onPlay")
      if (playbackState.state == PlaybackStateCompat.STATE_PAUSED)
        exoplayer.playWhenReady = true
      playbackState = buildState(PlaybackStateCompat.STATE_PLAYING)
    }

    override fun onPause() {
      logd("onPause")
      if (playbackState.state == PlaybackStateCompat.STATE_PLAYING)
        exoplayer.playWhenReady = false
      playbackState = buildState(PlaybackStateCompat.STATE_PAUSED)
    }

    override fun onPlayFromUri(uri: Uri, extras: Bundle) {
      logd("onPlayFromUri uri = $uri extras = $extras")
      try {
        when (playbackState.state) {
          PlaybackStateCompat.STATE_PLAYING, PlaybackStateCompat.STATE_PAUSED, PlaybackStateCompat.STATE_NONE -> {
            exoplayer.stop(true)
            //concatenatingMediaSource.clear()
            //concatenatingMediaSource.addMediaSource(mediaSourceFactory.createMediaSource(uri))
            exoplayer.playWhenReady = true
            exoplayer.prepare(mediaSourceFactory.createMediaSource(uri))

            playbackState = buildState(PlaybackStateCompat.STATE_CONNECTING)
            mediaSession.setPlaybackState(playbackState)
            mediaSession.setMetadata(buildMetaData(extras))
          }
        }
      } catch (e: Exception) {
        if (BuildConfig.DEBUG)
          e.printStackTrace()
      }
    }

    override fun onSeekTo(pos: Long) {
      logd("onSeekTo position = $pos ms")
      exoplayer.seekTo(position)
    }

    override fun onStop() {
      logd("onStop")
      exoplayer.stop()
    }

    override fun onSetRepeatMode(repeatMode: Int) {
      logd("onSetRepeatMode repeat mode = $repeatMode")
      exoplayer.repeatMode = repeatMode
    }

  }
```

####Service complete source code
```kotlin
package com.messy.lingplayer.service

import android.database.Cursor
import android.media.session.PlaybackState
import android.net.Uri
import android.os.Bundle
import android.provider.MediaStore
import android.support.v4.media.MediaBrowserCompat
import android.support.v4.media.MediaDescriptionCompat
import android.support.v4.media.MediaMetadataCompat
import android.support.v4.media.session.MediaSessionCompat
import android.support.v4.media.session.PlaybackStateCompat
import androidx.media.MediaBrowserServiceCompat
import com.google.android.exoplayer2.*
import com.google.android.exoplayer2.extractor.DefaultExtractorsFactory
import com.google.android.exoplayer2.source.ConcatenatingMediaSource
import com.google.android.exoplayer2.source.ExtractorMediaSource
import com.google.android.exoplayer2.trackselection.AdaptiveTrackSelection
import com.google.android.exoplayer2.trackselection.DefaultTrackSelector
import com.google.android.exoplayer2.upstream.DefaultBandwidthMeter
import com.google.android.exoplayer2.upstream.DefaultDataSourceFactory
import com.google.android.exoplayer2.util.Util
import com.messy.lingplayer.BuildConfig
import com.messy.lingplayer.R
import com.messy.lingplayer.utils.logd
import com.messy.lingplayer.utils.loge
import kotlin.concurrent.thread

class PlayService : MediaBrowserServiceCompat() {

  inner class SessionCallback : MediaSessionCompat.Callback() {

    override fun onPlay() {
      logd("onPlay")
      if (playbackState.state == PlaybackStateCompat.STATE_PAUSED)
        exoplayer.playWhenReady = true
      playbackState = buildState(PlaybackStateCompat.STATE_PLAYING)
    }

    override fun onPause() {
      logd("onPause")
      if (playbackState.state == PlaybackStateCompat.STATE_PLAYING)
        exoplayer.playWhenReady = false
      playbackState = buildState(PlaybackStateCompat.STATE_PAUSED)
    }

    override fun onPlayFromUri(uri: Uri, extras: Bundle) {
      logd("onPlayFromUri uri = $uri extras = $extras")
      try {
        when (playbackState.state) {
          PlaybackStateCompat.STATE_PLAYING, PlaybackStateCompat.STATE_PAUSED, PlaybackStateCompat.STATE_NONE -> {
            exoplayer.stop(true)
            //concatenatingMediaSource.clear()
            //concatenatingMediaSource.addMediaSource(mediaSourceFactory.createMediaSource(uri))
            exoplayer.playWhenReady = true
            exoplayer.prepare(mediaSourceFactory.createMediaSource(uri))

            playbackState = buildState(PlaybackStateCompat.STATE_CONNECTING)
            mediaSession.setPlaybackState(playbackState)
            mediaSession.setMetadata(buildMetaData(extras))
          }
        }
      } catch (e: Exception) {
        if (BuildConfig.DEBUG)
          e.printStackTrace()
      }
    }

    override fun onSeekTo(pos: Long) {
      logd("onSeekTo position = $pos ms")
      exoplayer.seekTo(position)
    }

    override fun onStop() {
      logd("onStop")
      exoplayer.stop()
    }

    override fun onSetRepeatMode(repeatMode: Int) {
      logd("onSetRepeatMode repeat mode = $repeatMode")
      exoplayer.repeatMode = repeatMode
    }

  }

  override fun onCreate() {
    super.onCreate()

    bandWidthMeter = DefaultBandwidthMeter()
    factory = AdaptiveTrackSelection.Factory(bandWidthMeter)
    trackSelector = DefaultTrackSelector(factory)
    loadControl = DefaultLoadControl()
    rendererFactory = DefaultRenderersFactory(this)
    dataSourceFactory =
            DefaultDataSourceFactory(this, Util.getUserAgent(this, this.resources.getString(R.string.app_name)))
    extractorFactory = DefaultExtractorsFactory()
    mediaSourceFactory =
            ExtractorMediaSource.Factory(dataSourceFactory).apply { setExtractorsFactory(extractorFactory) }
    concatenatingMediaSource = ConcatenatingMediaSource()

    exoplayer = ExoPlayerFactory.newSimpleInstance(rendererFactory, trackSelector, loadControl)
    exoplayer.addListener(eventListener)
    exoplayer.volume = 100f

    //
    playbackState = buildState()

    sessionCallback = SessionCallback()

    mediaSession = MediaSessionCompat(this, this.javaClass.simpleName)
    // Set Callback
    mediaSession.setCallback(sessionCallback)
    mediaSession.setFlags(MediaSessionCompat.FLAG_HANDLES_TRANSPORT_CONTROLS)
    mediaSession.setPlaybackState(playbackState)

    sessionToken = mediaSession.sessionToken
  }

  override fun onLoadChildren(parentId: String, result: Result<MutableList<MediaBrowserCompat.MediaItem>>) {
    logd("onLoadChildren parent id = $parentId")
    result.detach()
    thread {
      try {
        contentResolver.query(
          MediaStore.Audio.Media.EXTERNAL_CONTENT_URI,
          null,
          null,
          null,
          MediaStore.Audio.Media.DEFAULT_SORT_ORDER).use { cursor ->
          logd("Cursor use")
          val list: MutableList<MediaBrowserCompat.MediaItem> = mutableListOf()
          if (cursor.moveToFirst()) {
            do {
              try {
                val metaData = buildMetaData(cursor)
                val desc = metaData.description
                val description = MediaDescriptionCompat.Builder()
                  .setMediaId(desc.mediaId)
                  .setDescription(desc.description)
                  .setIconUri(desc.iconUri)
                  .setMediaUri(desc.mediaUri)
                  .setExtras(metaData.bundle)
                  .build()
                val mediaItem = MediaBrowserCompat.MediaItem(description, MediaBrowserCompat.MediaItem.FLAG_PLAYABLE)
                list.add(mediaItem)
                logd("Add item ${list.size}")
              } catch (e: Exception) {
                if (BuildConfig.DEBUG)
                  e.printStackTrace()
                logd("Add item ${list.size} filed ,continue")
              }
              //TODO debug
              if (list.size == 100)
                break
            } while (cursor.moveToNext())
          }
          list.sortBy { item ->
            item.description.extras?.getString(MediaStore.Audio.Media.DATE_ADDED)
          }
          logd("Sort with added date")
          val sizeAll = list.size
          val newList = list.filter { item ->
            val path = item.description.extras?.getString(MediaStore.Audio.Media.DATA)
            return@filter if (path != null) {
              !path.endsWith(".flac") && !path.endsWith(".ape")
            } else false
          }.toMutableList()
          val sizeFilter = newList.size
          logd("Filter without flac and ape. num = ${sizeAll - sizeFilter}")
          //TODO FIX sort use newList
          result.sendResult(newList)
          logd("Send result")
        }
      } catch (e: Exception) {
        if (BuildConfig.DEBUG)
          e.printStackTrace()
        logd("Send Nothing")
      }

    }

  }

  override fun onGetRoot(clientPackageName: String, clientUid: Int, rootHints: Bundle?): BrowserRoot? {
    logd("onGetRoot client package name = $clientPackageName client uid = $clientUid root hints = $rootHints")
    val rootId = "rootId"
    return BrowserRoot(rootId, null)
  }

  fun buildState(
    @PlaybackStateCompat.State state: Int = PlaybackStateCompat.STATE_NONE, position: Long = this.position,
    playbackSpeed: Float = this.playbackSpeed): PlaybackStateCompat {
    return PlaybackStateCompat.Builder().setState(state, position, playbackSpeed).build()
  }

  private fun buildMetaData(extras: Bundle): MediaMetadataCompat {
    val albumId = extras.getString(MediaStore.Audio.Media.ALBUM_ID)
    val uriAlbums = "content://media/external/audio/albums/$albumId"
    val projection = arrayOf("album_art")
    var uriAlbumArtIcon = ""
    contentResolver.query(Uri.parse(uriAlbums), projection, null, null, null)?.use {
      it.moveToNext()
      uriAlbumArtIcon = it.getString(0) ?: uriAlbumArtIcon
    }
    return MediaMetadataCompat.Builder()
      .putString(MediaStore.Audio.Media.TITLE, extras.getString(MediaStore.Audio.Media.TITLE))
      .putString(MediaStore.Audio.Media.YEAR, extras.getString(MediaStore.Audio.Media.YEAR))
      .putString(MediaStore.Audio.Media.SIZE, extras.getString(MediaStore.Audio.Media.SIZE))
      .putString(MediaStore.Audio.Media.DATA, extras.getString(MediaStore.Audio.Media.DATA))
      .putString(MediaStore.Audio.Media.DATA, extras.getString(MediaStore.Audio.Media.DATA))
      .putString(MediaStore.Audio.Media.ALBUM, extras.getString(MediaStore.Audio.Media.ALBUM))
      .putString(MediaStore.Audio.Media.ARTIST, extras.getString(MediaStore.Audio.Media.ARTIST))
      .putString(MediaStore.Audio.Media.DURATION, extras.getString(MediaStore.Audio.Media.DURATION))
      .putString(MediaStore.Audio.Media.MIME_TYPE, extras.getString(MediaStore.Audio.Media.MIME_TYPE))
      .putString(MediaStore.Audio.Media.DATE_ADDED, extras.getString(MediaStore.Audio.Media.DATE_ADDED))
      .putString(MediaStore.Audio.Media.DATE_MODIFIED, extras.getString(MediaStore.Audio.Media.DATE_MODIFIED))
      .putString(MediaStore.Audio.Media.DISPLAY_NAME, extras.getString(MediaStore.Audio.Media.DISPLAY_NAME))
      /**/
      .putString(MediaMetadataCompat.METADATA_KEY_TITLE, extras.getString(MediaStore.Audio.Media.TITLE))
      .putString(MediaMetadataCompat.METADATA_KEY_MEDIA_URI, extras.getString(MediaStore.Audio.Media.DATA))
      .putString(MediaMetadataCompat.METADATA_KEY_ALBUM, extras.getString(MediaStore.Audio.Media.ALBUM))
      .putString(MediaMetadataCompat.METADATA_KEY_ARTIST, extras.getString(MediaStore.Audio.Media.ARTIST))
      .putString(MediaMetadataCompat.METADATA_KEY_DISPLAY_TITLE, extras.getString(MediaStore.Audio.Media.DISPLAY_NAME))
      .putString(MediaMetadataCompat.METADATA_KEY_ALBUM_ART_URI, uriAlbumArtIcon)
      .putString(MediaMetadataCompat.METADATA_KEY_DISPLAY_ICON_URI, uriAlbumArtIcon)
      /**/
      .putLong(MediaMetadataCompat.METADATA_KEY_DURATION, extras.getString(MediaStore.Audio.Media.DURATION).toLong())
      .putLong(MediaMetadataCompat.METADATA_KEY_YEAR, extras.getLong(MediaStore.Audio.Media.YEAR))
      .build()
  }

  private fun buildMetaData(cursor: Cursor): MediaMetadataCompat {
    val albumId = cursor.getInt(cursor.getColumnIndex(MediaStore.Audio.Media.ALBUM_ID))
    val uriAlbums = "content://media/external/audio/albums/$albumId"
    val projection = arrayOf("album_art")
    var uriAlbumArtIcon = ""
    contentResolver.query(Uri.parse(uriAlbums), projection, null, null, null)?.use {
      it.moveToNext()
      uriAlbumArtIcon = it.getString(0) ?: uriAlbumArtIcon
    }
    return MediaMetadataCompat.Builder()
      .putString(MediaStore.Audio.Media.TITLE, cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.TITLE)))
      .putString(MediaStore.Audio.Media.YEAR, cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.YEAR)))
      .putString(MediaStore.Audio.Media.SIZE, cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.SIZE)))
      .putString(MediaStore.Audio.Media.DATA, cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.DATA)))
      .putString(MediaStore.Audio.Media.DATA, cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.DATA)))
      .putString(MediaStore.Audio.Media.ALBUM, cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.ALBUM)))
      .putString(MediaStore.Audio.Media.ARTIST, cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.ARTIST)))
      .putString(
        MediaStore.Audio.Media.DURATION,
        cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.DURATION)))
      .putString(
        MediaStore.Audio.Media.MIME_TYPE,
        cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.MIME_TYPE)))
      .putString(
        MediaStore.Audio.Media.DATE_ADDED,
        cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.DATE_ADDED)))
      .putString(
        MediaStore.Audio.Media.DATE_MODIFIED,
        cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.DATE_MODIFIED)))
      .putString(
        MediaStore.Audio.Media.DISPLAY_NAME,
        cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.DISPLAY_NAME)))
      .putString(
        MediaStore.Audio.Media.ALBUM_ID,
        cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.ALBUM_ID)))
      /**/
      .putString(
        MediaMetadataCompat.METADATA_KEY_TITLE,
        cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.TITLE)))
      .putString(
        MediaMetadataCompat.METADATA_KEY_MEDIA_URI,
        cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.DATA)))
      .putString(
        MediaMetadataCompat.METADATA_KEY_ALBUM,
        cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.ALBUM)))
      .putString(
        MediaMetadataCompat.METADATA_KEY_ARTIST,
        cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.ARTIST)))
      .putString(
        MediaMetadataCompat.METADATA_KEY_DISPLAY_TITLE,
        cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.DISPLAY_NAME)))
      .putString(MediaMetadataCompat.METADATA_KEY_ALBUM_ART_URI, uriAlbumArtIcon)
      .putString(MediaMetadataCompat.METADATA_KEY_DISPLAY_ICON_URI, uriAlbumArtIcon)
      .putString(
        MediaMetadataCompat.METADATA_KEY_MEDIA_ID,
        cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media._ID)))
      /**/
      .putLong(
        MediaMetadataCompat.METADATA_KEY_DURATION,
        cursor.getLong(cursor.getColumnIndex(MediaStore.Audio.Media.DURATION)))
      .putLong(
        MediaMetadataCompat.METADATA_KEY_YEAR,
        cursor.getLong(cursor.getColumnIndex(MediaStore.Audio.Media.YEAR)))
      .build()
  }

  private var position: Long = 0
  private var playbackSpeed: Float = 1f

  private lateinit var mediaSession: MediaSessionCompat

  private lateinit var playbackState: PlaybackStateCompat

  private lateinit var sessionCallback: SessionCallback
  /**
   * ExoPlayer Group
   */
  private lateinit var bandWidthMeter: DefaultBandwidthMeter
  private lateinit var factory: AdaptiveTrackSelection.Factory
  private lateinit var trackSelector: DefaultTrackSelector
  private lateinit var loadControl: DefaultLoadControl
  private lateinit var rendererFactory: DefaultRenderersFactory
  private lateinit var dataSourceFactory: DefaultDataSourceFactory
  private lateinit var extractorFactory: DefaultExtractorsFactory
  private lateinit var mediaSourceFactory: ExtractorMediaSource.Factory
  private lateinit var concatenatingMediaSource: ConcatenatingMediaSource
  private lateinit var exoplayer: SimpleExoPlayer

  private val eventListener = object : Player.DefaultEventListener() {

    override fun onPlayerError(error: ExoPlaybackException?) {
      loge("Player error")
      if (BuildConfig.DEBUG)
        super.onPlayerError(error)
    }

    override fun onPlayerStateChanged(playWhenReady: Boolean, playbackState: Int) {
      super.onPlayerStateChanged(playWhenReady, playbackState)
      if (BuildConfig.DEBUG) {
        when (playbackState) {
          PlaybackState.STATE_BUFFERING -> {
            logd("buffering")
            this@PlayService.playbackState = buildState(PlaybackStateCompat.STATE_BUFFERING)
          }
          PlaybackState.STATE_CONNECTING -> {
            logd("connecting")
            this@PlayService.playbackState = buildState(PlaybackStateCompat.STATE_CONNECTING)
          }
          PlaybackState.STATE_ERROR -> {
            logd("error")
            this@PlayService.playbackState = buildState(PlaybackStateCompat.STATE_ERROR)
          }
          PlaybackState.STATE_FAST_FORWARDING -> {
            logd("fast forwarding")
            this@PlayService.playbackState = buildState(PlaybackStateCompat.STATE_FAST_FORWARDING)
          }
          PlaybackState.STATE_NONE -> {
            logd("none")
            this@PlayService.playbackState = buildState(PlaybackStateCompat.STATE_NONE)
          }
          PlaybackState.STATE_PAUSED -> {
            logd("pause ")
            this@PlayService.playbackState = buildState(PlaybackStateCompat.STATE_PAUSED)
          }
          PlaybackState.STATE_PLAYING -> {
            logd("playing")
            this@PlayService.playbackState = buildState(PlaybackStateCompat.STATE_PLAYING)
          }
          PlaybackState.STATE_REWINDING -> {
            logd("rewinding")
            this@PlayService.playbackState = buildState(PlaybackStateCompat.STATE_REWINDING)
          }
          PlaybackState.STATE_SKIPPING_TO_NEXT -> {
            logd("skipping to next")
            this@PlayService.playbackState = buildState(PlaybackStateCompat.STATE_SKIPPING_TO_NEXT)
          }
          PlaybackState.STATE_SKIPPING_TO_PREVIOUS -> {
            logd("skipping to previous")
            this@PlayService.playbackState = buildState(PlaybackStateCompat.STATE_SKIPPING_TO_PREVIOUS)
          }
          PlaybackState.STATE_SKIPPING_TO_QUEUE_ITEM -> {
            logd("skipping to queue item")
            this@PlayService.playbackState = buildState(PlaybackStateCompat.STATE_SKIPPING_TO_QUEUE_ITEM)
          }
          PlaybackState.STATE_STOPPED -> {
            logd("stopped")
            this@PlayService.playbackState = buildState(PlaybackStateCompat.STATE_STOPPED)
          }
        }
      }
    }

  }

}
```

