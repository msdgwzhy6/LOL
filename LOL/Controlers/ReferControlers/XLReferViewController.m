//
//  XLReferViewController.m
//  LOL
//
//  Created by lanou3g on 14-7-26.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLReferViewController.h"
#import "XLReferDetailViewController.h"


@interface XLReferViewController ()

@property (nonatomic,strong)UITextField *nameTextField;//姓名输入框

@property (nonatomic,strong)UITextField *serveTextField;//战区输入框

@property (nonatomic,strong)NSArray *dataArray;

@property (nonatomic,strong)UIPickerView *pickerView;

@property (nonatomic,strong)NSString *serverName;


@end

@implementation XLReferViewController
{
    UIView *moveView;
    NSDictionary *aimDic;
}

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
    self.view.backgroundColor = SkyBlueColor;

    //  监听键盘的弹出和抽回
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //输入框的背景视图
    moveView = [[UIView alloc]initWithFrame:CM(0, 200.0 / 568.0 * screen_H, screen_W, 468.0 / 568.0 *screen_H)];
    moveView.backgroundColor = SandColor;
    [self.view addSubview:moveView];
    
    self.dataArray = @[@"电信一 艾欧尼亚",@"电信二 祖安",@"电信三 诺克萨斯",@"电信四 班德尔城",@"电信五 皮尔特沃夫",@"电信六 战争学院",@"电信七 巨神峰",@"电信八 雷瑟守备",@"电信九 裁决之地",@"电信十 黑色玫瑰",@"电信十一 暗影岛",@"电信十二 钢铁烈阳",@"电信十三 均衡教派",@"电信十四 水晶之痕",@"电信十五 影流",@"电信十六 守望之海",@"电信十七 征服之海",@"电信十八 卡拉曼达",@"电信十九 皮城警备",@"网通一 比尔吉沃特",@"网通二 德玛西亚",@"网通三 费雷尔卓德",@"网通四 无畏先锋",@"网通五 怒瑞玛",@"网通六 扭曲丛林",@"教育一 教育网专区"];
    
    
        aimDic = [NSDictionary dictionaryWithObjectsAndKeys:@"电信一",@"电信一 艾欧尼亚",@"电信二",@"电信二 祖安",@"电信三",@"电信三 诺克萨斯",@"电信四",@"电信四 班德尔城",@"电信五",@"电信五 皮尔特沃夫",@"电信六",@"电信六 战争学院",@"电信七",@"电信七 巨神峰",@"电信八",@"电信八 雷瑟守备",@"电信九",@"电信九 裁决之地",@"电信十",@"电信十 黑色玫瑰",@"电信十一",@"电信十一 暗影岛",@"电信十二",@"电信十二 钢铁烈阳",@"电信十三",@"电信十三 均衡教派",@"电信十四",@"电信十四 水晶之痕",@"电信十五",@"电信十五 影流",@"电信十六",@"电信十六 守望之海",@"电信十七",@"电信十七 征服之海",@"电信十八",@"电信十八 卡拉曼达",@"电信十九",@"电信十九 皮城警备",@"网通一",@"网通一 比尔吉沃特",@"网通二",@"网通二 德玛西亚",@"网通三",@"网通三 费雷尔卓德",@"网通四",@"网通四 无畏先锋",@"网通五",@"网通五 怒瑞玛",@"网通六",@"网通六 扭曲丛林",@"教育一",@"教育一 教育网专区", nil];
    
    
    
    //姓名输入框
    self.nameTextField = [[UITextField alloc]initWithFrame:CM(30, 200.0 / 568.0 *screen_H, 260.0/ 320.0 * screen_W, 30)];
    _nameTextField.placeholder = @"输入召唤师姓名";
    _nameTextField.delegate = self;
    _nameTextField.font = Font(14);
   // _nameTextField.clearsOnBeginEditing = YES;
    _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [moveView addSubview:_nameTextField];
    
    //姓名输入框的左视图
    UIView *nameLeftView = [[UIView alloc]initWithFrame:CM(0, 0, 60, 30)];
    UILabel *_nameLeftLabel = [[UILabel alloc]initWithFrame:CM(10, 0, 60, 30)];
    _nameLeftLabel.text = @"召唤师:";
    _nameLeftLabel.font = Font(13);
    [nameLeftView addSubview:_nameLeftLabel];
    
    _nameTextField.leftViewMode = UITextFieldViewModeAlways;
    _nameTextField.leftView = nameLeftView;
    
    
    
    //选择服务器
    self.serveTextField = [[UITextField alloc]initWithFrame:CM(30, 440.0 / 568.0 *screen_H, 260.0/ 320.0 * screen_W, 30)];
    _serveTextField.borderStyle = UITextBorderStyleRoundedRect;

    [self.view addSubview:_serveTextField];
    
    //服务器的左视图
    
    UIView *serveLeftView  = [[UIView alloc]initWithFrame:CM(0, 0,  260.0/ 320.0 * screen_W, 30)];
   // serveLeftView.backgroundColor = GrayColor;
    
    UIButton *serveLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    serveLeftButton.tag = 160;
    serveLeftButton.frame = CM(10, 0, 240.0/ 320.0 * screen_W, 30);
    [serveLeftButton addTarget:self action:@selector(serveLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    [serveLeftButton setTitle:@"选择服务器" forState:UIControlStateNormal];
    [serveLeftButton setTitleColor:BlackColor forState:UIControlStateNormal];
    [serveLeftButton setTitleColor:RedColor forState:UIControlStateHighlighted];
    serveLeftButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    serveLeftButton.titleLabel.font = Font(14);
    [serveLeftView addSubview:serveLeftButton];
    _serveTextField.leftViewMode = UITextFieldViewModeAlways;
    _serveTextField.leftView = serveLeftView;

    //查询Button
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CM(120, 480.0 / 568.0 *screen_H, 80, 30);
    searchButton.layer.cornerRadius = 10;//yunajiao
    searchButton.backgroundColor = SkyBlueColor;
    [searchButton setTitle:@"查询战绩" forState:UIControlStateNormal];
    searchButton.titleLabel.font = Font(15);
    searchButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [searchButton setTitleColor:BlackColor forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    
    
    
    
    UIButton *_boundButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _boundButton.backgroundColor = SkyBlueColor;
    _boundButton.layer.cornerRadius = 10;//圆角哦
    _boundButton.frame =CM(110, 150.0 / 568.0 *screen_H, 100.0/ 320.0 * screen_W, 40);
    [_boundButton setTitle:@"绑定" forState:UIControlStateNormal];
    [_boundButton setTitleColor:BlackColor forState:UIControlStateNormal];
    [_boundButton addTarget:self action:@selector(boundButton:) forControlEvents:UIControlEventTouchUpInside];
    [moveView addSubview:_boundButton];
    
    
    //轻点手势收回键盘
    UITapGestureRecognizer *_backKeyBoardTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backKeyBoardTap:)];
    [self.view addGestureRecognizer:_backKeyBoardTap];
    
    
    UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zhanji"]];
    iconView.frame = CM(20, 0, screen_W - 40, 170);
    [self.view addSubview:iconView];
    
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CM(20, screen_H - 35, 30, 30);
    [_backButton setImage:[UIImage imageNamed:@"iconfont_liebiao_1.png"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(referBackButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    
    
    
}

//抽屉按钮
- (void)referBackButtonAction:(UIButton *)sender
{
      [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOfDrawer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"drawer",@"1", nil]];
}

//绑定查询
- (void)boundButton:(UIButton *)sender
{
    //建立文件管理
     NSFileManager *fileManager = [NSFileManager defaultManager];
    //找到Documents文件所在的路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //取得第一个Documents文件夹的路径
    NSString *filePath = [path firstObject];
    //把textPlist文件加入
    NSString *plistPath = [filePath stringByAppendingPathComponent:@"text.plist"];
    if ([fileManager fileExistsAtPath:plistPath]) {
        NSDictionary *referDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
         XLReferDetailViewController *_referDetailVC = [[XLReferDetailViewController alloc]init];
        _referDetailVC.summonerName = [referDic objectForKey:@"name"];
        _referDetailVC.summonerSeverName = [referDic objectForKey:@"severName"];
        _referDetailVC.titleName = [referDic objectForKey:@"severName"];
        [self presentViewController:_referDetailVC animated:YES completion:^{
            [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOfDrawer object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"guan",@"1", nil]];
        }];
    } else {
        UILabel *alterText = [[UILabel alloc]initWithFrame:CGRectMake(50.0 / 320.0  * screen_W, 300.0 / 568.0 * screen_H , 220, 30)];
        alterText.text = @"你还没有绑定角色!";
        alterText.font = [UIFont systemFontOfSize:13];
        alterText.textAlignment = NSTextAlignmentCenter;
        alterText.textColor = RedColor;
        [self.view addSubview:alterText];
        //渐隐
        [UIView animateWithDuration:1.5f animations:^{
            alterText.alpha = 0;
        }];
        //移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [alterText removeFromSuperview];
            
        });
    }

    
}

//查询按钮，跳到HTML界面
- (void)searchButtonAction:(UIButton *)sender
{
    whatIs(_nameTextField);
    if ([_nameTextField.text isEqualToString:@""]) {
         UILabel *alterText = [[UILabel alloc]initWithFrame:CGRectMake(50.0 / 320.0  * screen_W, 300.0 / 568.0 * screen_H , 220, 30)];
        alterText.text = @"召唤师名字不能为空!";
        alterText.font = [UIFont systemFontOfSize:13];
        alterText.textAlignment = NSTextAlignmentCenter;
        alterText.textColor = RedColor;
        [self.view addSubview:alterText];
         //渐隐
        [UIView animateWithDuration:1.5f animations:^{
            alterText.alpha = 0;
        }];
        //移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [alterText removeFromSuperview];
            
        });
    }else {
    XLReferDetailViewController *_referDetailVC = [[XLReferDetailViewController alloc]init];
    _referDetailVC.summonerName = _nameTextField.text;
    _referDetailVC.summonerSeverName = [aimDic objectForKey:_serverName];
        _referDetailVC.titleName = _serverName;
    [self presentViewController:_referDetailVC animated:YES completion:^{
         [[NSNotificationCenter defaultCenter]postNotificationName:NotificationOfDrawer object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"guan",@"1", nil]];
    }];
        
  
    }
}


//轻点收回键盘
- (void)backKeyBoardTap:(UITapGestureRecognizer *)tapGesture
{
    [_nameTextField resignFirstResponder];
}
//点击选择服务器，弹出选择服务器视图
- (void)serveLeftButton:(UIButton *)sender
{
    self.serverName = [_dataArray objectAtIndex:0];//默认选中的单元格
    self.pickerView = [[UIPickerView alloc]initWithFrame:CM(30, 300.0 / 568.0 *screen_H , 260, 250.0 / 568.0 *screen_H )];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.backgroundColor = SandColor;
    _pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:_pickerView];
    
 
    //自定义UINavigationBar
    UINavigationBar *_navigationBar = [[UINavigationBar alloc]initWithFrame:CM(0, 490.0 / 568.0 *screen_H, self_W, 30)];
    _navigationBar.tag = 150;
    _navigationBar.backgroundColor = SkyBlueColor;
    UINavigationItem *_nabigationItems = [[UINavigationItem alloc]initWithTitle:nil];
    
    UIBarButtonItem *cancleButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleButtonActiton:)];
    UIBarButtonItem *sureButton = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureButtonActiton:)];
    [_navigationBar pushNavigationItem:_nabigationItems animated:YES];

    [_nabigationItems setLeftBarButtonItem:cancleButton];
    [_nabigationItems setRightBarButtonItem:sureButton];

    [self.view addSubview:_navigationBar];
    
    

    
    
    
    
    
    
    
}

- (void)cancleButtonActiton:(UIBarButtonItem *)sender
{
    [_pickerView removeFromSuperview];
    self.pickerView = nil;
    UINavigationBar *temp = (UINavigationBar *)[self.view viewWithTag:150];
    [temp removeFromSuperview];
}
//传值 ,把选中的服务器的名字显示到服务器输入框中
- (void)sureButtonActiton:(UIBarButtonItem *)sender
{
    [_pickerView removeFromSuperview];
    self.pickerView = nil;
    UINavigationBar *temp = (UINavigationBar *)[self.view viewWithTag:150];
    [temp removeFromSuperview];
    UIButton *button = (UIButton *)[self.view viewWithTag:160];
    [button setTitle:_serverName  forState:UIControlStateNormal];
    
}

//pickerView  dataSource的代理方法
//返回单元格的数量
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger count = 0;
    switch (component) {
        case 0:
            count = _dataArray.count;
            break;
 
        default:
            break;
    }
    return count;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//pickerView datadelegate的代理方法
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *aLabel = nil;

    if (component == 0) {
        aLabel = [[UILabel alloc]initWithFrame:CM(0, 0, 200, 35)];
        aLabel.text = [_dataArray objectAtIndex:row];
        aLabel.textAlignment = NSTextAlignmentCenter;
        aLabel.backgroundColor = SkyBlueColor;
        aLabel.font = Font(15);
        aLabel.textColor = BlackColor;
    }
    return aLabel;
}
//返回分区部件的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat componentWidth = 0.0;
    if (component == 0) {
        componentWidth = 80.0;
    }
    return componentWidth;
}
//返回单元格的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 35.0;
}
//监听轮子的移动
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        _serverName = [_dataArray objectAtIndex:row];
    }else{
        
    }
}
//textField delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    run;
    [[NSNotificationCenter defaultCenter] postNotificationName:drawercellIdentifier object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"offDrawer",@"1", nil]];
    return YES;
}



//换行符 键盘回收
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_nameTextField resignFirstResponder];
    return YES;
}



//监听键盘的弹出和抽回，让输入框跟随移动
- (void)keyBoardFrameChange:(NSNotification *)notification
{
    //编辑消息框textField的位置
    CGRect textfieldRect = moveView.frame;
    
    
    NSDictionary *userInfo = notification.userInfo;
    //键盘开始变化前的位置
    CGRect keyboardStartRect = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey ] CGRectValue];
    
    //键盘结束变化后的位置
    CGRect keyboardEndRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //变化量
    CGFloat keyboardChangeValue = CGRectGetMinY(keyboardEndRect) - CGRectGetMinY(keyboardStartRect);
    
    textfieldRect.origin.y += keyboardChangeValue;
    
    [UIView animateWithDuration:0.25 animations:^{
        moveView.frame = textfieldRect;
    }];
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
