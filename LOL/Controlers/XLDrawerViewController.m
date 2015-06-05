//
//  XLDrawerViewController.m
//  LOL
//
//  Created by lanou3g on 14-7-19.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//






#import "XLDrawerViewController.h"



@interface XLDrawerViewController ()

@property (nonatomic,strong)UICollectionView *collV;//collectionView

@property (nonatomic,strong)NSArray *drawOfItemsTitleArray;//抽屉视图中各个items 的名字

@end

@implementation XLDrawerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.view.backgroundColor = SandColor;
    
    self.drawOfItemsTitleArray = @[@"资讯",@"视频",@"英雄",@"战绩查询",@"版本"];
    
    UICollectionViewFlowLayout *_flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    [_flowLayout setItemSize:CGSizeMake(80, 30)];
    [_flowLayout setSectionInset:UIEdgeInsetsMake(40, 30, 0, 30)];
    [_flowLayout setMinimumLineSpacing:30];
    [_flowLayout setMinimumInteritemSpacing:30];
    
     
    
    self.collV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, 200, self_H - 100) collectionViewLayout:_flowLayout];
    _collV.backgroundColor = ClearColor;
    [_collV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:drawercellIdentifier];
    _collV.delegate = self;
    _collV.dataSource = self;
    [self.view addSubview:_collV];
    

    
    



}

//collectionView 代理方法

//点击选中item的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate clickItemsAction:indexPath];
    
    
    
    
}
//有多少个items
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _drawOfItemsTitleArray.count;
}
//Items的制造
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:drawercellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = SkyBlueColor;
    cell.layer.cornerRadius = 10;
    UILabel *textLabel = [[UILabel alloc]initWithFrame:cell.bounds];
    textLabel.text = [_drawOfItemsTitleArray objectAtIndex:indexPath.row];
    textLabel.font = Font(13);
    textLabel.textColor = WhiteColor;
    textLabel.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:textLabel];
    
    return cell;
    
    
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
