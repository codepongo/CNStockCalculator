//
//  SettingController.m
//  StockCalculator
//
//  Created by zuohaitao on 15/12/5.
//  Copyright © 2015年 zuohaitao. All rights reserved.
//

#import "SettingController.h"
#import "StockCalculator-Swift.h"

@interface SettingController ()
@property Rate* rate;
@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rate = [[Rate alloc] init];
    NSLog(@"%@", self.rate);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        if ([key isEqual:@"rate"]) {
            break;
        }
        UILabel* lb = [self valueForKey:key];
        lb.text = [NSString stringWithFormat:@"%.2f ‰", ((NSNumber*)[self.rate valueForKey:key]).floatValue];
    }
    
}

@end
