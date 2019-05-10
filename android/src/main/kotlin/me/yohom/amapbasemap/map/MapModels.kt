package me.yohom.amapbasemap.map

import android.graphics.Color
import com.amap.api.maps.AMap
import com.amap.api.maps.AMapOptions
import com.amap.api.maps.CameraUpdateFactory
import com.amap.api.maps.model.*
import me.yohom.amapbasemap.common.hexStringToColorInt
import java.util.*


/**
 * 由于高德的AMapOption被混淆了, 无法通过Gson直接反序列化, 这里用这个类过渡一下
 * [CameraPosition]和[LatLng]没有被混淆, 所以可以直接使用
 * 另外这个类和ios端的做一个统一
 */
class UnifiedAMapOptions(
        /// “高德地图”Logo的位置
        private val logoPosition: Int = AMapOptions.LOGO_POSITION_BOTTOM_LEFT,
        private val zOrderOnTop: Boolean = false,
        /// 地图模式
        private val mapType: Int = AMap.MAP_TYPE_NORMAL,
        /// 地图初始化时的地图状态， 默认地图中心点为北京天安门，缩放级别为 10.0f。
        private val camera: CameraPosition? = null,
        /// 比例尺功能是否可用
        private val scaleControlsEnabled: Boolean = false,
        /// 地图是否允许缩放
        private val zoomControlsEnabled: Boolean = true,
        /// 指南针是否可用。
        private val compassEnabled: Boolean = false,
        /// 拖动手势是否可用
        private val scrollGesturesEnabled: Boolean = true,
        /// 缩放手势是否可用
        private val zoomGesturesEnabled: Boolean = true,
        /// 地图倾斜手势（显示3D效果）是否可用
        private val tiltGesturesEnabled: Boolean = true,
        /// 地图旋转手势是否可用
        private val rotateGesturesEnabled: Boolean = true
) {
    fun toAMapOption(): AMapOptions {
        return AMapOptions()
                .logoPosition(logoPosition)
                .zOrderOnTop(zOrderOnTop)
                .mapType(mapType)
                .camera(camera)
                .scaleControlsEnabled(scaleControlsEnabled)
                .zoomControlsEnabled(zoomControlsEnabled)
                .compassEnabled(compassEnabled)
                .scrollGesturesEnabled(scrollGesturesEnabled)
                .zoomGesturesEnabled(zoomGesturesEnabled)
                .tiltGesturesEnabled(tiltGesturesEnabled)
                .rotateGesturesEnabled(rotateGesturesEnabled)
    }
}


class UnifiedMarkerOptions(
        /// Marker覆盖物的图标
        private val icon: String?,
        /// Marker覆盖物的动画帧图标列表，动画的描点和大小以第一帧为准，建议图片大小保持一致
        private val icons: List<String>,
        /// Marker覆盖物的透明度
        private val alpha: Float,
        /// Marker覆盖物锚点在水平范围的比例
        private val anchorU: Float,
        /// Marker覆盖物锚点垂直范围的比例
        private val anchorV: Float,
        /// Marker覆盖物是否可拖拽
        private val draggable: Boolean,
        /// Marker覆盖物的InfoWindow是否允许显示, 可以通过 MarkerOptions.infoWindowEnable(kotlin.Booleanean) 进行设置
        private val infoWindowEnable: Boolean,
        /// 设置多少帧刷新一次图片资源，Marker动画的间隔时间，值越小动画越快
        private val period: Int,
        /// Marker覆盖物的位置坐标
        private val position: LatLng,
        /// Marker覆盖物的图片旋转角度，从正北开始，逆时针计算
        private val rotateAngle: Float,
        /// Marker覆盖物是否平贴地图
        private val isFlat: Boolean,
        /// Marker覆盖物的坐标是否是Gps，默认为false
        private val isGps: Boolean,
        /// Marker覆盖物的水平偏移距离
        private val infoWindowOffsetX: Int,
        /// Marker覆盖物的垂直偏移距离
        private val infoWindowOffsetY: Int,
        /// 设置 Marker覆盖物的 文字描述
        private val snippet: String,
        /// Marker覆盖物 的标题
        private val title: String,
        /// Marker覆盖物是否可见
        private val visible: Boolean,
        /// todo 缺少文档
        private val autoOverturnInfoWindow: Boolean,
        /// Marker覆盖物 zIndex
        private val zIndex: Float,
        /// 显示等级 缺少文档
        private val displayLevel: Int,
        /// 是否在掩层下 缺少文档
        private val belowMaskLayer: Boolean
) {
    constructor(options: MarkerOptions) : this(
            icon = options.icon.toString(),
            icons = options.icons.map { it.toString() },
            alpha = options.alpha,
            anchorU = options.anchorU,
            anchorV = options.anchorV,
            draggable = options.isDraggable,
            infoWindowEnable = options.isInfoWindowEnable,
            period = options.period,
            position = options.position,
            rotateAngle = options.rotateAngle,
            isFlat = options.isFlat,
            isGps = options.isGps,
            infoWindowOffsetX = options.infoWindowOffsetX,
            infoWindowOffsetY = options.infoWindowOffsetY,
            snippet = options.snippet,
            title = options.title,
            visible = options.isVisible,
            autoOverturnInfoWindow = options.isInfoWindowAutoOverturn,
            zIndex = options.zIndex,
            displayLevel = options.displayLevel,
            belowMaskLayer = options.isBelowMaskLayer
    )

    fun applyTo(map: AMap) {
        map.addMarker(toMarkerOption())

        map.animateCamera(CameraUpdateFactory.newLatLngBounds(LatLngBounds.builder().include(position).build(), 100))
    }

    fun toMarkerOption(): MarkerOptions = MarkerOptions()
            .alpha(alpha)
            .anchor(anchorU, anchorV)
            .draggable(draggable)
            .infoWindowEnable(infoWindowEnable)
            .period(period)
            .position(position)
            .rotateAngle(rotateAngle)
            .setFlat(isFlat)
            .setGps(isGps)
            .setInfoWindowOffset(infoWindowOffsetX, infoWindowOffsetY)
            .snippet(snippet)
            .title(title)
            .visible(visible)
            .autoOverturnInfoWindow(autoOverturnInfoWindow)
            .zIndex(zIndex)
            .displayLevel(displayLevel)
            .belowMaskLayer(belowMaskLayer)
            .apply {
                if (this@UnifiedMarkerOptions.icon != null) {
                    icon(UnifiedAssets.getBitmapDescriptor(this@UnifiedMarkerOptions.icon))
                } else {
                    icon(UnifiedAssets.getDefaultBitmapDescriptor("images/default_marker.png"))
                }

                if (this@UnifiedMarkerOptions.icons.isNotEmpty()) {
                    icons(ArrayList(this@UnifiedMarkerOptions.icons.map { UnifiedAssets.getBitmapDescriptor(it) }))
                }
            }
}


class UnifiedMyLocationStyle(
        // todo 实现自定义的图标
        /// 当前位置的图标
        private val myLocationIcon: String,
        /// 锚点横坐标方向的偏移量
        private val anchorU: Float,
        /// 锚点纵坐标方向的偏移量
        private val anchorV: Float,
        /// 圆形区域（以定位位置为圆心，定位半径的圆形区域）的填充颜色值
        private val radiusFillColor: String,
        /// 圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的颜色值
        private val strokeColor: String,
        /// 圆形区域（以定位位置为圆心，定位半径的圆形区域）边框的宽度
        private val strokeWidth: Float,
        /// 我的位置展示模式
        private val myLocationType: Int,
        /// 定位请求时间间隔
        private val interval: Long,
        /// 是否显示定位小蓝点
        private val showMyLocation: Boolean
) {
    fun applyTo(map: AMap) {
        map.isMyLocationEnabled = showMyLocation
        map.myLocationStyle = MyLocationStyle()
//                .myLocationIcon(BitmapDescriptorFactory.fromAsset(myLocationIcon))
                .anchor(anchorU, anchorV)
                .radiusFillColor(radiusFillColor.hexStringToColorInt()
                        ?: Color.argb(100, 0, 0, 180))
                .strokeColor(strokeColor.hexStringToColorInt() ?: Color.argb(255, 0, 0, 220))
                .strokeWidth(strokeWidth)
                .myLocationType(myLocationType)
                .interval(interval)
                .showMyLocation(showMyLocation)
    }

}

class UnifiedPolylineOptions(
        /// 顶点
        private val latLngList: List<LatLng>,
        /// 线段的宽度
        private val width: Double,
        /// 线段的颜色
        private val color: String,
        /// 线段的Z轴值
        private val zIndex: Double,
        /// 线段的可见属性
        private val isVisible: Boolean,
        /// 线段是否画虚线，默认为false，画实线
        private val isDottedLine: Boolean,
        /// 线段是否为大地曲线，默认false，不画大地曲线
        private val isGeodesic: Boolean,
        /// 虚线形状
        private val dottedLineType: Int,
        /// Polyline尾部形状
        private val lineCapType: Int,
        /// Polyline连接处形状
        private val lineJoIntype: Int,
        /// 线段是否使用渐变色
        private val isUseGradient: Boolean,
        /// 线段是否使用纹理贴图
        private val isUseTexture: Boolean
) {

    fun applyTo(map: AMap) {
        map.addPolyline(PolylineOptions().apply {
            addAll(this@UnifiedPolylineOptions.latLngList)
            width(this@UnifiedPolylineOptions.width.toFloat())
            color(this@UnifiedPolylineOptions.color.hexStringToColorInt() ?: Color.BLACK)
            zIndex(this@UnifiedPolylineOptions.zIndex.toFloat())
            visible(this@UnifiedPolylineOptions.isVisible)
            isDottedLine = this@UnifiedPolylineOptions.isDottedLine
            geodesic(this@UnifiedPolylineOptions.isGeodesic)
            dottedLineType = this@UnifiedPolylineOptions.dottedLineType
            lineCapType(when (this@UnifiedPolylineOptions.lineCapType) {
                0 -> PolylineOptions.LineCapType.LineCapButt
                1 -> PolylineOptions.LineCapType.LineCapSquare
                2 -> PolylineOptions.LineCapType.LineCapArrow
                3 -> PolylineOptions.LineCapType.LineCapRound
                else -> PolylineOptions.LineCapType.LineCapButt
            })
            lineJoinType(when (this@UnifiedPolylineOptions.lineJoIntype) {
                0 -> PolylineOptions.LineJoinType.LineJoinBevel
                1 -> PolylineOptions.LineJoinType.LineJoinMiter
                2 -> PolylineOptions.LineJoinType.LineJoinRound
                else -> PolylineOptions.LineJoinType.LineJoinBevel
            })
            useGradient(this@UnifiedPolylineOptions.isUseGradient)
            isUseTexture = this@UnifiedPolylineOptions.isUseTexture
        })
    }

}

class UnifiedUiSettings(
        /// 是否允许显示缩放按钮
        private val isZoomControlsEnabled: Boolean,
        /// 设置缩放按钮的位置
        private val zoomPosition: Int,
        /// 指南针
        private val isCompassEnabled: Boolean,
        /// 定位按钮
        private val isMyLocationButtonEnabled: Boolean,
        /// 比例尺控件
        private val isScaleControlsEnabled: Boolean,
        /// 地图Logo
        private val logoPosition: Int,
        /// 缩放手势
        private val isZoomGesturesEnabled: Boolean,
        /// 滑动手势
        private val isScrollGesturesEnabled: Boolean,
        /// 旋转手势
        private val isRotateGesturesEnabled: Boolean,
        /// 倾斜手势
        private val isTiltGesturesEnabled: Boolean
) {
    fun applyTo(map: AMap) {
        map.uiSettings.run {
            isZoomControlsEnabled = this@UnifiedUiSettings.isZoomControlsEnabled
            zoomPosition = this@UnifiedUiSettings.zoomPosition
            isCompassEnabled = this@UnifiedUiSettings.isCompassEnabled
            isMyLocationButtonEnabled = this@UnifiedUiSettings.isMyLocationButtonEnabled
            // 需要设置一下我的位置使能, 不然按按钮没反应
            map.isMyLocationEnabled = true
            isScaleControlsEnabled = this@UnifiedUiSettings.isScaleControlsEnabled
            logoPosition = this@UnifiedUiSettings.logoPosition
            isZoomGesturesEnabled = this@UnifiedUiSettings.isZoomGesturesEnabled
            isScrollGesturesEnabled = this@UnifiedUiSettings.isScrollGesturesEnabled
            isRotateGesturesEnabled = this@UnifiedUiSettings.isRotateGesturesEnabled
            isTiltGesturesEnabled = this@UnifiedUiSettings.isTiltGesturesEnabled
        }
    }
}

class UnifiedPolygonOptions(
        private val points: List<LatLng>,
        private val strokeWidth: Float,
        private val strokeColor: String,
        private val fillColor: String,
        private val zIndex: Float,
        private val visible: Boolean,
        private val holeOptions: List<BaseHoleOptions>
) {
    fun applyTo(map: AMap) {
        val options = PolygonOptions()
        options.addAll(points)
        options.addHoles(holeOptions)
        options.strokeWidth(strokeWidth)
        options.fillColor(fillColor.hexStringToColorInt()!!)
        options.zIndex(zIndex)
        options.strokeColor(strokeColor.hexStringToColorInt()!!)
        options.visible(visible)
        map.addPolygon(options)
    }
}