//
//  BaseViewController.h
//  hushenlicai
//
//  Created by 喻晓彬 on 2017/8/2.
//  Copyright © 2017年 hushenlicai. All rights reserved.
//


#import <UIKit/UIKit.h>


/**
 导航条按钮  ，背景颜色统一封装    基于tableView 封装的controller  封装了
 下拉刷新   上拉加载等功能
 */
@interface BaseViewController : UIViewController

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,copy)NSString *start;
@property (nonatomic,copy)NSString *limit;
@property (nonatomic,assign)BOOL isStartWithPage;
    
    // 增加标题视图
- (void)addTitleViewWithTitle:(NSString *)title;
    
    // 设计导航条上的左右按钮
- (void)addBarButtonItemImageName:(NSString*)imageName title:(NSString *)title  target:(id)target action:(SEL)action isLeft:(BOOL)isLeft;


/**
创建tableView

 @param frame  frame
 @param style 样式
 */
- (void)creatTableViewWithRect:(CGRect)frame withStyle:(UITableViewStyle)style;


/**
 下拉刷新
 */
- (void)loadRefreshData;

/**
 上拉加载
 */
- (void)loadMoreData;

/**
 数据下载

 @param url 链接
 @param isStartWithPage 是否是从0 开始  还是时间戳
 @param start 开始页数
 @param limit 一页数据个数
 */
- (void)loadDataWithUrl:(NSString *)url withIsStartWithPage:(BOOL)isStartWithPage withStart:(NSString *)start withLimit:(NSString *)limit;

    

- (void)loadData;  // 需要在 子类中重写 方法
    
    
    
@end
