//
//  TabBarController.m
//  StockCalculator
//
//  Created by zuohaitao on 15/10/18.
//  Copyright © 2015年 zuohaitao. All rights reserved.
//

#import "TabBarController.h"
#import "Record.h"

@interface TabBarController ()
@property Record* record;
@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedIndex = 1;
    self.extendedLayoutIncludesOpaqueBars = NO;
    // Do any additional setup after loading the view.
    self.record = [[Record alloc]init];
    
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
