//
//  ResearchRecordViewController.m
//  StockCalculator
//
//  Created by jack on 15/12/3.
//  Copyright © 2015年 zuohaitao. All rights reserved.
//

#import "ResearchRecordViewController.h"

@implementation ResearchRecordViewController

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView * _Nonnull)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"text";
    return cell;
    
}

@end
