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

@interface RecordViewController ()
//@property NSMutableDictionary* cache;
//@property NSUInteger defaultLength;
@end

@implementation RecordViewController

-(void)dealloc {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.defaultLength = 10;
    //self.cache = [NSMutableDictionary dictionaryWithCapacity:self.defaultLength];
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
    return [[Record sharedRecord]count];
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecordCell* c = (RecordCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (c == nil) {
        c =(RecordCell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"Cell"];
    }
    c.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary* r = [[Record sharedRecord] recordForIndexPath:indexPath.row];

    if (r[@"sell.price"] != nil) {
        
    }
    
    
    c.trade.text = [NSString stringWithFormat:@"[%@] - asdfasfd;jk;j\n买入：%2@元／股×%2@股", r[@"code"], r[@"buy.price"], r[@"buy.quantity"]];
    

    
    
    if (r[@"result"] < 0) {
        c.result.textColor = [UIColor greenColor];
    }
    else {
        c.result.textColor = [UIColor redColor];
    }
    c.result.text = [NSString stringWithFormat:@"%@ %@ %@", r[@"sell.price"] != nil ? @"损益" : @"保本价",r[@"result"],r[@"sell.price"] != nil ? @"元" : @"元／股"];
    c.datetime.text = r[@"time"];
    //c.textLabel.text = [NSString stringWithFormat:@"[%@] 买入 %@ 元／股 × %@ 股", r[@"code"], r[@"buy.price"], r[@"buy.quantity"]];
    //c.detailTextLabel.text = r[@"time"];
    
    return c;

}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle: indexPath.description message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    return 160;
//}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        
//        UIViewController *controller = (UIViewController *)[[segue destinationViewController] topViewController];
//        controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
//        controller.navigationItem.leftItemsSupplementBackButton = YES;
//    }
}



@end
