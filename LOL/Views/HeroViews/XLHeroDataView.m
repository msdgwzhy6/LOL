//
//  XLHeroDataView.m
//  LOL
//
//  Created by lanou3g on 14-7-23.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLHeroDataView.h"

@implementation XLHeroDataView



- (instancetype)initWithNumber:(NSInteger )number
{
    if (self = [super init]) {
        
    
    UILabel *label = [[UILabel alloc]initWithFrame:CM(10, 5, 30, 20)];
        label.backgroundColor = GreenColor;
    label.text = @"1";
    label.tag = 100;
    [self addSubview:label];
    UISlider *slider = [[UISlider alloc]initWithFrame:CM(20, 35, 200, 20)];
    slider.backgroundColor = GrayColor;
    slider.minimumValue = 1;
    slider.maximumValue = 18;
    [slider addTarget:self action:@selector(slider:) forControlEvents:UIControlEventValueChanged];
    
    
    [self addSubview:slider];
    }
    return self;
}


- (void)slider:(UISlider *)slider
{
    UILabel *label = (UILabel *)[self viewWithTag:100];
    label.text = [NSString stringWithFormat:@"%f",slider.value];
}

@end
