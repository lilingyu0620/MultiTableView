//
//  LLYHeaderView.m
//  MultiTableView
//
//  Created by lly on 2017/2/18.
//  Copyright © 2017年 lly. All rights reserved.
//

#import "LLYHeaderView.h"

@implementation LLYHeaderView


+ (NSString *)identifier{
    
    return @"LLYHeaderView";
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
        [line setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:line];
    }
    
    return self;
}
- (void)prepareForReuse{
    
    [super prepareForReuse];
}

@end
