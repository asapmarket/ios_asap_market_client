## 应用介绍
本软件提供一套完整的外卖餐饮、私人订制服务解决方案，充分满足客户随时随地可以享受优质服务的需求。为了给客户带来更清晰、更高品质的服务，本软件分两端：外卖端和快递端，外卖端为客户提供了浏览到下单到购买一条龙服务功能，快递端提供了浏览客户订单、接单、配送、收款等功能。   

## 使用指南   
### 前置条件   
构建本软件需要安装以下环境   
xcode、iOS 8.0以上系统

### 安装   
##### 安装xcode   
1、macBook 在 appStore下载安装xcode   
### 如何运行   
##### 打开工程文件目录   
点击后缀名.xcworkspace文件运行工程
设备在开发者账号配置udid，选择真机直接运行（comand+R），也可先用各种iPhone设备模拟器运行
## 编码介绍  
使用object c编码， 支持iOS8.0以上系统
##### 界面设计   
整体界面风格采用google material design设计风格，扁平化设计，更符合系统原生生态要求  
架构使用原生自定义封装设计，碎片化处理   
WTabBarController是工程主界面类，UIViewControllerExt、UITableViewControllerExt是工程基类，以及一些通用的方法在该类实现   
##### 网络请求   
本软件使用AHNetwork开源库处理网络请求   
WHttpTool-工程网络请求基类类，数据处理为各个tab页server类，本软件所有网络请求均在该类中实现   
success:(void (^)(id json))success 
failure:(void (^)(NSError *error))failure   

##### 数据总线处理   
本软件使用观察者模式，满足应用中数据通信需求   
##### 图片处理   
本软件使用SDWebImage加载图片，自动缓存及内存管理

## 关于作者   
TODO 此处关于作者
## 授权协议  
TODO 此处授权协议

