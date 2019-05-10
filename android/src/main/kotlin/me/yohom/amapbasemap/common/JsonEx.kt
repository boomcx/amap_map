package me.yohom.amapbasemap.common

import com.alibaba.fastjson.JSON
import com.alibaba.fastjson.TypeReference
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken

val gson: Gson = GsonBuilder().serializeNulls().create()

/**
 * 使用字段来解析json的方法
 */
inline fun <reified K> String.parseFieldJson(): K {
    return gson.fromJson(this, object : TypeToken<K>() {}.type)
}

/**
 * 使用字段来序列化json的方法
 */
fun Any.toFieldJson(): String {
    return gson.toJson(this)
}

/**
 * 使用Accessor来解析json的方法
 */
inline fun <reified K> String.parseAccessorJson(): K {
    return JSON.parseObject(this, object : TypeReference<K>() {}.type)
}

/**
 * 使用Accessor来序列化json的方法
 */
fun Any.toAccessorJson(): String {
    return JSON.toJSONString(this)
}