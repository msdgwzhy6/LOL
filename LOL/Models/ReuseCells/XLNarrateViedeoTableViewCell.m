//
//  XLNarrateViedeoTableViewCell.m
//  LOL
//
//  Created by lanou3g on 14-7-28.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLNarrateViedeoTableViewCell.h"

@implementation XLNarrateViedeoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
 
        self.narratImgView = [[UIImageView alloc]initWithFrame:CM(10, 5, 50, 50)];
        [self addSubview:_narratImgView];
        NSString *pathStr = [[NSBundle mainBundle]pathForResource:@"narraterBack_1" ofType:@".png"];
        UIImage *image = [UIImage imageWithContentsOfFile:pathStr];
        UIImageView *headBackView = [[UIImageView alloc]initWithImage:image];
        headBackView.frame = CM(7, 3, 56, 56);
        [self addSubview:headBackView];
        
        
        
        self.narratNameLabel = [[UILabel alloc]initWithFrame:CM(80, 15, 100, 30)];
        _narratNameLabel.font = [UIFont boldSystemFontOfSize:15];
        _narratNameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_narratNameLabel];
        
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"voidecountback.png"]];
        imageView.frame = CM(235, 15, 50, 30);
        [self addSubview:imageView];
        
        self.narratCountLabel = [[UILabel alloc]initWithFrame:CM(240, 20, 40, 20)];
        _narratCountLabel.textAlignment = NSTextAlignmentCenter;
        _narratCountLabel.font = Font(12);
       // _narratCountLabel.backgroundColor = GrayColor;
        [self addSubview:_narratCountLabel];
    
    
    
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
