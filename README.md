# ApprovalDemo
有关审批人创建删除的demo，类似于钉钉当中审批人选择的那个功能，与钉钉选择审批人不同的是，钉钉是单级选择，这个demo是多级同时选择。
仅仅是个demo，仅供参考。

里面创建的时候背景色是随机的，下面的数字是坐标，默认坐标是（1，0），点击加号图标可以创建，可以横向创建、竖向创建；长按会删除。

实现过程：

根据坐标来创建imageview，长按删除。点击加号图标可横向纵向添加。删除后重新按照坐标重新绘制，颜色因为是随机色，所以会改变，这里无须担心。

纵向每多一行，添加一个数组。这里每一行都是一个可变数组array1,array2,array3...有一个总数组allArray。

总体数据是一个可变的二维数组allArray[array1,array2,array3...];

addType 是为了根据它来判断是不是添加按钮。

addType = @"addType"；则是添加按钮

addType = @"string"; 已经创建的人，不是添加按钮；

用它来判断是不是可以删除，如果是添加按钮，则不允许长按删除；不是添加按钮则可以长按删除。
