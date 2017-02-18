//
//  ViewController.m
//  MultiTableView
//
//  Created by lly on 2017/2/18.
//  Copyright © 2017年 lly. All rights reserved.
//

#import "ViewController.h"
#import "LLYCell.h"
#import "LLYHeaderView.h"

static NSString *const kGoTopNotificationName = @"goTop";//进入置顶命令
static NSString *const kLeaveTopNotificationName = @"leaveTop";//离开置顶命令


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;

@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;

@property (nonatomic, assign) BOOL canScroll;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.mTableView.showsVerticalScrollIndicator = NO;
    
    [self.mTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.mTableView registerNib:[UINib nibWithNibName:@"LLYCell" bundle:nil] forCellReuseIdentifier:@"LLYCell"];
    [self.mTableView registerClass:[LLYHeaderView class] forHeaderFooterViewReuseIdentifier:[LLYHeaderView identifier]];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kLeaveTopNotificationName object:nil];
    
}

-(void)acceptMsg : (NSNotification *)notification{
    //NSLog(@"%@",notification);
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _canScroll = YES;
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITabelView DataSource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.textLabel.text = @"section 0 cell";
        cell.backgroundColor = [UIColor yellowColor];
        return cell;
    }
    
    LLYCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLYCell"];
    return cell;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return nil;
    }
    
    LLYHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[LLYHeaderView identifier]];
    headerView.textLabel.text = @"LLYHeaderView";
    headerView.contentView.backgroundColor = [UIColor grayColor];
    return headerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100.0f;
    }
    
    return 600.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 44.0f;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat tabOffsetY = [_mTableView rectForSection:1].origin.y;
    CGFloat offsetY = scrollView.contentOffset.y;
    _isTopIsCanNotMoveTabViewPre = _isTopIsCanNotMoveTabView;
    if (offsetY >= tabOffsetY) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        _isTopIsCanNotMoveTabView = YES;
    }else{
        _isTopIsCanNotMoveTabView = NO;
    }
    if (_isTopIsCanNotMoveTabView != _isTopIsCanNotMoveTabViewPre) {
        if (!_isTopIsCanNotMoveTabViewPre && _isTopIsCanNotMoveTabView) {
            //NSLog(@"滑动到顶端");
            [[NSNotificationCenter defaultCenter] postNotificationName:kGoTopNotificationName object:nil userInfo:@{@"canScroll":@"1"}];
            _canScroll = NO;
        }
        if(_isTopIsCanNotMoveTabViewPre && !_isTopIsCanNotMoveTabView){
            //NSLog(@"离开顶端");
            if (!_canScroll) {
                scrollView.contentOffset = CGPointMake(0, tabOffsetY);
            }
        }
    }
}


@end
