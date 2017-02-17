//
//  BackView.m
//  LineShape
//
//  Created by wangtong on 2017/2/17.
//  Copyright © 2017年 wangtong. All rights reserved.
//

#define MainColor @"92b8c2"

#import "LineView.h"
#import "BackView.h"

@interface BackView ()

@property(nonatomic,strong)NSMutableArray *yArray;
@property(nonatomic,strong)NSMutableArray *xArray;


@end

@implementation BackView
{
    CGPoint startPiont;
    int startNum;
    LineView * lineV;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    _yArray = [NSMutableArray arrayWithObjects:@"10",@"8",@"4",@"0",@"-4",@"-8",@"-12", nil];
    _xArray = [NSMutableArray arrayWithObjects:@"-2",@"0",@"2",@"4",@"6",@"8",@"10",@"12", nil];
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        _yArray = [NSMutableArray arrayWithObjects:@"10",@"8",@"4",@"0",@"-4",@"-8",@"-12", nil];
        _xArray = [NSMutableArray arrayWithObjects:@"-2",@"0",@"2",@"4",@"6",@"8",@"10",@"12", nil];
    }
    return self;
    
}


- (void)drawRect:(CGRect)rect {
    
    CGFloat y_wideth = self.frame.size.height/8;
    CGFloat x_wideth = (self.frame.size.width - 20 - 20)/9;
    
    [self drawTextWithText:@"流速(L/S)" frame:CGRectMake(25, 0, 80, 20)];
    
    UIColor * viewColor = [UIColor blackColor];
    [viewColor set];
    
    // 创建path
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 0.5;
    // 添加路径[1条点(100,100)到点(200,100)的线段]到path
    [path moveToPoint:CGPointMake(20 , 0)];
    [path addLineToPoint:CGPointMake(20, self.frame.size.height)];
    // 将path绘制出来
    [path stroke];
    
    //画出Y轴刻度
    for (int i = 0; i < 7; i ++) {
        // 创建path
        UIBezierPath *perY = [UIBezierPath bezierPath];
        perY.lineWidth = 0.5;
        // 添加路径[1条点(100,100)到点(200,100)的线段]到path
        [perY moveToPoint:CGPointMake(20 , y_wideth * i + y_wideth)];
        [perY addLineToPoint:CGPointMake(15, y_wideth * i + y_wideth)];
        // 将path绘制出来
        [perY stroke];
        
        //标上对应的值
        [self drawTextWithText:_yArray[i] frame:CGRectMake(perY.currentPoint.x - 16, perY.currentPoint.y - 8, 16, 15) font:10 textColor:[UIColor blackColor] alagent:NSTextAlignmentRight];
    }
    
    //画出X轴直线
    // 创建path
    UIBezierPath *path_x = [UIBezierPath bezierPath];
    path_x.lineWidth = 0.5;
    [path_x moveToPoint:CGPointMake(20 ,y_wideth * 4)];
    [path_x addLineToPoint:CGPointMake(self.frame.size.width - 20, y_wideth * 4)];
    // 将path绘制出来
    [path_x stroke];
    
    //画出X轴刻度
    for (int i = 0; i < 8; i ++) {
        // 创建path
        UIBezierPath *perX = [UIBezierPath bezierPath];
        perX.lineWidth = 0.5;
        [perX moveToPoint:CGPointMake(20 + x_wideth * i + x_wideth , y_wideth * 4 - 5)];
        [perX addLineToPoint:CGPointMake(20 + x_wideth * i + x_wideth, y_wideth * 4 + 5)];
        // 将path绘制出来
        [perX stroke];
        
        //标上对应的值
        [self drawTextWithText:_xArray[i] frame:CGRectMake(perX.currentPoint.x - 6, perX.currentPoint.y, 16, 15) font:10 textColor:[UIColor blackColor] alagent:NSTextAlignmentLeft];
    }
    
    [self drawTextWithText:@"容积(L)" frame:CGRectMake(path_x.currentPoint.x - 30, path_x.currentPoint.y - 20, 60, 20)];
}

//标注文字
- (void)drawTextWithText:(NSString *)text frame:(CGRect)frame font:(CGFloat)font textColor:(UIColor *)color alagent:(NSTextAlignment)alagent{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = alagent;
    label.textColor = color;
    [self addSubview:label];
}


//标注文字
- (void)drawTextWithText:(NSString *)text frame:(CGRect)frame{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [text drawInRect:frame withAttributes:dict];
}

//所有数据绘制
- (void)sendAllData:(NSMutableArray *)allData{
    
    [lineV removeFromSuperview];
    lineV = nil;
    
    //添加划线的View
    lineV = [[LineView alloc] initWithFrame:CGRectMake(20, 0, self.frame.size.width - 20-20, self.frame.size.height)];
    lineV.backgroundColor = [UIColor clearColor];
    [self addSubview:lineV];
    
    [lineV sendLineAllData:allData];
}


@end
