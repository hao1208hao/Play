//
//  HHScrollView.m
//  Play
//
//  Created by haohao on 2017/8/30.
//  Copyright © 2017年 haohao. All rights reserved.
//

#import "HHScrollView.h"
#import "UIScrollView+TwitterCover.h"

@interface HHScrollView ()

@property(strong,nonatomic) UIScrollView* scroll;

@end

@implementation HHScrollView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView* scroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scroll = scroll;
    [scroll setContentSize:CGSizeMake(self.view.bounds.size.width, 600)];
    [scroll addTwitterCoverWithImage:[UIImage imageNamed:@"Guide1.jpg"]];
    [self.view addSubview:scroll];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.scroll removeTwitterCoverView];
}
@end
