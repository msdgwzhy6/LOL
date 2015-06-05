//
//  XLVideoTableViewCell.m
//  LOL
//
//  Created by lanou3g on 14-7-24.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLVideoTableViewCell.h"

@implementation XLVideoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.titleImageView = [[UIImageView alloc]initWithFrame:CM(10, 5, 80, 50)];
        [self addSubview:_titleImageView];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CM(100, 5, 210, 40)];
        _titleLabel.numberOfLines = 2;
       // _titleLabel.backgroundColor = RedColor;
        _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _titleLabel.font = Font(13);
        [self addSubview:_titleLabel];
        
        self.postLabel = [[UILabel alloc]initWithFrame:CM(110, 45, 140, 10)];
        _postLabel.font = Font(10);
      //  _postLabel.backgroundColor = OrangeColor;
      //  [self addSubview:_postLabel];
        
        self.timeLegthLabel = [[UILabel alloc]initWithFrame:CM(230, 45, 80, 10)];
        _timeLegthLabel.font = Font(11);
        _timeLegthLabel.textColor = GrayColor;
        _timeLegthLabel.textAlignment = NSTextAlignmentLeft;
      //  _timeLegthLabel.backgroundColor = GrayColor;
        [self addSubview:_timeLegthLabel];
    
    
    
    
    
    
    
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
