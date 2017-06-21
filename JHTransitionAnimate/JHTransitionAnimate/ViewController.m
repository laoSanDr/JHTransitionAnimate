//
//  ViewController.m
//  JHTransitionAnimate
//
//  Created by jalaSmart on 17/6/20.
//  Copyright © 2017年 MrChen. All rights reserved.
//

#import "ViewController.h"
#import "JHTransition.h"
#import "UIImage+JHImage.h"
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *array;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(375, 64)] forBarMetrics:UIBarMetricsDefault];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.rowHeight     = 60;
        _tableView.delegate      = self;
        _tableView.dataSource    = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = @[@"AnimateTypeDefault",@"AnimateTypeDiffNavi",@"AnimateTypeKuGou",@"AnimateTypeRound",@"AnimationOval",@"AnimatrTypeDouYu"];
    
    self.navigationController.delegate = [JHTransition shareManager];
    [JHTransition shareManager].animationType = JHAnimateTypeDiffNavi;
    [self.view addSubview:self.tableView];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHAnimateType type = indexPath.row == 0 ? JHAnimateTypeDefault : indexPath.row == 1 ? JHAnimateTypeDiffNavi : indexPath.row == 2 ? JHAnimateTypeKuGou : indexPath.row == 3 ? JHAnimateTypeRound : indexPath.row == 4 ? JHAnimateTypeOval : JHAnimateTypeDouYu;
    [JHTransition shareManager].animationType = type;
    DetailViewController *vc = [[DetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    //    self.hidesBottomBarWhenPushed = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.array[indexPath.row];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
