
#简介
Pontus 是我使用 Swift 开发 iOS 应用一年下来所积累的一个工具库（当然其中深得之前共事同事的长处），这篇文章中我会简单说明一下自己是如何设计并使用 Pontus 的。

Pontus 的名字取自希腊神话名，比较喜欢他的蕴意：深不可测的大海，所以就叫这个名字了。
#Tips
    ·Pontus使用Swift编写，仅支持iOS平台
    ·可以使用CocoaPods将Pontus集成进自己的项目（PS：pod search Pontus）

###链式语法
Pontus中很多方法都是为了实现链式语法，或者带有链式语法的特性
非链式语法：
            object.propertyA = valueA
            object.propertyB = valueB
            object.propertyC = valueC
            object.propertyD = valueD
链式语法：
            object
                .propertyA(valueA)
                .propertyB(valueB)
                .propertyC(valueC)
                .propertyD(valueD)
效果图：
/Users/chuanliankeji/Library/Containers/com.tencent.qq/Data/Library/Application Support/QQ/Users/2714835741/QQ/Temp.db/A3B4214F-3D1E-4303-8FF1-9C8D9BA1106B.png

我这样作的主要原因有：
    ·不喜欢在设置 object 的若干属性时每次都要多写一个 object
    ·可以在 map 等函数中设置属性的同时返回结果
这种方法基本实现：
            extension Class {
                //  Chainable method of property
                func property(property: propertyType) -> Self {
                    self.property = property
                    return self
                }
            }
#Pontus详细介绍
/Users/chuanliankeji/Library/Containers/com.tencent.qq/Data/Library/Application Support/QQ/Users/1015947235/QQ/Temp.db/10EED9B7-5506-4D22-8922-6E0AFAEAB21D.png
Halo 的名字取自一款叫做 HALO 的游戏。我比较喜欢这款游戏宏大的背景，所以就叫做这个名字了
# Pontus
My own iOS development kit, written by Swift.
