//
//  ApprovalView.h
//  ApprovalDemo
//
//  Created by xinping-imac-1 on 16/8/19.
//  Copyright © 2016年 libaozi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApprovalView : UIView
@property (nonatomic,strong) UIImageView *firstImgView;//图片
@property (nonatomic,strong) UILabel *firstLab;//显示名字的label
@property (nonatomic,assign) int row_x;//横坐标
@property (nonatomic,assign) int cloumn_y;//纵坐标
@property (nonatomic,assign) CGPoint positionX_Y;//坐标轴(x,y)
@end
