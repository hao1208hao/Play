# Play
一些常用的工具类

定位使用
```ojbc
    添加定位文件的引用
    //开启定位
    [[QDBLocation sharedinstance] startLocationMonitor];
```

常用一些获取信息定义成宏的形式使用
```objc
  例如：sysVersion --获取系统版本
        deviceID  -- 手机设备唯一标识
        deviceModel --手机类型
        QDBNetUseFul --网络是否可用
        QDBNetType --网络连接类型
        QDBGetLocation --地理位置字符串
        QDBGetLongitude  --经度
        QDBGetLatitude --纬度
        QDBMD5(str)  --MD5 字符
        QDBGetImgByColor(color)  --通过颜色生成一张图片
```
