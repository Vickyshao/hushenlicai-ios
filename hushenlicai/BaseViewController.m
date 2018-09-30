//
//  BaseViewController.m
//  hushenlicai
//
//  Created by 喻晓彬 on 2017/8/2.
//  Copyright © 2017年 hushenlicai. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController () <UITableViewDelegate,UITableViewDataSource>



@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    // Do any additional setup after loading the view.
}

// 增加标题视图
- (void)addTitleViewWithTitle:(NSString *)title{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize: 17];
    self.navigationItem.titleView = titleLabel;
}
    
// 设计导航条上的左右按钮
- (void)addBarButtonItemImageName:(NSString*)imageName title:(NSString *)title  target:(id)target action:(SEL)action isLeft:(BOOL)isLeft{
    UIButton *button = nil;
    if (imageName)
    {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        if (title)
        {
            [button setTitle:title forState:UIControlStateNormal];
        }
    }
    else if (title)
    {
        button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:title forState:UIControlStateNormal];
    }
    button.frame = CGRectMake(0, 0, 80, 30);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    
    if (isLeft)
    {
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -70, 0, 0);
        NSMutableArray *mutArr =  [[NSMutableArray alloc]initWithArray: self.navigationItem.leftBarButtonItems];
        self.navigationItem.leftBarButtonItems = [mutArr arrayByAddingObject:item];
       
    }
    else
    {
        NSMutableArray *mutArr =  [[NSMutableArray alloc]initWithArray: self.navigationItem.rightBarButtonItems];
        self.navigationItem.rightBarButtonItems = [mutArr arrayByAddingObject:item];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
}
- (void)creatTableViewWithRect:(CGRect)frame withStyle:(UITableViewStyle)style{
    self.tableView = [[UITableView alloc]initWithFrame:frame style:style];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
        // 初始化数据源
    self.dataArr = [[NSMutableArray alloc]init];
}
- (void)loadRefreshData{
    MJRefreshNormalHeader*header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.isStartWithPage) {
            self.start = @"1";
        }else{
            NSDate *senddate = [NSDate date];
            self.start =  [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970] *1000];
        }
        [self loadData];
    }];
    header.lastUpdatedTimeText = ^NSString *(NSDate *lastUpdatedTime) {
        return [NSString stringWithFormat:@"前海云轩科技 %@",[YXHelper yxTimestampSwitchTimeWithDate:lastUpdatedTime andFormatter:@"MM-dd hh:mm:ss"]];
    };
    self.tableView.mj_header = header;
}
- (void)loadMoreData {
    MJRefreshAutoStateFooter *footer =  [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        if (self.isStartWithPage) {
            self.start =  [NSString stringWithFormat:@"%ld",[self.start integerValue] + 1];
        }else {
            self.start = @"0";
        }
        [self loadData];
    }];
    footer.automaticallyRefresh = NO;
    self.tableView.mj_footer = footer;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =  [[UITableViewCell alloc]init];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    
- (void)loadDataWithUrl:(NSString *)url withIsStartWithPage:(BOOL)isStartWithPage withStart:(NSString *)start withLimit:(NSString *)limit{
    self.isStartWithPage = isStartWithPage;
    if (isStartWithPage) {
         self.start = start;
    }else{
        NSDate *senddate = [NSDate date];
        self.start =  [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970] *1000];
    }
    self.limit = limit;
    [self loadData];
}
- (void)loadData{  // 需要在 子类中重写 方法
  
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
