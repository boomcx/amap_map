# 高德地图Flutter插件 基于AndroidView和UiKitView

|      amap_base     | [![pub package](https://img.shields.io/pub/v/amap_base.svg)](https://pub.Flutter-io.cn/packages/amap_base)                   |
|:------------------:|:----------------------------------------------------------------------------------------------------------------------------:|
|    amap_base_map   | [![pub package](https://img.shields.io/pub/v/amap_base_map.svg)](https://pub.Flutter-io.cn/packages/amap_base_map)           |
| amap_base_location | [![pub package](https://img.shields.io/pub/v/amap_base_location.svg)](https://pub.Flutter-io.cn/packages/amap_base_location) |
|  amap_base_search  | [![pub package](https://img.shields.io/pub/v/amap_base_search.svg)](https://pub.Flutter-io.cn/packages/amap_base_search)     |
|   amap_base_navi   | [![pub package](https://img.shields.io/pub/v/amap_base_navi.svg)](https://pub.Flutter-io.cn/packages/amap_base_navi)         |

[TOC]

## 安装
在你的`pubspec.yaml`文件的dependencies节点下添加:
```
amap_base: x.x.x
amap_base_map: x.x.x # 仅地图
amap_base_navi: x.x.x # 仅导航(高德导航SDK已包含地图, 不要跟amap_base_map重复引用)
amap_base_search: x.x.x # 仅搜索
amap_base_location: x.x.x # 仅定位
```
如果你想要指定某个版本/分支/提交, 那么:
```
amap_base:
  git:
    url: https://github.com/yohom/amap_base_flutter.git
    ref: 0.0.1/branch/commit
```
**Android项目默认集成了androidx, 如果要使用android-support库的话, 使用android-support-library分支!**
使用方法:
```
amap_base:
    git:
      url: https://github.com/yohom/amap_base_flutter.git
      ref: android-support-library
      path: base(/map/location/search/navi)
```
导入:
```
import 'package:amap_base/amap_base.dart';
```
Android端设置key:
```
<application>
    ...
    <meta-data
        android:name="com.amap.api.v2.apikey"
        android:value="您的Key"/>
</application>
```
iOS端设置key:
```
await AMap.init('您的key'); // 这个方法在Android端无效
```
iOS端的`UiKitView`目前还只是preview状态, 默认是不支持的, 需要手动打开开关, 在info.plist文件中新增一行`io.flutter.embedded_views_preview`为`true`. 参考[iOS view embedding support has landed on master](https://github.com/Flutter/Flutter/issues/19030#issuecomment-437534853)

## 关于高德的Android SDK和iOS SDK
- 由于Android和iOS端的实现完全不一样, Android端照抄了Google Map的api设计, 而iOS
端又没有去抄Google Map的设计, 导致需要额外的工作去兼容两个平台的功能. 这个库的目标是尽可能的统一双端的api设置, 采用取各自平台api的**并集**, 然后在文档中指出针对哪个平台有效的策略来实现api统一.

## 关于包的大小
- 目前已经按照高德提供的各个子包, 分出了4个分支(2d地图没有支持计划).
    - `feature/map`分支依赖了高德3DMap库.
    - `feature/location`分支依赖了高德Location库.
    - `feature/navi`分支依赖了高德Navi库(Navi库包含了3DMap库, 不要重复引用Navi库和3DMap库!).
    - `feature/search`分支依赖了高德Search库.

## 关于Swift项目
- Swift项目需要注释掉Podfile中的`use_framework!`. 尝试了在podspec中添加`s.static_framework = true`, 但是会造成找不到pod里的头文件. 如果有更好的解决方案, 请告知我.

## 关于项目结构
项目结构按照高德官方的4个子包(不包括2D地图)组织. 分为`地图`, `定位`, `导航`, `搜索`四大块.

    |-- me.yohom.amapbase
        |-- `AMapBasePlugin`: Flutter插件类
        |-- `FunctionRegistry`: 功能登记处, 所有功能都需要在此处注册.
        |-- `IMapMethodHandler`: **处理委托对象**接口.
        |-- common: 通用代码
        |-- map: 地图功能模块
            |-- MapHandlers
            |-- MapModels: 数据模型
            |-- `AMapFactory`: AMapView工厂, Flutter的platform view需要
        |-- navi: 导航功能模块
            |-- NaviHandlers
            |-- NaviModels: 数据模型
        |-- search: 搜索功能模块
            |-- SearchHandlers
            |-- SearchModels: 数据模型
        |-- location: 定位功能模块
            |-- LocationHandlers
            |-- LocationModels: 数据模型

## FAQ:
1. 为什么定位到非洲去了?
- 实际上是定位在了经纬度(0, 0)的位置了, 那个位置大致在非洲西部的几内亚湾, 原因是key
设置错了, 建议检查一下key的设置.
2. 为什么Android端用Flutter运行后奔溃, 但是直接用Android SDK运行成功?
- 指定项目的编译选项`Additional arguments`增加`--target-platform android-arm`.从![screen shot 2018-12-06 at 09 36 20](https://user-images.githubusercontent.com/10418364/49555454-e9c19f00-f93a-11e8-928b-6c3780b81f20.png)这里打开选项对话框. `VS Code`[配置方式](https://github.com/yohom/amap_base_flutter/issues/34#issuecomment-447830264).

## TODO LIST:
* 地图
    * [x] 创建地图
        * [x] 显示地图
        * [x] 显示定位蓝点
        * [x] 显示室内地图
        * [x] 切换地图图层
        * [x] 使用离线地图
        * [x] 显示英文地图
        * [x] 自定义地图
    * [x] 与地图交互
        * [x] 控件交互
        * [x] 手势交互
        * [x] 调用方法交互
        * [x] 地图截屏功能
    * [ ] 在地图上绘制
        * [x] 绘制点标记
        * [x] 绘制折线
        * [ ] 绘制面
        * [ ] 轨迹纠偏
        * [ ] 点平滑移动
        * [ ] 绘制海量点图层
    * [x] 地图计算工具
        * [x] 坐标转换
        * [x] 距离/面积计算
        * [x] 距离测量
* 搜索
    * [ ] 获取地图数据
        * [x] 获取POI数据
        * [x] 获取地址描述数据
        * [ ] 获取行政区划数据
        * [ ] 获取公交数据
        * [ ] 获取天气数据
        * [ ] 获取业务数据（云图功能）
        * [ ] 获取交通态势信息
    * [ ] 出行线路规划
        * [x] 驾车出行路线规划
        * [ ] 步行出行路线规划
        * [ ] 公交出行路线规划
        * [ ] 骑行出行路线规划
        * [ ] 货车出行路线规划
* 导航
    * [x] 导航组件
        * [x] 使用导航组件
    * [ ] 出行路线规划
        * [ ] 驾车路线规划
        * [ ] 货车路线规划
        * [ ] 步行路线规划
        * [ ] 骑行路线规划
    * [ ] 在地图上导航
        * [ ] 实时导航
        * [ ] 模拟导航
        * [ ] 智能巡航
        * [ ] 传入外部GPS数据
        * [ ] 导航UI定制化
    * [ ] HUD导航模式
        * [ ] HUD导航
    * [ ] 获取导航数据
        * [ ] 导航数据
    * [ ] 语音播报
        * [ ] 语音合成
* 定位
    * [x] 获取位置
        * [x] 获取定位数据
    * [ ] 辅助功能
        * [ ] 地理围栏
        * [ ] 坐标转换与位置判断