//
//  LLYCell.m
//  ExpandCellDemo
//
//  Created by lly on 2017/2/15.
//  Copyright © 2017年 lly. All rights reserved.
//

#import "LLYCell.h"
#import "ViewController.h"

static NSString *const kGoTopNotificationName = @"goTop";//进入置顶命令
static NSString *const kLeaveTopNotificationName = @"leaveTop";//离开置顶命令
@interface LLYCell ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (nonatomic,strong) NSArray *dataSourceArray;

@property (nonatomic, assign) BOOL canScroll;

@end

@implementation LLYCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.dataSourceArray = @[@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"111",@"222",@"333",@"444",@"555",@"666",@"777"];
    
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    [self.mTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kGoTopNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:kLeaveTopNotificationName object:nil];
    self.mTableView.showsVerticalScrollIndicator = NO;

}

-(void)acceptMsg : (NSNotification *)notification{
    //NSLog(@"%@",notification);
    NSString *notificationName = notification.name;
    if ([notificationName isEqualToString:kGoTopNotificationName]) {
        NSDictionary *userInfo = notification.userInfo;
        NSString *canScroll = userInfo[@"canScroll"];
        if ([canScroll isEqualToString:@"1"]) {
            self.canScroll = YES;
            self.mTableView.showsVerticalScrollIndicator = YES;
        }
    }else if([notificationName isEqualToString:kLeaveTopNotificationName]){
        self.mTableView.contentOffset = CGPointZero;
        self.canScroll = NO;
        self.mTableView.showsVerticalScrollIndicator = NO;
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - UITbableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataSourceArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44.0f;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.canScroll) {
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY<0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLeaveTopNotificationName object:nil userInfo:@{@"canScroll":@"1"}];
    }
}



@end
