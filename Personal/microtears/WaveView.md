WaveView
===
一个简单的仿Zine首页的波浪动画
---
### Todo
- [ ] attr(尚未支持) 
### 源代码
```kotlin
@file:Suppress("unused", "MemberVisibilityCanBePrivate")

package com.messy.lingplayer.view

import android.animation.ValueAnimator
import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Path
import android.graphics.drawable.ColorDrawable
import android.text.TextPaint
import android.util.AttributeSet
import android.view.View
import android.view.animation.LinearInterpolator
import android.widget.FrameLayout
import com.messy.lingplayer.utils.toPx

class WaveView : FrameLayout {
  constructor(context: Context) : super(context)
  constructor(context: Context, attrs: AttributeSet) : super(context, attrs)
  constructor(context: Context, attrs: AttributeSet, defStyleAttr: Int) : super(context, attrs, defStyleAttr)

  init {
    if (background == null) background = ColorDrawable(0x000000)
    setLayerType(View.LAYER_TYPE_SOFTWARE, null)
  }

  var waveWidthProportion = 5f
  var topProportion = 0.0f
  var bottomProportion = 0.2f
  var cycleWidth = context.toPx(45).toFloat()
  var colorA = Color.parseColor("#FF00E1FF")
  var colorB = Color.parseColor("#30EDEDED")
  var colorC = Color.parseColor("#11000000")
  var duration: Long
    get() = animator.duration
    set(value) {
      animator.duration = value
    }
  var isStart: Boolean
    get() = animator.isRunning
    set(value) {
      if (value)
        animator.start()
      else
        animator.cancel()
    }
  private var dx = 0f
  private val pathA = Path()
  private val pathB = Path()
  private val pathC = Path()
  private val proportionB = 0.5f
  private val proportionC = 1.5f
  private val waveWidthProportionB = waveWidthProportion * proportionB
  private val waveWidthProportionC = waveWidthProportion * proportionC
  private val accWidth = context.toPx(24).toFloat()

  private val wavePaintA by lazy {
    Paint().apply {
      strokeWidth = 2f
      style = Paint.Style.FILL
      color = colorA
      isAntiAlias = true
    }
  }
  private val wavePaintB by lazy {
    Paint().apply {
      strokeWidth = 2f
      style = Paint.Style.FILL
      color = colorB
      isAntiAlias = true
    }
  }
  private val wavePaintC by lazy {
    Paint().apply {
      strokeWidth = 2f
      style = Paint.Style.FILL
      color = colorC
      isAntiAlias = true
    }
  }
  private val textPaint by lazy {
    TextPaint().apply {
      color = Color.BLACK
      textSize = 70f
    }
  }
  private val animator by lazy {
    ValueAnimator.ofFloat(0f, waveWidthProportion * width).apply {
      duration = 10000L
      interpolator = LinearInterpolator()
      repeatCount = ValueAnimator.INFINITE
      addUpdateListener {
        dx = it.animatedValue as Float
        postInvalidate()
      }
    }
  }

  override fun onAttachedToWindow() {
    super.onAttachedToWindow()
    animator.start()
  }

  override fun onDetachedFromWindow() {
    super.onDetachedFromWindow()
    animator.cancel()
  }

  override fun onSizeChanged(w: Int, h: Int, oldw: Int, oldh: Int) {
    super.onSizeChanged(w, h, oldw, oldh)
    animator.setFloatValues(0f, waveWidthProportion * width)
  }

  override fun onDraw(canvas: Canvas) {
    super.onDraw(canvas)
    //val t = "isStart=$isStart dx=$dx "
    //canvas.drawText(t, 0, t.length, 0f, height * 0.5f, textPaint)
    //canvas.drawPath(getWaveD(), wavePaintA)
    canvas.drawPath(getWaveA(), wavePaintA)
    canvas.drawPath(getWaveB(), wavePaintB)
    canvas.drawPath(getWaveC(), wavePaintC)
  }

  private fun getWaveD(): Path {
    pathA.reset()
    pathA.apply {
      moveTo(-width * waveWidthProportion + dx, height * bottomProportion - cycleWidth)
      for (i in 0..2) {
        rQuadTo(width * waveWidthProportion / 4f, -cycleWidth, width * waveWidthProportion / 2f, 0f)
        rQuadTo(width * waveWidthProportion / 4f, cycleWidth, width * waveWidthProportion / 2f, 0f)
      }
      lineTo(width * waveWidthProportion, height * topProportion)
      lineTo(0f, height * topProportion)
      close()
      fillType = Path.FillType.WINDING
    }
    return pathA
  }

  private fun getWaveA(): Path {
    pathA.reset()
    pathA.apply {
      moveTo(-width * waveWidthProportion + dx, height * bottomProportion - cycleWidth)
      for (i in 0..2) {
        rQuadTo(width * waveWidthProportion / 4f, -cycleWidth, width * waveWidthProportion / 2f, 0f)
        rQuadTo(width * waveWidthProportion / 4f, cycleWidth, width * waveWidthProportion / 2f, 0f)
      }
      lineTo(width * waveWidthProportion, height * topProportion)
      lineTo(0f, height * topProportion)
      close()
      fillType = Path.FillType.WINDING
    }
    return pathA
  }

  private fun getWaveB(): Path {
    pathB.reset()
    pathB.apply {
      moveTo(-width * waveWidthProportionB + dx * proportionB, height * bottomProportion - accWidth - cycleWidth)
      for (i in 0..2) {
        rQuadTo(width * waveWidthProportionB / 4f, -cycleWidth, width * waveWidthProportionB / 2f, 0f)
        rQuadTo(width * waveWidthProportionB / 4f, cycleWidth, width * waveWidthProportionB / 2f, 0f)
      }
      lineTo(width * waveWidthProportionB, height * topProportion)
      lineTo(0f, height * topProportion)
      close()
      fillType = Path.FillType.WINDING
    }
    return pathB
  }

  private fun getWaveC(): Path {
    pathC.reset()
    pathC.apply {
      moveTo(-width * waveWidthProportionC + dx * proportionC, height * bottomProportion - accWidth * 2.5f - cycleWidth)
      for (i in 0..2) {
        rQuadTo(width * waveWidthProportionC / 4f, -cycleWidth, width * waveWidthProportionC / 2f, 0f)
        rQuadTo(width * waveWidthProportionC / 4f, cycleWidth, width * waveWidthProportionC / 2f, 0f)
      }
      lineTo(width * waveWidthProportionC, height * topProportion)
      lineTo(0f, height * topProportion)
      close()
      fillType = Path.FillType.WINDING
    }
    return pathC
  }
}
```
