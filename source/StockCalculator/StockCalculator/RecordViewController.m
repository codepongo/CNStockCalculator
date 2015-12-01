//
//  RecordViewController.m
//  cnstockcalculator
//
//  Created by zuohaitao on 15/10/13.
//  Copyright © 2015年 zuohaitao. All rights reserved.
//

#import "RecordViewController.h"
#import "Record.h"
#import "RecordCell.h"
#import "public.h"
#import "RecordDetail.h"

@interface RecordViewController ()
//@property NSMutableDictionary* cache;
//@property NSUInteger defaultLength;
@end

@implementation RecordViewController

-(void)dealloc {
}

-(void)viewWillAppear:(BOOL)animated {
    //self.navigationItem.title = @"全部纪录";
    [super viewWillDisappear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    //self.navigationItem.title = @"";
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver: self.view selector: @selector(reloadData) name: @"recordChanged" object: nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView * _Nonnull)tableView
 numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [[Record sharedRecord]count];
    if (count == 0) {
        self.edit.enabled = NO;
        self.edit.title = @"编辑";
    }
    else {
        self.edit.enabled = YES;
    }
    return count;
}

- (BOOL)tableView:(UITableView * _Nonnull)tableView canEditRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath {
    return YES;
}

- (void)tableView:(UITableView * _Nonnull)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath {
    [[Record sharedRecord] removeAtIndex:[(UITableView*)self.view cellForRowAtIndexPath:indexPath].tag];
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecordCell* c = (RecordCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (c == nil) {
        c =(RecordCell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"Cell"];
    }
    //c.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary* r = [[Record sharedRecord] recordForIndexPath:indexPath.row];

    if (r[@"sell.price"] != [NSNull null]) {
        c.image.image = [UIImage imageNamed:@"gainorlose"];
    }
    else {
        c.image.image = [UIImage imageNamed:@"breakeven"];

    }
    
   c.trade.text = [NSString stringWithFormat: @"[%@] - 单价为%.2f元时，买入%@股。", r[@"code"],((NSNumber*)r[@"buy.price"]).floatValue, r[@"buy.quantity"]];
    if (r[@"sell.price"] != [NSNull null]) {
        c.trade.text = [NSString stringWithFormat:@"%@ 单价为%.2f元时，卖出%@股。", c.trade.text, ((NSNumber*)r[@"sell.price"]).floatValue, r[@"sell.quantity"]];
    }

    
    
//    if (((NSNumber*)r[@"result"]).floatValue < 0) {
//        c.result.textColor = DOWN_COLOR;
//    }
//    else {
//        c.result.textColor = UP_COLOR;
//    }
    c.result.text = [NSString stringWithFormat:@"%@： %.2f %@", r[@"sell.price"] != [NSNull null] ? @"交易损益" : @"保本价格",((NSNumber*)r[@"result"]).floatValue,r[@"sell.price"] != [NSNull null] ? @"元" : @"元／股"];
    c.datetime.text = r[@"time"];
    //c.textLabel.text = [NSString stringWithFormat:@"[%@] 买入 %@ 元／股 × %@ 股", r[@"code"], r[@"buy.price"], r[@"buy.quantity"]];
    //c.detailTextLabel.text = r[@"time"];
    c.tag = ((NSNumber*)r[@"rowid"]).intValue;
    
    return c;

}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle: indexPath.description message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView * _Nonnull)tableView editingStyleForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath {
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"RecordDetail"]) {
       NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary* r = [[Record sharedRecord] recordForIndexPath:indexPath.row];
        
        RecordDetail* detail = (RecordDetail *)[segue destinationViewController];
        detail.data = r;
    }
}

#pragma action

-(IBAction)edit:(id)sender {
    [(UITableView*)self.view setEditing:!((UITableView*)self.view).editing animated:YES];
    if (((UITableView*)self.view).editing)
    {
        self.edit.title = @"完成";
    }
    else {
        self.edit.title = @"编辑";
    }
}

@end
