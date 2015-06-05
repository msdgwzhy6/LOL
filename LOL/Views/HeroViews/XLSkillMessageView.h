//
//  XLSkillMessageView.h
//  LOL
//
//  Created by lanou3g on 14-7-23.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLSkillMessageView : UIView

- (id)initWithFrame:(CGRect)frame
                dic:(NSDictionary *)dic
        skillNumber:(NSInteger )skillNumber
  descriptionHeight:(CGFloat )descriHeight
       effectHeight:(CGFloat )effectHeight;

@end
