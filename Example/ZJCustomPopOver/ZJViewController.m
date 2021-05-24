//
//  ZJViewController.m
//  ZJCustomPopOver
//
//  Created by knowNothingJ on 04/22/2021.
//  Copyright (c) 2021 knowNothingJ. All rights reserved.
//

#import "ZJViewController.h"

@interface ZJViewController ()

@end

@implementation ZJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *click = [[UIButton alloc]initWithFrame:CGRectMake(100, 150, 60, 30)];
    [click setTitle:@"点击" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
