//
//  ViewController.m
//  hushenlicai
//
//  Created by 喻晓彬 on 2017/8/2.
//  Copyright © 2017年 hushenlicai. All rights reserved.
//

#import "ViewController.h"
#import "RatioView.h"
#import "MainWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITextView *textView  = [[UITextView alloc]init];
    [textView setValue:@20 forKey:@"limit"];
    
    RatioView *view = [[RatioView alloc]initWithNumber:@[@223,@345,@321,@145] withColor:@[[UIColor redColor],[UIColor grayColor],[UIColor greenColor],[UIColor brownColor]]];
    view.backgroundColor = [UIColor clearColor];
    view.frame = CGRectMake(kSCREENWIDTH/2 - 100, 64 + 20, 200, 200);
    [self.view addSubview:view];
   
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)loadData {
    NSLog(@"%@-----%d----- %@",self.start,self.isStartWithPage,self.limit);
    if ([self.start isEqualToString:@"6"]) {
        self.start  = [NSString stringWithFormat:@"%ld",[self.start integerValue] - 1];
    }
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonAction:(id)sender {
    MainWebViewController *vc = [[MainWebViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
