//
//  XLHeroDetailTableViewCell.h
//  LOL
//
//  Created by lanou3g on 14-7-24.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLHeroDetailObject;
@interface XLHeroDetailTableViewCell : UITableViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier skillNumber:(NSInteger)skillNumber b:(CGFloat )b qd:(CGFloat )qd qe:(CGFloat )qe wd:(CGFloat)wd we:(CGFloat)we ed:(CGFloat)ed ee:(CGFloat)ee rd:(CGFloat)rd re:(CGFloat)re object:(XLHeroDetailObject *)_heroDetail;

@end
