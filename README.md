# RongCallVibrate


1. 请根据 APP 工程的 `Bundle ID` 生成 `APNS` 推送证书.

2. 如果需要获取32位的 token 进行推送调试, 请在 AppDelegate.m 如下方法中直接打断点, 查看 deviceToken 的内容. 请勿将 deviceToken 转换为 NSString, 这是错误的做法.

```
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
```
断点获取到的内容如下:

```
<bb859d75 cae5b2b2 fbc4dea8 6bf7f267 9e613ca5 eefccb01 1c1ebcd7 eee6ba5d>
```

32位的 token 为, 去除两端的尖括号和中间空格后的内容, 如下:

```
bb859d75cae5b2b2fbc4dea86bf7f2679e613ca5eefccb011c1ebcd7eee6ba5d
```


3. 在源码中搜索如下内容, 重要的点都在这些地方

```
<要点>
```


4. 推送的负载如下所示, 但必须包含 `"mutable-content":1` 否则无法调试 `Notification Service Extension`, 如下:

```
{
  "aps" : {
    "alert" : {
      "title" : "",
      "body" : "Your message Here"
    },
    "sound" : "default",
    "mutable-content":1
  }
}
```

5. 在工程的 App target 中添加如下内容:

```	
添加 Background Modes, 且选中 Remote notifications
添加 Push Notification
```


6. 在 Extension target 中添加如下内容:

```	
添加 Push Notification
```



### 可能存在接收不到推送的情况

1. deviceToken 会过期, 请检查是否与使用的一致;
2. 两个 target 中未添加 `Push Notification`;
3. 源码中缺少 <要点> 提示的内容;
4. 推送负载中缺少 `"mutable-content":1`
