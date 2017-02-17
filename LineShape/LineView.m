//
//  LineView.m
//  LineShape
//
//  Created by wangtong on 2017/2/17.
//  Copyright © 2017年 wangtong. All rights reserved.
//

#import "LineView.h"
#import "DataModel.h"
@interface LineView ()

@property(nonatomic,strong)NSMutableArray * dataSocure;
@property(nonatomic,strong)NSMutableArray * allData;

@end

@implementation LineView
{
    CGPoint startPiont;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        _dataSocure = [NSMutableArray array];
    }
    return self;
}


- (void)drawRect:(CGRect)rect{
    
    //多个画点画的时候，不可清空前面的绘制
    if (_allData.count > 0) {
        for (int j = 0; j < _allData.count; j++) {
            CGFloat x_with = self.frame.size.width/9;
            //起点，不可为空
            startPiont = CGPointMake(x_with * 2, self.frame.size.height/2);
            
            CGContextRef ctx1 = UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(ctx1, 0.5);//线宽
            if (j == 0) {
                CGContextSetStrokeColorWithColor(ctx1,[UIColor greenColor].CGColor);
            }else{
                CGContextSetStrokeColorWithColor(ctx1,[UIColor redColor].CGColor);
            }
            
            if ([_allData[j] count] > 0) {
                for (int k = 0;k < [_allData[j] count];k++) {
                    DataModel * model = _allData[j][k];
                    [self drawWithEndPoint:CGPointMake([self actValueToXview:[model.xSite floatValue]],[self actValueToYview:[model.ySite floatValue]]) context:ctx1];
                }
            }
            CGContextStrokePath(ctx1);
        }
    }
}


//所有数据的传送,所有的数据
- (void)sendLineAllData:(NSMutableArray *)allData{
    _allData = allData;
    [self setNeedsDisplay];
}

//画折线图
- (void)drawWithEndPoint:(CGPoint)endPoint context:(CGContextRef)context{
    CGContextMoveToPoint(context, startPiont.x, startPiont.y);
    CGContextAddLineToPoint(context, endPoint.x,endPoint.y);
    startPiont = endPoint;
}

//坐标转换成坐标轴上面的坐标
//X轴坐标转换
- (CGFloat)actValueToXview:(CGFloat)actValue{
    CGFloat x_with = self.frame.size.width/9;
    CGFloat changeX = actValue;
    //Y轴坐标原点未20 + Y每格的距离乘以3
    //X轴上的坐标只需要判断是否大于0
    if (changeX > 0) {
        CGFloat tempX = x_with * 2 + (changeX/2) * x_with;
        return tempX;
    }else if (changeX < 0){
        CGFloat lineLong = x_with *2  - (fabs(changeX))/2 * x_with;
        return lineLong;
    }else{
        return  x_with * 2;
    }
}

//Y轴坐标转换
- (CGFloat)actValueToYview:(CGFloat)actValue{
    CGFloat y_wideth = self.frame.size.height/8;
    //a数值介于0~8之间的，坐标轴距离按每格4来算
    if (actValue > 0 && actValue < 8) {
        CGFloat lineHeight = actValue/4;
        return (y_wideth * 2) + (y_wideth * 2 - lineHeight * y_wideth);
    }else if (actValue >= 8 && actValue < 10){    //数值介于8~10的,坐标轴距离按照每格2来算
        CGFloat overEight = ((actValue - 8)/2) * y_wideth;
        CGFloat allHeight = y_wideth * 2 + overEight;
        return y_wideth * 4 - allHeight;
    }else{//小于0的进行如下判断刻度均按照4来计算
        CGFloat actL = (fabs(actValue)/4) * y_wideth;
        return self.frame.size.height/2 + actL;
    }
}


@end
