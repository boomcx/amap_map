package me.yohom.amapbasemap.common

import android.graphics.Color

fun String.hexStringToColorInt(): Int? {
    return try {
        val alpha = substring(0, 2).toInt(16)
        val red = substring(2, 4).toInt(16)
        val green = substring(4, 6).toInt(16)
        val blue = substring(6, 8).toInt(16)
        Color.argb(alpha, red, green, blue)
    } catch (e: Exception) {
        null
    }
}

fun Int.toAMapError(): String {
    when (this) {
        1000 -> return "请求正常"
        1001 -> return "开发者签名未通过"
        1002 -> return "用户Key不正确或过期"
        1003 -> return "没有权限使用相应的接口"
        1008 -> return "MD5安全码未通过验证"
        1009 -> return "请求Key与绑定平台不符"
        1012 -> return "权限不足，服务请求被拒绝"
        1013 -> return "该Key被删除"
        1100 -> return "引擎服务响应错误"
        1101 -> return "引擎返回数据异常"
        1102 -> return "高德服务端请求链接超时"
        1103 -> return "读取服务结果返回超时"
        1200 -> return "请求参数非法"
        1201 -> return "请求条件中，缺少必填参数"
        1202 -> return "服务请求协议非法"
        1203 -> return "服务端未知错误"
        1800 -> return "服务端新增错误"
        1801 -> return "协议解析错误"
        1802 -> return "socket 连接超时 - SocketTimeoutException"
        1803 -> return "url异常 - MalformedURLException"
        1804 -> return "未知主机 - UnKnowHostException"
        1806 -> return "http或socket连接失败 - ConnectionException"
        1900 -> return "未知错误"
        1901 -> return "参数无效"
        1902 -> return "IO 操作异常 - IOException"
        1903 -> return "空指针异常 - NullPointException"
        2000 -> return "Tableid格式不正确"
        2001 -> return "数据ID不存在"
        2002 -> return "云检索服务器维护中"
        2003 -> return "Key对应的tableID不存在"
        2100 -> return "找不到对应的userid信息"
        2101 -> return "App Key未开通“附近”功能"
        2200 -> return "在开启自动上传功能的同时对表进行清除或者开启单点上传的功能"
        2201 -> return "USERID非法"
        2202 -> return "NearbyInfo对象为空"
        2203 -> return "两次单次上传的间隔低于7秒"
        2204 -> return "Point为空，或与前次上传的相同"
        3000 -> return "规划点（包括起点、终点、途经点）不在中国陆地范围内"
        3001 -> return "规划点（包括起点、终点、途经点）附近搜不到路"
        3002 -> return "路线计算失败，通常是由于道路连通关系导致"
        3003 -> return "步行算路起点、终点距离过长导致算路失败。"
        4000 -> return "短串分享认证失败"
        4001 -> return "短串请求失败"
        else -> return "无法识别的代码"
    }
}

