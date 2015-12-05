//
//  SettingDetailController.m
//  StockCalculator
//
//  Created by zuohaitao on 15/12/5.
//  Copyright © 2015年 zuohaitao. All rights reserved.
//

#import "SettingDetailController.h"

@interface SettingDetailController ()

@end

@implementation SettingDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rate = [[Rate alloc] init];
    self.edit.keyboardType = UIKeyboardTypeNumberPad;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.edit.text = [NSString stringWithFormat:@"%.2f", ((NSNumber*)[self.rate valueForKey:self.k]).floatValue];
    [self.edit becomeFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    [self.rate setValue:[NSNumber numberWithFloat:self.edit.text.floatValue ] forKey:self.k];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
