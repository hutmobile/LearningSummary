import kotlin.concurrent.thread

fun main(args: Array<String>) {
    timer(10*1000){
        println("ten min")
    }
}

fun timer(nextTime: Long = 0L, block: () -> Unit): SimpleTimer {
    val timer = SimpleTimer(nextTime, block)
    timer.start()
    return timer
}

class SimpleTimer(private var nextTime: Long, private var block: () -> Unit) {

    private var time = nextTime
    private var isCancel = false
    private var isStop = false
    private var isPause = false

    fun cancel() {
        isCancel = true
    }

    fun setTime(time: Long) {
        this.time = time
        if (!isStop) {
            synchronized(nextTime) {
                nextTime = time
            }
        }
    }

    fun start() {
        isCancel = false
        isStop = false
        isPause = false
        nextTime = time
        thread {
            while (true) {
                if (isCancel) break
                if (nextTime <= 0) {
                    block.invoke()
                    isStop = true
                    break
                }
                val next = 1000L
                Thread.sleep(next)
                nextTime -= next
            }
        }
    }
}