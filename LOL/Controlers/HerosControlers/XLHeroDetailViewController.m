//
//  XLHeroDetailViewController.m
//  LOL
//
//  Created by lanou3g on 14-7-23.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLHeroDetailViewController.h"
#import "TFTJSONKit.h"
#import "XLHeroDetailObject.h"
#import "XLHeroDetailHeadImageView.h"
#import "XLHeroDataView.h"
#import "XLSkillMessageView.h"
#import "XLCustomBackView.h"
#import "MONActivityIndicatorView.h"


@interface XLHeroDetailViewController ()<MONActivityIndicatorViewDelegate>



@property (nonatomic,strong)XLHeroDetailObject *heroDetail;//存放英雄的详细信息

@property (nonatomic,strong)UISegmentedControl *segmentControl;//分段器

@property (nonatomic,strong)UIScrollView *messageOfScrollView;//scrollView

@end

@implementation XLHeroDetailViewController
{
    NSArray *array;
    CGSize tipsSize;//技巧长度
    CGSize opponentTipsSize;//应对技巧长度
    CGSize descriptionSize;//英雄描述长度
    CGSize skillBdeSize;//被动技能描述长度
    CGSize skillQdeSize;//技能Q的技能描述长度
    CGSize skillQeffSize;//技能Q的效果描述长度
    CGSize skillWdeSize;//技能W的技能描述长度
    CGSize skillWeffSize;//技能W的效果描述长度
    CGSize skillEdeSize;//
    CGSize skillEeffSize;
    CGSize skillRdeSize;
    CGSize skillReffSize;
    
    NSInteger skillNumber;//第几个技能
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - MONActivityIndicatorViewDelegate Methods

- (UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView
      circleBackgroundColorAtIndex:(NSUInteger)index {
    CGFloat red   = (arc4random() % 256)/255.0;
    CGFloat green = (arc4random() % 256)/255.0;
    CGFloat blue  = (arc4random() % 256)/255.0;
    CGFloat alpha = 1.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.view.backgroundColor = SkyBlueColor;
    skillNumber = 0;//默认选中被动技能
    
    
    XLCustomBackView *_heroDeBackView = [[XLCustomBackView alloc]initWithFrame:CM(0, screen_H - 40, screen_W, 40)];
    _heroDeBackView.backgroundColor = SandColor;
    _heroDeBackView.tag = 171;
     [_heroDeBackView.backButton addTarget:self action:@selector(backButtonActiton:) forControlEvents:UIControlEventTouchUpInside];
    [_heroDeBackView.backButton setFrame:CM(20,5, 30, 30)];
    [_heroDeBackView.backButton setImage:[UIImage imageNamed:@"iconfont-xiajiantou.png"] forState:UIControlStateNormal];
    _heroDeBackView.shareButton.hidden = YES;
    _heroDeBackView.textLabel.text = [NSString stringWithFormat:@"%@",_heroCnName];
    [self.view addSubview:_heroDeBackView];
    
    [self getHeroDetailMessage];

//头像View
     NSString *path = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@",_heroEnName] ofType:@".png"];
    UIImageView *_hero_headImageView = [[UIImageView alloc]initWithFrame:CM(15, 30 , 60, 60 )];
    _hero_headImageView.tag = 180;
    _hero_headImageView.image = [UIImage imageWithContentsOfFile:path];
    [self.view addSubview:_hero_headImageView];
    
    
    //活动指示器
    MONActivityIndicatorView *indicatorView = [[MONActivityIndicatorView alloc] init];
    indicatorView.tag = 190;
    indicatorView.delegate = self;
    indicatorView.numberOfCircles = 7;
    indicatorView.radius = 10;
    indicatorView.internalSpacing = 3;
    indicatorView.center = self.view.center;
    [indicatorView startAnimating];
    [self.view addSubview:indicatorView];
    
 
}

 //返回
- (void)backButtonActiton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOfDrawer object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"kai",@"1", nil]];
    }];
}

//网络请求 英雄的详细信息
- (void)getHeroDetailMessage
{
    TFTJSONKit *heroDeconnect = [[TFTJSONKit alloc]initWithGETRequestURL:[NSString stringWithFormat:@"http://lolbox.duowan.com/phone/apiHeroDetail.php?heroName=%@&v=25&OSType=iOS7.1.1",_heroEnName]];
    
    [heroDeconnect didFinishUsingBlock:^(id jsonObject) {
        
        MONActivityIndicatorView *indicatorView = (MONActivityIndicatorView *)[self.view viewWithTag:190];
        [indicatorView stopAnimating];
        [indicatorView removeFromSuperview];
        
        self.heroDetail = [[XLHeroDetailObject alloc]initWithId:[jsonObject objectForKey:@"id"]
    name:[jsonObject objectForKey:@"name"]
    displayName:[jsonObject objectForKey:@"displayName"]
    title:[jsonObject objectForKey:@"title"]
    tags:[jsonObject objectForKey:@"tags"]
    description:[jsonObject objectForKey:@"description"]
    tips:[jsonObject objectForKey:@"tips"]
    opponentTips:[jsonObject objectForKey:@"opponentTips"]
    B:[jsonObject objectForKey:[NSString stringWithFormat:@"%@_B",_heroEnName]]
    Q:[jsonObject objectForKey:[NSString stringWithFormat:@"%@_Q",_heroEnName]]
    W:[jsonObject objectForKey:[NSString stringWithFormat:@"%@_W",_heroEnName]]
    E:[jsonObject objectForKey:[NSString stringWithFormat:@"%@_E",_heroEnName]]
    R:[jsonObject objectForKey:[NSString stringWithFormat:@"%@_R",_heroEnName]]
    price:[jsonObject objectForKey:@"price"]
    like:[jsonObject objectForKey:@"like"]
    hate:[jsonObject objectForKey:@"hate"]
    range:[jsonObject objectForKey:@"range"]
    moveSpeed:[jsonObject objectForKey:@"moveSpeed"]
    armorBase:[jsonObject objectForKey:@"armorBase"]
    armorLevel:[jsonObject objectForKey:@"armorLevel"]
    manaBase:[jsonObject objectForKey:@"manaBase"]
    manaLevel:[jsonObject objectForKey:@"manaLevel"]
    criticalChanceBase:[jsonObject objectForKey:@"criticalChanceBase"]
    criticalChanceLevel:[jsonObject objectForKey:@"criticalChanceLevel"]
    manaRegenBase:[jsonObject objectForKey:@"manaRegenBase"]
    manaRegenLevel:[jsonObject objectForKey:@"manaRegenLevel"]
    healthRegenBase:[jsonObject objectForKey:@"healthRegenBase"]
    healthRegenLevel:[jsonObject objectForKey:@"healthRegenLevel"]
    magicResistBase:[jsonObject objectForKey:@"magicResistBase"]
    magicResistLevel:[jsonObject objectForKey:@"magicResistLevel"]
    healthBase:[jsonObject objectForKey:@"healthBase"]
    healthLevel:[jsonObject objectForKey:@"healthLevel"]
    attackBase:[jsonObject objectForKey:@"attackBase"]
    attackLevel:[jsonObject objectForKey:@"attackLevel"]
    ratingDefense:[jsonObject objectForKey:@"ratingDefense"]
    ratingMagic:[jsonObject objectForKey:@"ratingMagic"]
    ratingDifficulty:[jsonObject objectForKey:@"ratingDifficulty"]
    ratingAttack:[jsonObject objectForKey:@"ratingAttack"]];
        
        
         dispatch_async(dispatch_get_main_queue(), ^{
             
             if (_heroDetail.de_price != nil) {
                 if (!_heroDetail.de_price ) {
                     array = [_heroDetail.de_price componentsSeparatedByString:@","];
                 }else {
                     array = @[@"6300",@"4800"];
                 }
             }
           else {
                array = @[@"6300",@"4800"];
            }
            
            XLHeroDetailHeadImageView *_headImageView = [[XLHeroDetailHeadImageView alloc]initWithFrame:CM(0, 20, self_W, 80) goldPrice:[array objectAtIndex:0] dianquanPrice:[array objectAtIndex:1] displayName:_heroDetail.de_displayName attack:_heroDetail.de_ratingAttack defense:_heroDetail.de_ratingDefense magic:_heroDetail.de_ratingMagic difficulty:_heroDetail.de_ratingDifficulty];
            _headImageView.backgroundColor = SkyBlueColor;
             _headImageView.tag= 181;
             [self.view addSubview:_headImageView];
             UIImageView *imageView = (UIImageView *)[self.view viewWithTag:180];
             [self.view insertSubview:_headImageView belowSubview:imageView];
             
             
             //计算长度
             [self countLength];
             
             self.messageOfScrollView = [[UIScrollView alloc]initWithFrame:CM(0, 20 , self_W, self_H - 60)];
             _messageOfScrollView.backgroundColor = SkyBlueColor;
             _messageOfScrollView.contentSize = Size(0, skillBdeSize.height + skillQdeSize.height +skillQeffSize.height +skillWdeSize.height +skillWeffSize.height + skillEdeSize.height + skillEeffSize.height + skillRdeSize.height + skillReffSize.height + tipsSize.height + opponentTipsSize.height + descriptionSize.height + 835  );
            // _messageOfScrollView.contentOffset = Point(0, 40);
             _messageOfScrollView.bounces = YES;
             [_messageOfScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
      //添加文字
             NSInteger heightSum = 80;
          
                 XLSkillMessageView *skillViewB = [[XLSkillMessageView alloc]initWithFrame:CM(0, heightSum, screen_W, skillBdeSize.height + 40) dic:_heroDetail.de_B skillNumber:0 descriptionHeight:skillBdeSize.height  effectHeight:0];
             skillViewB.backgroundColor = SandColor;
                 [_messageOfScrollView addSubview:skillViewB];
             heightSum = heightSum +skillBdeSize.height + 40;
             
                 XLSkillMessageView *skillViewQ = [[XLSkillMessageView alloc]initWithFrame:CM(0, heightSum , screen_W, skillQdeSize.height + skillQeffSize.height + 105 ) dic:_heroDetail.de_Q skillNumber:1 descriptionHeight:skillQdeSize.height  effectHeight:skillQeffSize.height];
             skillViewQ.backgroundColor = SkyBlueColor;
                 [_messageOfScrollView addSubview:skillViewQ];
             heightSum = heightSum + skillQdeSize.height + skillQeffSize.height + 105;
             
                 XLSkillMessageView *skillViewW = [[XLSkillMessageView alloc]initWithFrame:CM(0, heightSum, screen_W, skillWdeSize.height + skillWeffSize.height + 105 ) dic:_heroDetail.de_W skillNumber:2 descriptionHeight:skillWdeSize.height  effectHeight:skillWeffSize.height];
             skillViewW.backgroundColor = SandColor;
                 [_messageOfScrollView addSubview:skillViewW];
             heightSum = heightSum + skillWdeSize.height + skillWeffSize.height + 105;
             
                XLSkillMessageView *skillViewE = [[XLSkillMessageView alloc]initWithFrame:CM(0, heightSum, screen_W, skillEdeSize.height + skillEeffSize.height + 105 ) dic:_heroDetail.de_E skillNumber:3 descriptionHeight:skillEdeSize.height  effectHeight:skillEeffSize.height];
             skillViewE.backgroundColor = SkyBlueColor;
                 [_messageOfScrollView addSubview:skillViewE];
             heightSum = heightSum + skillEdeSize.height + skillEeffSize.height + 105;
         
                 XLSkillMessageView *skillViewR = [[XLSkillMessageView alloc]initWithFrame:CM(0,heightSum, screen_W, skillRdeSize.height + skillReffSize.height + 105 ) dic:_heroDetail.de_R skillNumber:4 descriptionHeight:skillRdeSize.height  effectHeight:skillReffSize.height];
             skillViewR.backgroundColor = SandColor;
                 [_messageOfScrollView addSubview:skillViewR];
             heightSum = heightSum + skillRdeSize.height + skillReffSize.height + 105;
             
             //使用技巧
             UILabel *tipsLabel = [[UILabel alloc]initWithFrame:CM(0, heightSum, self_W , tipsSize.height)];
             tipsLabel.text = _heroDetail.de_tips;
             tipsLabel.backgroundColor = SkyBlueColor;
             tipsLabel.font = Font(SizeOfFont);
             tipsLabel.numberOfLines = 0;
             [_messageOfScrollView addSubview:tipsLabel];
             heightSum = heightSum + tipsSize.height;
             
             //应对技巧
              UILabel *opponentLabel = [[UILabel alloc]initWithFrame:CM(0, heightSum, self_W , opponentTipsSize.height)];
             opponentLabel.backgroundColor = SandColor;
             opponentLabel.text = _heroDetail.de_opponentTips;
             opponentLabel.font = Font(SizeOfFont);
             opponentLabel.numberOfLines = 0;
             [_messageOfScrollView addSubview:opponentLabel];
             heightSum = heightSum + opponentTipsSize.height;
             
             //滑轮
             UIView *dataVC = [self heroDataView];
             dataVC.backgroundColor = SkyBlueColor;
             dataVC.frame = CM(0, heightSum, self_W , 300);
             [_messageOfScrollView addSubview:dataVC];
             heightSum = heightSum + 300;
             
             //背景描述
             UILabel *descripeLabel = [[UILabel alloc]initWithFrame:CM(0, heightSum, self_W , descriptionSize.height)];
             descripeLabel.backgroundColor = SandColor;
             descripeLabel.text = _heroDetail.de_description;
             descripeLabel.font = Font(SizeOfFont);
             descripeLabel.numberOfLines = 0;
             [_messageOfScrollView addSubview:descripeLabel];
             
             
             
             
             
             [self.view addSubview:_messageOfScrollView];
             
             [self.view insertSubview:_messageOfScrollView atIndex:0];
        });
        
    }];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
     UIScrollView *tempScrollView = (UIScrollView *)object;
    whatIs(tempScrollView);
    if (tempScrollView.contentOffset.y >100) {
        [UIView animateWithDuration:0.5f animations:^{
            UIImageView *aView = (UIImageView *)[self.view viewWithTag:180];
            aView.alpha = 0;
            XLHeroDetailHeadImageView *headView = (XLHeroDetailHeadImageView *)[self.view viewWithTag:181];
            headView.alpha = 0;
           //  tempScrollView.frame = CM(0, 20, screen_W, screen_H - 60);
          }];
    }else if(tempScrollView.contentOffset.y <= 100){
        [UIView animateWithDuration:0.5f animations:^{
            UIImageView *aView = (UIImageView *)[self.view viewWithTag:180];
            aView.alpha = 1;
            XLHeroDetailHeadImageView *headView = (XLHeroDetailHeadImageView *)[self.view viewWithTag:181];
            headView.alpha = 1;
         //   _messageOfScrollView.frame = CM(0, 100 , self_W, self_H - 140);
          }];
    }
}

//得到各个字段的长度
- (void)countLength
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:SizeOfFont]};
    tipsSize = [_heroDetail.de_tips  boundingRectWithSize:CGSizeMake(300, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    opponentTipsSize = [_heroDetail.de_opponentTips  boundingRectWithSize:CGSizeMake(305, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    descriptionSize = [_heroDetail.de_description  boundingRectWithSize:CGSizeMake(305, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    NSDictionary *attribute1 = @{NSFontAttributeName: [UIFont systemFontOfSize:SizeOfFont]};

    skillBdeSize = [[_heroDetail.de_B objectForKey:@"description"] boundingRectWithSize:Size(280, 0) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attribute1 context:nil].size;
    
    skillQdeSize = [[_heroDetail.de_Q objectForKey:@"description"] boundingRectWithSize:Size(280, 0) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attribute1 context:nil].size;
    skillQeffSize = [[_heroDetail.de_Q objectForKey:@"effect"] boundingRectWithSize:Size(280, 0) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attribute1 context:nil].size;
    
    skillWdeSize = [[_heroDetail.de_W objectForKey:@"description"] boundingRectWithSize:Size(280, 0) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attribute1 context:nil].size;
    skillWeffSize = [[_heroDetail.de_W objectForKey:@"effect"] boundingRectWithSize:Size(280, 0) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attribute1 context:nil].size;
    
    skillEdeSize = [[_heroDetail.de_E objectForKey:@"description"] boundingRectWithSize:Size(280, 0) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attribute1 context:nil].size;
    skillEeffSize = [[_heroDetail.de_E objectForKey:@"effect"] boundingRectWithSize:Size(280, 0) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attribute1 context:nil].size;
    
    skillRdeSize = [[_heroDetail.de_R objectForKey:@"description"] boundingRectWithSize:Size(280, 0) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attribute1 context:nil].size;
    skillReffSize = [[_heroDetail.de_R objectForKey:@"effect"] boundingRectWithSize:Size(280, 0) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attribute1 context:nil].size;
    
    
    
    
}

//封装的UILabel
- (void)labelWithFrame:(CGRect )frame name:(NSString *)name value:(NSString *)value tag:(NSInteger )tag superView:(UIView *)aview levelValue:(NSString *)levelValue
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
     levelValue = [NSString stringWithFormat:@"%.2f",[levelValue floatValue]];
    label.text =[NSString stringWithFormat:@"%@:%@(%@)",name,value,levelValue];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = Font(12);
    label.tag = tag;
    [aview addSubview:label];
    
}
- (void)labelWithFrame:(CGRect )frame name:(NSString *)name value:(NSString *)value tag:(NSInteger )tag superView:(UIView *)aview
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
     label.text =[NSString stringWithFormat:@"%@:%@",name,value];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = Font(12);
    label.tag = tag;
    [aview addSubview:label];
    
}

//英雄数据
- (UIView *)heroDataView
{
    UIView *aView = [[UIView alloc]initWithFrame:CM(0, 0, screen_W, 300)];
    
    [self labelWithFrame:CM(10, 5, 150, 20) name:@"等级" value:@"0" tag:150 superView:aView];
    [self labelWithFrame:CM(20, 35, 150, 20) name:@"攻击距离" value:_heroDetail.de_range  tag:151 superView:aView];
    [self labelWithFrame:CM(20, 55, 150, 20) name:@"移动速度" value:_heroDetail.de_moveSpeed  tag:152 superView:aView];
    [self labelWithFrame:CM(20, 75, 150, 20) name:@"基础攻击" value:_heroDetail.de_attackBase  tag:153 superView:aView levelValue:_heroDetail.de_attackLevel];
    [self labelWithFrame:CM(20, 95, 150, 20) name:@"基础物理防御" value:_heroDetail.de_armorBase  tag:154 superView:aView levelValue:_heroDetail.de_armorLevel];
    [self labelWithFrame:CM(20, 115, 150, 20) name:@"基础魔法抗性" value:_heroDetail.de_magicResistBase  tag:155 superView:aView  levelValue:_heroDetail.de_magicResistLevel];
    [self labelWithFrame:CM(20, 135, 150, 20) name:@"基础魔法值" value:_heroDetail.de_manaBase  tag:156 superView:aView levelValue:_heroDetail.de_manaLevel];
    [self labelWithFrame:CM(20, 155, 150, 20) name:@"基础生命值" value:_heroDetail.de_healthBase  tag:157 superView:aView levelValue:_heroDetail.de_heathLevel];
    [self labelWithFrame:CM(20, 175, 150, 20) name:@"暴击概率" value:_heroDetail.de_criticalChanceBase  tag:158 superView:aView levelValue:_heroDetail.de_criticalChanceLevel];
    [self labelWithFrame:CM(20, 195, 150, 20) name:@"魔法回复" value:_heroDetail.de_manaRegenBase  tag:159 superView:aView levelValue:_heroDetail.de_manaRegenLevel];
    [self labelWithFrame:CM(20, 215, 150, 20) name:@"生命回复" value:_heroDetail.de_healthRegenBase  tag:160 superView:aView levelValue:_heroDetail.de_healthRegenLevel];

    
    UISlider *slider = [[UISlider alloc]initWithFrame:CM(30, 260, 260, 20)];
    slider.minimumTrackTintColor = WhiteColor;
    slider.maximumTrackTintColor = SandColor;
    slider.tag = 200;
    slider.minimumValue = 1;
    slider.maximumValue = 18;
    [slider addTarget:self action:@selector(slider:) forControlEvents:UIControlEventValueChanged];
 
    [aView addSubview:slider];
    
    return aView;
}

- (void)changeValueWithTag:(NSInteger )tag name:(NSString *)name sliderValue:(NSInteger )value baseValue:(NSString *)baseValue levelValue:(NSString *)levelValue
{
    UILabel *label = (UILabel *)[self.view viewWithTag:tag];
    baseValue =  [NSString stringWithFormat:@"%.2f",([baseValue floatValue] + value * [levelValue floatValue])];
    levelValue = [NSString stringWithFormat:@"%.2f",[levelValue floatValue]];
    label.text =[NSString stringWithFormat:@"%@:%@(%@)",name,baseValue,levelValue];
}

//滑动条滑动的实现
- (void)slider:(UISlider *)slider
{
    UILabel *label = (UILabel *)[self.view viewWithTag:150];
    label.text = [NSString stringWithFormat:@"等级:%d",(NSInteger )slider.value];
    
      [self changeValueWithTag:153 name:@"基础攻击" sliderValue:(NSInteger )slider.value baseValue:_heroDetail.de_attackBase levelValue:_heroDetail.de_attackLevel];
      [self changeValueWithTag:154 name:@"基础物理防御" sliderValue:(NSInteger )slider.value baseValue:_heroDetail.de_armorBase levelValue:_heroDetail.de_armorLevel];
      [self changeValueWithTag:155 name:@"基础魔法抗性" sliderValue:(NSInteger )slider.value baseValue:_heroDetail.de_magicResistBase  levelValue:_heroDetail.de_magicResistLevel];
      [self changeValueWithTag:156 name:@"基础魔法值" sliderValue:(NSInteger )slider.value baseValue:_heroDetail.de_manaBase levelValue:_heroDetail.de_manaLevel];
        [self changeValueWithTag:157 name:@"基础生命值" sliderValue:(NSInteger )slider.value baseValue:_heroDetail.de_healthBase levelValue:_heroDetail.de_heathLevel];
    [self changeValueWithTag:158 name:@"暴击概率" sliderValue:(NSInteger )slider.value baseValue:_heroDetail.de_criticalChanceBase levelValue:_heroDetail.de_criticalChanceLevel];
    [self changeValueWithTag:159 name:@"魔法回复" sliderValue:(NSInteger )slider.value baseValue:_heroDetail.de_manaRegenBase levelValue:_heroDetail.de_manaRegenLevel];
    [self changeValueWithTag:160 name:@"生命回复" sliderValue:(NSInteger )slider.value baseValue:_heroDetail.de_healthRegenBase levelValue:_heroDetail.de_healthRegenLevel];
}








@end
