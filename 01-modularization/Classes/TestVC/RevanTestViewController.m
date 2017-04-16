//
//  RevanTestViewController.m
//  01-modularization
//
//  Created by 紫荆秋雪 on 2017/4/16.
//  Copyright © 2017年 Revan. All rights reserved.
//

#import "RevanTestViewController.h"

@interface RevanTestViewController ()

@end

@implementation RevanTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.tag = 666;
    self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
