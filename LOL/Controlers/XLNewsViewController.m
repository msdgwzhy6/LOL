//
//  XLNewsViewController.m
//  LOL
//
//  Created by lanou3g on 14-7-19.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLNewsViewController.h"
#import "TFTJSONKit.h"
#import "XLNewsObject.h"
#import "XLNewsTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "XLNewsDetailViewController.h"
#import "XLJsonManager.h"
#import "MJRefresh.h"
#import "MONActivityIndicatorView.h"


@interface XLNewsViewController ()<MONActivityIndicatorViewDelegate>

@property (nonatomic,strong)UILabel *titleLabel;//抽屉中导航的title

//存放TableView标示符的数组
@property (nonatomic,strong)NSArray *reuseArray;

@property (nonatomic,strong)UISegmentedControl *segmentedControl;//分段导航条

@property (nonatomic,strong)NSMutableArray *dataOfnewestArray;//最新数据数组

@property (nonatomic,strong)NSMutableArray *dataOfHotArray;//最热数组

@property (nonatomic,strong)NSMutableArray *dataOfOfficialArray;//官方数组

@property (nonatomic,strong)NSMutableArray *dataOFforeignArray;//外服数组

@property (nonatomic,strong)NSMutableArray *imageArray;//存放图片的数组


@end

@implementation XLNewsViewController
{
    NSInteger refreshNumber;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    
    NSInteger refreshNumberOfHot;
    MJRefreshHeaderView *_headerOfHot;
    MJRefreshFooterView *_footerOfHot;
    
    NSInteger refreshNumberOfOfficial;
    MJRefreshHeaderView *_headerOfOffical;
    MJRefreshFooterView *_footerOfOffical;
    
    NSInteger refreshNumberOfForeign;
    MJRefreshHeaderView *_headerOfForeign;
    MJRefreshFooterView *_footerOfForeign;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        refreshNumber = 1;
        refreshNumberOfHot = 1;
        refreshNumberOfOfficial = 1;
        refreshNumberOfForeign = 1;

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

 
    
    self.reuseArray = [NSArray arrayWithObjects:FirstTableViewcellIdentifier,SecondTableViewcellIdentifier,ThirdTableViewcellIdentifier,FourthTableViewcellIdentifier, nil];
    
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CM(0, 0, self_W,  62.0 / 568.0 * self_H)];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.backgroundColor  = SkyBlueColor;
     [self.view addSubview:_titleLabel];

    UILabel *titleTwoLabel = [[UILabel alloc]initWithFrame:CM(110, 23, 100,  30)];
    titleTwoLabel.textColor = [UIColor whiteColor];
    titleTwoLabel.backgroundColor  = SkyBlueColor;
    titleTwoLabel.font = [UIFont systemFontOfSize:17];
    titleTwoLabel.text = @"新闻资讯";
    titleTwoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleTwoLabel];
 


    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"iconfont_liebiao_1.png"] forState:UIControlStateNormal];
    _backButton.frame = CM(20, 25, 30, 30);
    [self.view addSubview:_backButton];
    
    //滑动视图
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 90.0 / 568.0 * self_H, self_W, 478.0 / 568.0 * self_H)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.contentSize = CGSizeMake(320 *  numberOfNewsTitle , 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
     _scrollView.bounces = NO;
   // _scrollView.scrollEnabled = NO;
     [self.view addSubview:_scrollView];
    
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
    /*
    //定时停止
    [NSTimer scheduledTimerWithTimeInterval:5 target:indicatorView selector:@selector(stopAnimating) userInfo:nil repeats:NO];
    //定时开始
    [NSTimer scheduledTimerWithTimeInterval:9 target:indicatorView selector:@selector(startAnimating) userInfo:nil repeats:NO];
*/
    
    
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"最新",@"热门",@"官方",@"外服"]];
    _segmentedControl.frame = CGRectMake(0, 60.0 / 568.0 * self_H, self_W, 30.0 / 568.0 *self_H );
    _segmentedControl.tintColor = SkyBlueColor;
  //  _segmentedControl.backgroundColor = CharcoalColor;
    _segmentedControl.selectedSegmentIndex = 0;
    [_segmentedControl addTarget:self action:@selector(clickSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:SkyBlueColor,NSForegroundColorAttributeName,[UIFont systemFontOfSize:13],NSFontAttributeName ,nil];
    
    
    [_segmentedControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    [self.view addSubview:_segmentedControl];

    [self getNewsdata];
    
    [self getNewsOfHotdata];

    [self getNewsOfOfficialData];

    [self getNewsOfForeignData];
    
    
    
 


}
//请求数据的方法，  实现把请求的数据存到一个数组中
- (void)getNewsdata
{
    TFTJSONKit *newsOfPage_1_Connectiond = [[TFTJSONKit alloc]initWithGETRequestURL:newsNewestOfPageOnePort];
    //有反应
    [newsOfPage_1_Connectiond didReiceiveResponseBlock:^(NSURLResponse *response) {
       
    }];
  
    
    [newsOfPage_1_Connectiond didFinishUsingBlock:^(id jsonObject) {
        
        MONActivityIndicatorView *indicatorView = (MONActivityIndicatorView *)[self.view viewWithTag:170];
        [indicatorView stopAnimating];
        [indicatorView removeFromSuperview];
        XLJsonManager *jsonManager = [XLJsonManager jsonDefault];
        self.dataOfnewestArray = [NSMutableArray arrayWithArray:[jsonManager newsArrayWithJson:jsonObject]];
        dispatch_async(dispatch_get_main_queue(), ^{
             //主线程
                UITableView *tempTableView = [[UITableView alloc]initWithFrame:CM(0, 0, self_W, 478.0 / 568.0 * self_H)];
                tempTableView.backgroundColor = WhiteColor;
                [tempTableView registerClass:[XLNewsTableViewCell  class] forCellReuseIdentifier:[_reuseArray objectAtIndex:0]];
                tempTableView.tag = 100 ;
                tempTableView.dataSource = self;
                tempTableView.delegate = self;
                [_scrollView addSubview:tempTableView];
            //刷新功能
            _header = [[MJRefreshHeaderView alloc]init];
            [tempTableView addHeaderWithTarget:self action:@selector(newestOfNewsHeaderAction)];
            _footer = [[MJRefreshFooterView alloc]init];
            [tempTableView addFooterWithTarget:self action:@selector(newestOfNewsFooterAction)];
            
        });
            }];
}
//最新的TableView的下拉刷新
- (void)newestOfNewsHeaderAction
{
    TFTJSONKit *newsOfPage_1_Connectiond = [[TFTJSONKit alloc]initWithGETRequestURL:newsNewestOfPageOnePort];
    [newsOfPage_1_Connectiond didFinishUsingBlock:^(id jsonObject) {
        XLJsonManager *jsonManager = [XLJsonManager jsonDefault];
        _dataOfnewestArray = [jsonManager newsArrayWithJson:jsonObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            UITableView *tempTableView = (UITableView *)[self.view viewWithTag:100];
            [tempTableView reloadData];
            [tempTableView headerEndRefreshing];
            });
    }];
}
//最新的TableView的上拉加载
- (void)newestOfNewsFooterAction
{
    refreshNumber++;
    TFTJSONKit *newsOfPage_N_Connectiond = [[TFTJSONKit alloc]initWithGETRequestURL:[NSString stringWithFormat:@"http://lolbox.oss.aliyuncs.com/json/v3/news/newslist_99_%d.json?",refreshNumber]];
    [newsOfPage_N_Connectiond didFinishUsingBlock:^(id jsonObject) {
        whatIs(jsonObject);
        if (jsonObject == nil) {
         }else{
        XLJsonManager *jsonManager = [XLJsonManager jsonDefault];
        NSMutableArray *tempArray = [jsonManager newsArrayWithJson:jsonObject];
        [_dataOfnewestArray addObjectsFromArray:tempArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            UITableView *tempTableView = (UITableView *)[self.view viewWithTag:100];
            [tempTableView reloadData];
            [tempTableView footerEndRefreshing];
        });
        }
    }];
}



- (void)getNewsOfHotdata
{
    TFTJSONKit *newsOfPage_1_Connectiond = [[TFTJSONKit alloc]initWithGETRequestURL:newsHotestOfPageOnePort];
    [newsOfPage_1_Connectiond didFinishUsingBlock:^(id jsonObject) {
        XLJsonManager *jsonManager = [XLJsonManager jsonDefault];
       self.dataOfHotArray  = [NSMutableArray arrayWithArray:[jsonManager newsArrayWithJson:jsonObject]];
        dispatch_async(dispatch_get_main_queue(), ^{
            //主线程
            UITableView *tempTableView = [[UITableView alloc]initWithFrame:CM(self_W *1, 0, self_W, 478.0 / 568.0 * self_H)];
            tempTableView.backgroundColor = WhiteColor;
            [tempTableView registerClass:[XLNewsTableViewCell  class] forCellReuseIdentifier:[_reuseArray objectAtIndex:1]];
            tempTableView.tag = 101 ;
            tempTableView.dataSource = self;
            tempTableView.delegate = self;
            [_scrollView addSubview:tempTableView];
            //刷新功能
            _headerOfHot = [[MJRefreshHeaderView alloc]init];
            [tempTableView addHeaderWithTarget:self action:@selector(newestOfHOtHeaderAction)];
            _footerOfHot = [[MJRefreshFooterView alloc]init];
            [tempTableView addFooterWithTarget:self action:@selector(newestOfHotFooterAction)];
  
        });
    }];
}
//最热的TableView的下拉刷新
- (void)newestOfHOtHeaderAction
{
    TFTJSONKit *newsOfPage_1_Connectiond = [[TFTJSONKit alloc]initWithGETRequestURL:newsHotestOfPageOnePort];
    [newsOfPage_1_Connectiond didFinishUsingBlock:^(id jsonObject) {
        XLJsonManager *jsonManager = [XLJsonManager jsonDefault];
        _dataOfnewestArray = [jsonManager newsArrayWithJson:jsonObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            UITableView *tempTableView = (UITableView *)[self.view viewWithTag:101];
            [tempTableView reloadData];
            [tempTableView headerEndRefreshing];
        });
    }];
}
//最热的TableView的上拉加载
- (void)newestOfHotFooterAction
{
    refreshNumberOfHot++;
    TFTJSONKit *newsOfPage_N_Connectiond = [[TFTJSONKit alloc]initWithGETRequestURL:[NSString stringWithFormat:@"http://lolbox.oss.aliyuncs.com/json/v3/news/newslist_88_%d.json?",refreshNumberOfHot]];
    [newsOfPage_N_Connectiond didFinishUsingBlock:^(id jsonObject) {
         if (jsonObject == nil) {
             UITableView *tempTableView = (UITableView *)[self.view viewWithTag:101];
            [tempTableView footerEndRefreshing];
        }else{
            XLJsonManager *jsonManager = [XLJsonManager jsonDefault];
            NSMutableArray *tempArray = [jsonManager newsArrayWithJson:jsonObject];
            [_dataOfHotArray addObjectsFromArray:tempArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                UITableView *tempTableView = (UITableView *)[self.view viewWithTag:101];
                [tempTableView reloadData];
                [tempTableView footerEndRefreshing];
            });
        }
    }];
}


//官方新闻
- (void)getNewsOfOfficialData
{
    TFTJSONKit *newsOfPage_1_Connectiond = [[TFTJSONKit alloc]initWithGETRequestURL:newsOfficialOfPageOnePort];
    [newsOfPage_1_Connectiond didFinishUsingBlock:^(id jsonObject) {
        XLJsonManager *jsonManager = [XLJsonManager jsonDefault];
        self.dataOfOfficialArray  = [NSMutableArray arrayWithArray:[jsonManager newsArrayWithJson:jsonObject]];
        dispatch_async(dispatch_get_main_queue(), ^{
            //主线程
            UITableView *tempTableView = [[UITableView alloc]initWithFrame:CM(self_W*2, 0, self_W, 478.0 / 568.0 * self_H)];
            tempTableView.backgroundColor = WhiteColor;
            [tempTableView registerClass:[XLNewsTableViewCell  class] forCellReuseIdentifier:[_reuseArray objectAtIndex:2]];
            tempTableView.tag = 102 ;
            tempTableView.dataSource = self;
            tempTableView.delegate = self;
            [_scrollView addSubview:tempTableView];
            //刷新功能
            _headerOfOffical = [[MJRefreshHeaderView alloc]init];
            [tempTableView addHeaderWithTarget:self action:@selector(newestOfOfficialHeaderAction)];
            _footerOfOffical = [[MJRefreshFooterView alloc]init];
            [tempTableView addFooterWithTarget:self action:@selector(newestOfOfficialFooterAction)];
            
        });
    }];
}
//官方的TableView的下拉刷新
- (void)newestOfOfficialHeaderAction
{
    TFTJSONKit *newsOfPage_1_Connectiond = [[TFTJSONKit alloc]initWithGETRequestURL:newsOfficialOfPageOnePort];
    [newsOfPage_1_Connectiond didFinishUsingBlock:^(id jsonObject) {
        XLJsonManager *jsonManager = [XLJsonManager jsonDefault];
        _dataOfOfficialArray = [jsonManager newsArrayWithJson:jsonObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            UITableView *tempTableView = (UITableView *)[self.view viewWithTag:102];
            [tempTableView reloadData];
            [tempTableView headerEndRefreshing];
        });
    }];
}
//官方的TableView的上拉加载
- (void)newestOfOfficialFooterAction
{
    refreshNumberOfOfficial++;
    TFTJSONKit *newsOfPage_N_Connectiond = [[TFTJSONKit alloc]initWithGETRequestURL:[NSString stringWithFormat:@"http://lolbox.oss.aliyuncs.com/json/v3/news/newslist_1_%d.json?",refreshNumberOfOfficial]];
    
    
    
    [newsOfPage_N_Connectiond didFinishUsingBlock:^(id jsonObject) {
         if (jsonObject == nil) {
             UITableView *tempTableView = (UITableView *)[self.view viewWithTag:102];
            [tempTableView footerEndRefreshing];
        }else{
            XLJsonManager *jsonManager = [XLJsonManager jsonDefault];
            NSMutableArray *tempArray = [jsonManager newsArrayWithJson:jsonObject];
            [_dataOfOfficialArray addObjectsFromArray:tempArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                UITableView *tempTableView = (UITableView *)[self.view viewWithTag:102];
                [tempTableView reloadData];
                [tempTableView footerEndRefreshing];
            });
        }
    }];
}

//外服新闻
- (void)getNewsOfForeignData
{
    TFTJSONKit *newsOfPage_1_Connectiond = [[TFTJSONKit alloc]initWithGETRequestURL:newsForeignOfPageOnePort];
    [newsOfPage_1_Connectiond didFinishUsingBlock:^(id jsonObject) {
        XLJsonManager *jsonManager = [XLJsonManager jsonDefault];
        self.dataOFforeignArray  = [NSMutableArray arrayWithArray:[jsonManager newsArrayWithJson:jsonObject]];
        dispatch_async(dispatch_get_main_queue(), ^{
            //主线程
            UITableView *tempTableView = [[UITableView alloc]initWithFrame:CM(self_W*3, 0, self_W, 478.0 / 568.0 * self_H)];
            tempTableView.backgroundColor = WhiteColor;
            [tempTableView registerClass:[XLNewsTableViewCell  class] forCellReuseIdentifier:[_reuseArray objectAtIndex:3]];
            tempTableView.tag = 103 ;
            tempTableView.dataSource = self;
            tempTableView.delegate = self;
            [_scrollView addSubview:tempTableView];
            //刷新功能
            _headerOfForeign = [[MJRefreshHeaderView alloc]init];
            [tempTableView addHeaderWithTarget:self action:@selector(newestOfForeignHeaderAction)];
            _footerOfForeign = [[MJRefreshFooterView alloc]init];
            [tempTableView addFooterWithTarget:self action:@selector(newestOfForeignFooterAction)];

            
        });
    }];
}
//外服的TableView的下拉刷新
- (void)newestOfForeignHeaderAction
{
    TFTJSONKit *newsOfPage_1_Connectiond = [[TFTJSONKit alloc]initWithGETRequestURL:newsForeignOfPageOnePort];
    [newsOfPage_1_Connectiond didFinishUsingBlock:^(id jsonObject) {
        XLJsonManager *jsonManager = [XLJsonManager jsonDefault];
        _dataOFforeignArray = [jsonManager newsArrayWithJson:jsonObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            UITableView *tempTableView = (UITableView *)[self.view viewWithTag:103];
            [tempTableView reloadData];
            [tempTableView headerEndRefreshing];
         });
    }];
}
//外服的TableView的上拉加载
- (void)newestOfForeignFooterAction
{
    refreshNumberOfForeign++;
    TFTJSONKit *newsOfPage_N_Connectiond = [[TFTJSONKit alloc]initWithGETRequestURL:[NSString stringWithFormat:@"http://lolbox.oss.aliyuncs.com/json/v3/news/newslist_3_%d.json?",refreshNumberOfForeign]];
    [newsOfPage_N_Connectiond didFinishUsingBlock:^(id jsonObject) {
        if (jsonObject == nil) {
            UITableView *tempTableView = (UITableView *)[self.view viewWithTag:103];
            [tempTableView footerEndRefreshing];
        }else{
            XLJsonManager *jsonManager = [XLJsonManager jsonDefault];
            NSMutableArray *tempArray = [jsonManager newsArrayWithJson:jsonObject];
            [_dataOFforeignArray addObjectsFromArray:tempArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                UITableView *tempTableView = (UITableView *)[self.view viewWithTag:103];
                [tempTableView reloadData];
                [tempTableView footerEndRefreshing];
            });
        }
    }];
}



//点击UISegmentedControl分段时，执行的方法
-(void)clickSegmentedControl:(UISegmentedControl *)segmentedControl
{
    [UIView animateWithDuration:0.3f animations:^{
        _scrollView.contentOffset = CGPointMake(segmentedControl.selectedSegmentIndex * self_W, 0);

    }];
}


//拖动开始时执行的方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
 
}
//拖动结束时执行的方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //wIsFloat(scrollView.contentOffset.x);
}

//拖动后，减速停止后执行的方法   ....这个地方因为上边加了一个TableView所以会有两个scrollerview一个是原来的_scrollView，一个是TableView的scrollView.需要注意。不能直接使用方法传过来的scrollView。如果使用需判定一下
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  
      NSInteger selectNumber = _scrollView.contentOffset.x / 320.0;
      _segmentedControl.selectedSegmentIndex = selectNumber;

}

//给一个
- (void)loadDataWithCell:(XLNewsTableViewCell *)cell indexPath:(NSIndexPath *)indexPath dataArray:(NSMutableArray *)dataArray
{
    XLNewsObject *object = [dataArray objectAtIndex:indexPath.row];
    cell.newsLabel_Title.text = object.news_Title;
    cell.newsLabel_Desc.text = object.news_Desc;
    cell.newsLabel_Posttime.text = object.news_Posttime;
    cell.newsCell_Id = object.news_Id;
    cell.newsLabel_Site.text = object.news_Site;
    [cell.news_ImageView sd_setImageWithURL:[NSURL URLWithString:object.news_Imgurl]];
}


//TableView代理方法的实现
//单元格的创建
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger caseNumber = tableView.tag - 100;
    switch (caseNumber) {
        case 0:
        {
            XLNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[_reuseArray objectAtIndex:0] forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            /*
                XLNewsObject *object = [_dataOfnewestArray objectAtIndex:indexPath.row];
                cell.newsLabel_Title.text = object.news_Title;
                cell.newsLabel_Desc.text = object.news_Desc;
                cell.newsLabel_Posttime.text = object.news_Posttime;
                cell.newsCell_Id = object.news_Id;
                cell.newsLabel_Site.text = object.news_Site;
                [cell.news_ImageView sd_setImageWithURL:[NSURL URLWithString:object.news_Imgurl]];
            */
            [self loadDataWithCell:cell indexPath:indexPath dataArray:_dataOfnewestArray];
            return cell;
        }
            break;
        case 1:
        {
            XLNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[_reuseArray objectAtIndex:1] forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            /*
            XLNewsObject *object = [_dataOfHotArray objectAtIndex:indexPath.row];
            cell.newsLabel_Title.text = object.news_Title;
            cell.newsLabel_Desc.text = object.news_Desc;
            cell.newsLabel_Posttime.text = object.news_Posttime;
            cell.newsCell_Id = object.news_Id;
            cell.newsLabel_Site.text = object.news_Site;
            [cell.news_ImageView sd_setImageWithURL:[NSURL URLWithString:object.news_Imgurl]];
             */
            [self loadDataWithCell:cell indexPath:indexPath dataArray:_dataOfHotArray];
            return cell;
        }
            break;
        case 2:
        {
            XLNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[_reuseArray objectAtIndex:2] forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            [self loadDataWithCell:cell indexPath:indexPath dataArray:_dataOfOfficialArray];
            return cell;
        }
            break;
        case 3:
        {
            XLNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[_reuseArray objectAtIndex:3] forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            [self loadDataWithCell:cell indexPath:indexPath dataArray:_dataOFforeignArray];
            return cell;
        }
            break;
        default:
            break;
    }
    
    return nil;
}

//单元格的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger caseNumber = tableView.tag - 100;
    switch (caseNumber) {
        case 0:
            return  _dataOfnewestArray.count;
            break;
        case 1:
        {
            if (_dataOfHotArray) {
                return _dataOfHotArray.count;
            }else {
                return 0;
            }
        }
            break;
        case 2:
        {
            if (_dataOfOfficialArray) {
                return _dataOfOfficialArray.count;
            }else {
                return 0;
            }
        }break;
        case 3:
        {
            if (_dataOFforeignArray) {
                return _dataOFforeignArray.count;
            }else {
                return 0;
            }
        }break;
            
        default:
            break;
    }
    return 0;
}

//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate clickNewsCellAction:indexPath];//点击单元格回抽抽屉调用方法
     NSInteger caseNumber = tableView.tag - 100;
    XLNewsDetailViewController *_newDetailVC = [[XLNewsDetailViewController alloc]init];
 
    wIsNumber(caseNumber);
    switch (caseNumber) {
        case 0:
        {
            XLNewsObject *object = [_dataOfnewestArray objectAtIndex:indexPath.row];
            _newDetailVC.newsId = object.news_Id;
        }
            break;
        case 1:
        {
            XLNewsObject *object = [_dataOfHotArray objectAtIndex:indexPath.row];
            _newDetailVC.newsId = object.news_Id;
        }
            break;
        case 2:
        {
            XLNewsObject *object = [_dataOfOfficialArray objectAtIndex:indexPath.row];
            _newDetailVC.newsId = object.news_Id;
        }
            break;
        case 3:
        {
            XLNewsObject *object = [_dataOFforeignArray objectAtIndex:indexPath.row];
            _newDetailVC.newsId = object.news_Id;
        }
            break;
        default:
            break;
    }

    [self.navigationController pushViewController:_newDetailVC animated:YES];
    
    
    
    
    
    
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
