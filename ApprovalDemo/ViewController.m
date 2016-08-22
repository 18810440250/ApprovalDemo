//
//  ViewController.m
//  ApprovalDemo
//
//  Created by xinping-imac-1 on 16/8/19.
//  Copyright © 2016年 libaozi. All rights reserved.
//

#import "ViewController.h"
#import "ApprovalView.h"
@interface ViewController ()<UIAlertViewDelegate>
{
    ApprovalView *firstView;//原点
    NSMutableArray *allListAry;//总的数据数组
    UILongPressGestureRecognizer *firstLongPress;//原始点的长按
    ApprovalView *horizonView;//横向
    NSMutableArray *newArray;//横向数组
    
    ApprovalView *verticalView;//纵向
    NSMutableArray *newArray2;//纵向数组
    int point_x;//传值 x
    int point_y;//传值 y
    NSString *compareAddType;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     allListAry=[NSMutableArray array];//所有审批人的数组集合
    [self creatImageWithRow:1 withColumn:0 withAddType:@"addType"];//默认坐标为（1，0）后边默认参数值为addType
}

#pragma mark 添加数据
/**
 *  根据点击相应的imageview 添加数据
 *
 *  @param appView 每次点击的view
 *  @param sender  判断点击的是哪一个的手势
 */
-(void)calculateWithView:(ApprovalView *)appView WithGesture:(UIGestureRecognizer *)sender{
    newArray =[NSMutableArray array];
    newArray2 =[NSMutableArray array];
    if (appView.row_x == 1 && appView.cloumn_y == 0) {
        //创建数组，把每一行数据放到一个数组里面，然后放到整个数组里面
        //原点、横轴（+）
       
        [newArray addObject:@{@"x":@(appView.row_x),@"y":@(appView.cloumn_y),@"addType":@"string"}];
        [newArray addObject:@{@"x":@(appView.row_x),@"y":@(appView.cloumn_y+1),@"addType":@"addType"}];
        if (allListAry.count==0) {
            [allListAry addObject:@{[NSString stringWithFormat:@"%d",appView.row_x]:newArray}];
        }else{
            [allListAry replaceObjectAtIndex:appView.row_x-1 withObject:@{[NSString stringWithFormat:@"%d",appView.row_x]:newArray}];
        }
        
        //纵轴（+）
       
        [newArray2 addObject:@{@"x":@(allListAry.count+1),@"y":@(0),@"addType":@"addType"}];
        [allListAry addObject:@{[NSString stringWithFormat:@"%ld",allListAry.count+1]:newArray2}];
    }
    else if (appView.cloumn_y>0){
        NSDictionary *dict=allListAry[appView.row_x-1];
        NSString *key=dict.allKeys[0];
        NSMutableArray *arr=[NSMutableArray arrayWithArray:[dict objectForKey:key]];
        [arr removeLastObject];
        [arr addObject:@{@"x":@(appView.row_x),@"y":@(appView.cloumn_y),@"addType":@"string"}];
        [arr addObject:@{@"x":@(appView.row_x),@"y":@(appView.cloumn_y+1),@"addType":@"addType"}];
        [allListAry replaceObjectAtIndex:appView.row_x-1 withObject:@{[NSString stringWithFormat:@"%d",appView.row_x]:arr}];
    }else{
        //横轴（+）
        [newArray addObject:@{@"x":@(appView.row_x),@"y":@(appView.cloumn_y),@"addType":@"string"}];
        [newArray addObject:@{@"x":@(appView.row_x),@"y":@(appView.cloumn_y+1),@"addType":@"addType"}];
        [allListAry replaceObjectAtIndex:appView.row_x-1 withObject:@{[NSString stringWithFormat:@"%d",appView.row_x]:newArray}];
        
        //纵轴（+）
        [newArray2 addObject:@{@"x":@(allListAry.count+1),@"y":@(0),@"addType":@"addType"}];
        [allListAry addObject:@{[NSString stringWithFormat:@"%ld",allListAry.count+1]:newArray2}];
    }
}
#pragma mark 点击手势
-(void)tapAction:(UITapGestureRecognizer *)sender{
    ApprovalView *appView = (ApprovalView *)[sender view];
    
    
    NSString *addString;
    NSMutableArray *arr;
    NSMutableArray *arrY=[NSMutableArray array];//根据key值获取所有y值的数组
    for (int i=0; i<allListAry.count; i++) {
        NSDictionary *dic=allListAry[i];
        NSString *key=dic.allKeys[0];
        
        if ([key intValue] == appView.row_x) {
            
            arr = [NSMutableArray arrayWithArray:[dic objectForKey:key]];
            NSLog(@"arrY=%@",arr);
            
            for (int j=0; j<arr.count; j++) {
                NSMutableDictionary *dict_c=[NSMutableDictionary dictionaryWithDictionary:arr[j]];
                
                addString=arr.lastObject[@"addType"];
                [arrY addObject:dict_c[@"y"]];
            }
        }
    }
    if (arrY.count==0||([[NSString stringWithFormat:@"%d",appView.cloumn_y] isEqualToString:[NSString stringWithFormat:@"%@",arrY.lastObject]]&&[addString isEqualToString:@"addType"])) {
        //添加
        [self calculateWithView:appView WithGesture:sender];
        if (appView.row_x == 1 && appView.cloumn_y == 0) {//判断是原点时的操作，横竖向各加一个
            appView.firstImgView.image=nil;
            [self creatImageWithRow:appView.row_x + 1 withColumn:appView.cloumn_y withAddType:@"addType"];
            [self creatImageWithRow:appView.row_x withColumn:appView.cloumn_y + 1 withAddType:@"addType"];
        }
        else if (appView.cloumn_y > 0){//横向加1
            appView.firstImgView.image=nil;
            [self creatImageWithRow:appView.row_x withColumn:appView.cloumn_y + 1 withAddType:@"addType"];
        }
        else if (appView.cloumn_y == 0){//纵向加1
            appView.firstImgView.image=nil;
            
            [self creatImageWithRow:appView.row_x + 1 withColumn:appView.cloumn_y withAddType:@"addType"];
            [self creatImageWithRow:appView.row_x withColumn:appView.cloumn_y + 1 withAddType:@"addType"];
        }
    }
    else{//防止二次添加
        //在我自己的项目中，这里进行的是修改操作，当选中的审批人错误的时候再次点击可以进行修改；
        NSLog(@"修改");
    }
    
}
#pragma mark 长按删除手势
/**
 *  注意 长按手势方法会执行两次，要做判断
 *
 *  @param sender 长按手势
 */
-(void)longPressAction:(UILongPressGestureRecognizer *)sender{
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        ApprovalView *appView=(ApprovalView *)[sender view];
        NSMutableArray *arr;
        NSMutableArray *arrY=[NSMutableArray array];//根据key值获取所有y值的数组
        for (int i=0; i<allListAry.count; i++) {
            NSDictionary *dic=allListAry[i];
            NSString *key=dic.allKeys[0];
            
            if ([key intValue] == appView.row_x) {
                
                arr = [NSMutableArray arrayWithArray:[dic objectForKey:key]];
                NSLog(@"arrY=%@",arr);
                
                for (int j=0; j<arr.count; j++) {
                    NSMutableDictionary *dict_c=[NSMutableDictionary dictionaryWithDictionary:arr[j]];

                    compareAddType=arr.lastObject[@"addType"];
                    [arrY addObject:dict_c[@"y"]];
                }
            }
            
        }
        
        if ([[NSString stringWithFormat:@"%d",appView.cloumn_y] isEqualToString:[NSString stringWithFormat:@"%@",arrY.lastObject]]&&[compareAddType isEqualToString:@"addType"]) {
            return;
        }
        
        point_x=appView.row_x;
        point_y=appView.cloumn_y;
        
        UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
  
}
#pragma  mark 删除某个人
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        
        int flag = -1;
        BOOL deleteBack = NO;
        for (int i=0; i<allListAry.count; i++) {
            NSDictionary *dic=allListAry[i];
            NSString *key=dic.allKeys[0];
            
            BOOL rowDelete = NO;
            if ([key intValue] == point_x) {
                NSMutableArray *arr=[NSMutableArray arrayWithArray:[dic objectForKey:key]];
                NSLog(@"arr=%@",arr);
                BOOL mark = NO;
                for (int z=0; z<arr.count; z++) {
                    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:arr[z]];
                    int y = [dict[@"y"] intValue];
                    if (point_y == y) {
                        if (y==0) {//第一列
                            flag = i;
                            deleteBack = YES;
                        }
                         [arr removeObject:dict];
                        if (arr.count==0) {
                            rowDelete=YES;
                        }
                        mark = YES;
                         z--;
                        continue;
                    }
                    if (mark) {
                        NSString *addType=dict[@"addType"];
                        if (y-1==0&&[addType isEqualToString:@"addType"]) {
                            [arr removeObject:dict];
                        }else{
                            [dict setValue:@(y-1) forKey:@"y"];
                            [arr replaceObjectAtIndex:z withObject:dict];
                        }
                    }
                }
                if (arr.count>0) {
                    [allListAry replaceObjectAtIndex:i withObject:@{key:arr}];
                    continue;
                }
                
            }
            if (i>=flag && deleteBack) {
                [allListAry removeObjectAtIndex:i];
                i--;
            }
        }
        if (deleteBack) {
            NSMutableArray *array2=[NSMutableArray array];
            [array2 addObject:@{@"x":@(allListAry.count+1),@"y":@(0),@"addType":@"addType"}];
            [allListAry addObject:@{[NSString stringWithFormat:@"%ld",allListAry.count+1]:array2}];
        }
        
        [self afreshImageView];
    }
}

#pragma mark 删除后重绘视图
-(void)afreshImageView{
    for (UIView *view in [self.view subviews]) {
        [view removeFromSuperview];
    }
    for (int i=0; i<allListAry.count; i++) {
        NSDictionary *dict=allListAry[i];
        NSString *key=dict.allKeys[0];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:[dict objectForKey:key]];
        for (int c=0; c<arr.count; c++) {
            NSMutableDictionary *dict_c=[NSMutableDictionary dictionaryWithDictionary:arr[c]];
            NSString *addType=dict_c[@"addType"];
            NSString * y = [NSString stringWithFormat:@"%@",dict_c[@"y"]];
            NSString * x = [NSString stringWithFormat:@"%@",dict_c[@"x"]];
            [self creatImageWithRow:[x intValue] withColumn:[y intValue] withAddType:addType];
        }
    }
}

#pragma mark 根据坐标绘制UI
/**
 *  根据 x轴 y轴坐标绘制UI
 *
 *  @param x x 轴坐标
 *  @param y y 轴坐标
 */
-(void)creatImageWithRow:(int)x withColumn:(int)y withAddType:(NSString *)addType{
    if (x == 1 && y == 0) {
        //每一个审批人背景
        firstView=[[ApprovalView alloc]initWithFrame:CGRectMake(10, 40, 50, 70)];
        firstView.firstImgView.backgroundColor=[UIColor colorWithRed:arc4random()%256/256.0f green:arc4random()%256/256.0f blue:arc4random()%256/256.0f alpha:1];
        
        firstView.row_x=1;
        firstView.cloumn_y=0;
        
        firstView.positionX_Y=CGPointMake(firstView.row_x, firstView.cloumn_y);
        firstView.firstLab.text=[NSString stringWithFormat:@"%d,%d",x,y];
        
        [self.view addSubview:firstView];
        
        if ([addType isEqualToString:@"addType"]) {//allListAry.count==1||allListAry.count==0
            firstView.firstImgView.image=[UIImage imageNamed:@"application_approval_add"];
           
        }
        else{
            firstView.firstImgView.image=[UIImage imageNamed:@""];
        }
       
        UITapGestureRecognizer *firstTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [firstView addGestureRecognizer:firstTap];
        firstLongPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
        [firstView addGestureRecognizer:firstLongPress];
    }
    if (y > 0){//横向
        UIImageView *line1=[[UIImageView alloc]initWithFrame:CGRectMake(70*y+(y-1)*22, (x-1)*110+50/2-1+40, 22, 2)];
        line1.image=[UIImage imageNamed:@"application_approval_solid"];
        
        [self.view addSubview:line1];
        
        horizonView=[[ApprovalView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(line1.frame)+10, (x-1)*110+40, 50, 70)];
        
        horizonView.firstImgView.backgroundColor=[UIColor colorWithRed:arc4random()%256/256.0f green:arc4random()%256/256.0f blue:arc4random()%256/256.0f alpha:1];
        horizonView.hidden=NO;
        [self.view addSubview:horizonView];

        if ([addType isEqualToString:@"addType"]) {
            horizonView.firstImgView.image=[UIImage imageNamed:@"application_approval_add"];
        }else{
            horizonView.firstImgView.image=[UIImage imageNamed:@""];
        }
        horizonView.positionX_Y=CGPointMake(x, y);
        horizonView.row_x=x;
        horizonView.cloumn_y=y;
        horizonView.firstLab.text=[NSString stringWithFormat:@"%d,%d",x,y];
        
        horizonView.userInteractionEnabled=YES;
        
        UITapGestureRecognizer *tapGesR=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [horizonView addGestureRecognizer:tapGesR];
        UILongPressGestureRecognizer *longPressGesR=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
        [horizonView addGestureRecognizer:longPressGesR];
    }
    else if (x != 1 && y == 0){//纵向
        UIImageView * line2=[[UIImageView alloc]initWithFrame:CGRectMake(firstView.center.x, (x-1)*70+(x-2)*40+5+40,2,30)];
        line2.image=[UIImage imageNamed:@"application_approval_dotted"];
        
        [self.view addSubview:line2];
        
        verticalView=[[ApprovalView alloc]initWithFrame:CGRectMake(10,5+CGRectGetMaxY(line2.frame),50,70)];
        
         verticalView.firstImgView.backgroundColor=[UIColor colorWithRed:arc4random()%256/256.0f green:arc4random()%256/256.0f blue:arc4random()%256/256.0f alpha:1];
        [self.view addSubview:verticalView];

        verticalView.positionX_Y=CGPointMake(x, y);
        verticalView.row_x=x;
        verticalView.cloumn_y=y;
        verticalView.firstLab.text=[NSString stringWithFormat:@"%d,%d",x,y];
        verticalView.firstLab.font=[UIFont systemFontOfSize:14];
        
        verticalView.userInteractionEnabled=YES;
        if ([addType isEqualToString:@"addType"]) {
            verticalView.firstImgView.image=[UIImage imageNamed:@"application_approval_add"];
        }else{
            verticalView.firstImgView.image=[UIImage imageNamed:@""];
        }
        UITapGestureRecognizer *tapGesR2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [verticalView addGestureRecognizer:tapGesR2];
        UILongPressGestureRecognizer *longPressGesR2=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
        [verticalView addGestureRecognizer:longPressGesR2];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
