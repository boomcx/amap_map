package me.yohom.amapbasemap

import com.amap.api.maps.AMap
import io.flutter.plugin.common.MethodChannel

interface SearchMethodHandler : MethodChannel.MethodCallHandler

interface MapMethodHandler: MethodChannel.MethodCallHandler {
    fun with(map: AMap): MapMethodHandler
}

interface NaviMethodHandler: MethodChannel.MethodCallHandler

interface LocationMethodHandler: MethodChannel.MethodCallHandler