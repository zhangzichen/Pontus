<<<<<<< HEAD

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


# Pontus

My own iOS development kit, written by Swift.
=======
# The CocoaPods Master Repo

This repository contains the public [CocoaPods](https://github.com/CocoaPods/CocoaPods) specifications.

## Links

- [Specs and the Specs Repo](http://guides.cocoapods.org/making/specs-and-specs-repo.html): Learn about creating Podspec's and the Spec repo.
- [Getting setup with Trunk](http://guides.cocoapods.org/making/getting-setup-with-trunk.html): Instructions for creating a CocoaPods user account


## License

These specifications and CocoaPods are available under the [MIT license](http://www.opensource.org/licenses/mit-license.php).


>>>>>>> 3a9f0f2ba2716a1e0a0974b628fa6f1a0f975843
