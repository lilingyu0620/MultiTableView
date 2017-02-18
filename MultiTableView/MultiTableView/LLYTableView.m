//
//  LLYTableView.m
//  MultiTableView
//
//  Created by lly on 2017/2/18.
//  Copyright © 2017年 lly. All rights reserved.
//

#import "LLYTableView.h"

@implementation LLYTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


@end
