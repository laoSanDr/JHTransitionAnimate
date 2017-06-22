# JHTransitionAnimate

自定义多种转场动画的封装使用

#### 效果图

![效果图](https://github.com/laoSanDr/JHTransitionAnimate/blob/master/动画效果.gif)
---
### 使用方法

>下载Demo，把`JHTransition`文件拖到工程里面
导入 `#import "JHTransition.h"`

```
self.navigationController.delegate = [JHTransition shareManager];
[JHTransition shareManager].animationType = JHAnimateTypeDiffNavi;
```
###### 只需要把navigationController的代理设置为WTKTransition的单例对象即可，animationType为动画类型，如下:
```
typedef NS_ENUM(NSInteger,JHAnimateType)
{
    JHAnimateTypeDefault = 0,
    /// 两个导航栏不一致
    JHAnimateTypeDiffNavi,
    ///仿酷狗
    JHAnimateTypeKuGou,
    ///圆形遮罩
    JHAnimateTypeRound,
    ///椭圆遮罩
    JHAnimateTypeOval,
    ///仿斗鱼
    JHAnimateTypeDouYu,
};
```

[简书地址](http://www.jianshu.com/p/dcce9d514a24)
