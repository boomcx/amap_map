package me.yohom.amapbasemap.common

import android.util.Log
import me.yohom.amapbasemap.BuildConfig

fun Any.log(content: String) {
    if (BuildConfig.DEBUG) {
        Log.d(this::class.simpleName, content)
    }
}