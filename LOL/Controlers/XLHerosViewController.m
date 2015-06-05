//
//  XLHerosViewController.m
//  LOL
//
//  Created by lanou3g on 14-7-21.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLHerosViewController.h"
#import "XLAllHerosCollectionCell.h"
#import "TFTJSONKit.h"
#import "XLHeroObject.h"
#import "XLHeroDetailViewController.h"
#import "MONActivityIndicatorView.h"
#import "XLCustomBackView.h"

@interface XLHerosViewController ()<MONActivityIndicatorViewDelegate>


@property (nonatomic,strong)UISegmentedControl *segmentedControlOfHero;//周免和全部英雄的segmentedControl

@property (nonatomic,strong)NSMutableArray *dataOfallHerosArray;//

@property (nonatomic,strong)NSMutableArray *dataOfFreeHerosArray;

@end

@implementation XLHerosViewController
{
    NSMutableArray *dataArray;
    XLCustomBackView *bView;//无用
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
    switch (index) {
        case 0:
            return RedColor;
            break;
        case 1:
            return BurntOrangeColor;
            break;
        case 2:
            return YellowColor;
            break;
        case 3:
            return GreenColor;
            break;
        case 4:
            return CyanColor;
            break;
        case 5:
            return SkyBlueColor;
            break;
        case 6:
            return CoolPurpleColor;
            break;
        default:
            break;
    }
    
    return  SkyBlueColor;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = SkyBlueColor;
    
    bView = [[XLCustomBackView alloc]initWithFrame:CM(0, screen_H - 40, screen_W, 40)];
    bView.backgroundColor = SandColor;
    bView.shareButton.hidden = YES;
    [bView.backButton setFrame:CM(20,5, 30, 30)];
    [bView.backButton setImage:[UIImage imageNamed:@"iconfont_liebiao_1.png"] forState:UIControlStateNormal];
    [bView.backButton addTarget:self action:@selector(backButtonActiton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:bView];
    
    
 

    self.segmentedControlOfHero = [[UISegmentedControl alloc]initWithItems:@[@"周免",@"全部"]];
    _segmentedControlOfHero.frame = CM(110, 5, 100, 30);
    _segmentedControlOfHero.tintColor = WhiteColor;
    _segmentedControlOfHero.selectedSegmentIndex = 1;
    [bView addSubview:_segmentedControlOfHero];
    [_segmentedControlOfHero addTarget:self action:@selector(clickSegmentedControlOfHero:) forControlEvents:UIControlEventValueChanged];

    //活动指示器
    MONActivityIndicatorView *indicatorView = [[MONActivityIndicatorView alloc] init];
    indicatorView.tag = 170;
    indicatorView.delegate = self;
    indicatorView.numberOfCircles = 7;
    indicatorView.radius = 10;
    indicatorView.internalSpacing = 3;
    indicatorView.center = self.view.center;
    [indicatorView startAnimating];
    [self.view addSubview:indicatorView];
    
    
    [self getDatasourceOfAllHeros];
    
 
}

- (void)clickSegmentedControlOfHero:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0:
        {
            if (_dataOfFreeHerosArray.count == 0 ) {
                
                //活动指示器
                MONActivityIndicatorView *indicatorView = [[MONActivityIndicatorView alloc] init];
                indicatorView.tag = 175;
                indicatorView.delegate = self;
                indicatorView.numberOfCircles = 7;
                indicatorView.radius = 10;
                indicatorView.internalSpacing = 3;
                indicatorView.center = Point(self.view.center.x - 200, self.view.center.y);
                [indicatorView startAnimating];
                [self.view addSubview:indicatorView];
                
                [self getDatasourceOfFreeHeros];

            }
            dataArray = _dataOfFreeHerosArray;
            UICollectionView *tempCo = (UICollectionView *)[self.view viewWithTag:150];
            [tempCo reloadData];
        }
            break;
        case 1:
        {
            dataArray = _dataOfallHerosArray;
            UICollectionView *tempCo = (UICollectionView *)[self.view viewWithTag:150];
            [tempCo reloadData];
        }
            break;
        default:
            break;
    }
}

- (void)backButtonActiton:(UIBarButtonItem *)buttonItem
{
     [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOfDrawer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"drawer",@"1", nil]];
}

//网络请求全部英雄数据
- (void)getDatasourceOfAllHeros;
{
    self.dataOfallHerosArray = [NSMutableArray array];
    TFTJSONKit *heroConnect = [[TFTJSONKit alloc]initWithGETRequestURL:allHerosPort];
    [heroConnect didFinishUsingBlock:^(id jsonObject) {
        
        
        MONActivityIndicatorView *indicatorView = (MONActivityIndicatorView *)[self.view viewWithTag:170];
        [indicatorView stopAnimating];
        [indicatorView removeFromSuperview];
        
        NSArray *heroArray = [jsonObject objectForKey:@"all"];
        for (NSInteger i = 0; i < heroArray.count; i++) {
            NSDictionary *heroDi = [heroArray objectAtIndex:i];
            XLHeroObject *heroObject = [XLHeroObject heroWithEnname:[heroDi objectForKey:@"enName"] cnName:[heroDi objectForKey:@"cnName"] title:[heroDi objectForKey:@"title"] tags:[heroDi objectForKey:@"tags"]];
             if (heroObject != nil) {
                [_dataOfallHerosArray addObject:heroObject];
            }
        }
        dataArray = _dataOfallHerosArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
            [flowLayout setItemSize:Size(65, 85)];
            [flowLayout setMinimumInteritemSpacing:10];//横向
            [flowLayout setMinimumLineSpacing:10];//竖直
            [flowLayout setSectionInset:UIEdgeInsetsMake(20, 10, 0, 10)];
            
            UICollectionView *allHerosCo = [[UICollectionView alloc]initWithFrame:CM(0, 20, self_W, self_H - 60) collectionViewLayout:flowLayout];
            allHerosCo.tag = 150;
            allHerosCo.backgroundColor = ClearColor;
            allHerosCo.delegate = self;
            allHerosCo.dataSource = self;
            [allHerosCo registerClass:[XLAllHerosCollectionCell class] forCellWithReuseIdentifier:AllHerosCollectionIdentifier];
            [self.view addSubview:allHerosCo];
            [self.view insertSubview:allHerosCo belowSubview:bView];

        });
    }];
}

//网络请求免费英雄数据
- (void)getDatasourceOfFreeHeros;
{
     TFTJSONKit *heroConnect = [[TFTJSONKit alloc]initWithGETRequestURL:FreeHerosPort];
    [heroConnect didFinishUsingBlock:^(id jsonObject) {
        
        MONActivityIndicatorView *indicatorView = (MONActivityIndicatorView *)[self.view viewWithTag:175];
        [indicatorView stopAnimating];
        [indicatorView removeFromSuperview];
        
        self.dataOfFreeHerosArray = [NSMutableArray array];
        NSArray *heroArray = [jsonObject objectForKey:@"free"];
        for (NSInteger i = 0; i < heroArray.count; i++) {
            NSDictionary *heroDi = [heroArray objectAtIndex:i];
            XLHeroObject *heroObject = [XLHeroObject heroWithEnname:[heroDi objectForKey:@"enName"] cnName:[heroDi objectForKey:@"cnName"] title:[heroDi objectForKey:@"title"] tags:nil];
            if (heroObject != nil) {
                [_dataOfFreeHerosArray addObject:heroObject];
            }
        }
        dataArray = _dataOfFreeHerosArray;
    dispatch_async(dispatch_get_main_queue(), ^{
        UICollectionView *tempCo = (UICollectionView *)[self.view viewWithTag:150];
        [tempCo reloadData];
    });
    }];
}





//collectionView的代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XLAllHerosCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AllHerosCollectionIdentifier forIndexPath:indexPath];
    XLHeroObject *_heroObject = [dataArray objectAtIndex:indexPath.row];
    cell.heroTitleLabel.text = _heroObject.title;
    cell.heroCnNameLabel.text =  _heroObject.cnName;
    NSString *path = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@",_heroObject.enName] ofType:@".png" ];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    cell.heroImageView.image = image;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOfDrawer object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"guan",@"1" ,nil]];
      [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOfDrawer object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"offDrawer",@"1" ,nil]];
    
    XLHeroDetailViewController *_heroDetail = [[XLHeroDetailViewController alloc]init];
    XLHeroObject *_heroObject = [dataArray objectAtIndex:indexPath.row];
    _heroDetail.heroEnName = _heroObject.enName;
    _heroDetail.heroCnName = _heroObject.cnName;
     [self presentViewController:_heroDetail animated:YES completion:^{
        
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
