//
//  ApprovalView.m
//  ApprovalDemo
//
//  Created by xinping-imac-1 on 16/8/19.
//  Copyright © 2016年 libaozi. All rights reserved.
//

#import "ApprovalView.h"

@implementation ApprovalView
@synthesize firstImgView,firstLab;
@synthesize row_x,cloumn_y;
@synthesize positionX_Y;
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self initView];
       
    }
     return self;
}
-(void)initView{
    //审批人图片
    firstImgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    firstImgView.image=[UIImage imageNamed:@"application_approval_add"];
    firstImgView.layer.masksToBounds=YES;
    firstImgView.layer.cornerRadius=firstImgView.frame.size.width/2;
    [self addSubview:firstImgView];
    firstImgView.userInteractionEnabled=YES;
    
    //审批人名字
    firstLab=[[UILabel alloc]initWithFrame:CGRectMake(0,0, 50, 20)];
    firstLab.center=CGPointMake(firstImgView.frame.size.width/2, (firstImgView.frame.size.height+firstLab.frame.size.height/2));
    firstLab.textAlignment=NSTextAlignmentCenter;
    firstLab.backgroundColor=[UIColor clearColor];
    [self addSubview:firstLab];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
