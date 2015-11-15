//
//  RecordViewController.m
//  cnstockcalculator
//
//  Created by zuohaitao on 15/10/13.
//  Copyright © 2015年 zuohaitao. All rights reserved.
//

#import "RecordViewController.h"
#import "Record.h"

@interface RecordViewController ()
@property NSString* cellId;
@property NSMutableDictionary* cache;
@property NSUInteger defaultLength;
@end

@implementation RecordViewController

-(void)dealloc {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.defaultLength = 10;
    self.cache = [NSMutableDictionary dictionaryWithCapacity:self.defaultLength];
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
    UITableViewCell* c = [tableView dequeueReusableCellWithIdentifier:self.cellId];
    if (c == nil) {
        c =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:self.cellId];
    }
    NSDictionary* r = [[Record sharedRecord] recordForIndexPath:indexPath.row];
//    NSRange range = {indexPath.row, self.defaultLength};
//    NSInteger idx = range.location;
//    NSDictionary* d = [self.cache objectForKey:[NSNumber numberWithInteger:indexPath.row]];
//    if (nil == d) {
//        NSArray* records = [[Record sharedRecord] getRecords:range];
//        for (NSMutableDictionary* r in records) {
//            [self.cache setObject:[r copy] forKey:[NSNumber numberWithInteger:idx]];
//            idx++;
//        }
//    }
//    d = [self.cache objectForKey:[NSNumber numberWithInteger:indexPath.row]];

    c.textLabel.text =  r[@"code"];
    c.detailTextLabel.text = r[@"time"];
    return c;
//    NSDictionary* item = self.cur[indexPath.section][indexPath.row];
//    NSString* cellId = item[@"cellReuseIdentifier"];
//    if (cellId == nil) {
//        return nil;
//    }
//    if ([cellId  isEqual: @"InputCell"]) {
//        InputCell* c = [tableView dequeueReusableCellWithIdentifier:cellId];
//        c.title.text = self.cur[indexPath.section][indexPath.row][@"title"];
//        c.input.delegate = self;
//        NSNumber* v = (NSNumber*)[self.brain valueForKeyPath:item[@"value"]];
//        if (v != nil && [v floatValue] != 0) {
//            c.input.text = [NSString stringWithFormat:@"%g %@",[v floatValue], item[@"unit"]];
//        }
//        else {
//            c.input.text = @"";
//        }
//        c.input.placeholder = item[@"placeholder"];
//        c.input.keyboardType = [item[@"inputtype"] integerValue];
//        
//        InputAccessory* a = [[[NSBundle mainBundle]loadNibNamed:@"InputAccessory" owner:nil options:nil] objectAtIndex:0];
//        a.done.action = @selector(hideKeyBoard);
//        //[a.done addTarget:self action:@selector(hideKeyBoard) forControlEvents:UIControlEventTouchUpInside];
//        c.input.inputAccessoryView = a;
//        return c;
//    }
//    if ([cellId  isEqual: @"InputCellWithUnit"]) {
//        InputCellWithUnit* c = [tableView dequeueReusableCellWithIdentifier:cellId];
//        c.title.text = self.cur[indexPath.section][indexPath.row][@"title"];
//        c.input.delegate = self;
//        c.input.placeholder = [NSString stringWithFormat:@"%@%@", item[@"placeholder"],item[@"unit"]];
//        c.input.keyboardType = [item[@"inputtype"] integerValue];
//        c.unit.text = item[@"unit"];
//        return c;
//    }
//    if ([cellId  isEqual: @"ButtonCell"]) {
//        ButtonCell* c = [tableView dequeueReusableCellWithIdentifier:cellId];
//        c.title.text = self.cur[indexPath.section][indexPath.row][@"title"];
//        self.marketOfStock = c.button;
//        [c.button addTarget:self action:@selector(selectMarketOfStock:) forControlEvents:UIControlEventTouchUpInside];
//        //        c.button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        [c.button setTitle:self.pickerData[self.selectedIndexInSheet] forState:UIControlStateNormal];
//        
//        return c;
//    }
//    if ([cellId  isEqual: @"OutputCell"]) {
//        OutputCell* c = [tableView dequeueReusableCellWithIdentifier:@"OutputCell"];
//        NSString* title = self.cur[indexPath.section][indexPath.row][@"title"];
//        if (nil != title) {
//            c.title.text = title;
//            
//            NSString* instruction = self.cur[indexPath.section][indexPath.row][@"instruction"];
//            if (instruction != nil) {
//                UIImage* image = [UIImage imageNamed:@"instruction"];
//                UIButton *b = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32,c.contentView.frame.size.height)];
//                [b setImage:image forState:UIControlStateNormal];
//                [b addTarget:self action:@selector(showInstruction:) forControlEvents:UIControlEventTouchUpInside];
//                
//                c.accessoryView = b;//[[UIImageView alloc] initWithImage:image];
//                //c.bounds =
//                
//                
//                //c.accessoryType = UITableViewCellAccessoryDetailButton;
//            }
//            else {
//                UIView* v = [[UIView alloc]initWithFrame:CGRectMake(0,0,32,c.contentView.frame.size.height)];
//                c.accessoryView = v;
//            }
//        }
//        else {
//            if ([self.brain calculateForGainOrLoss]) {
//                c.title.text = self.cur[indexPath.section][indexPath.row][@"titleForGainOrLoss"];
//            }
//            else {
//                c.title.text = self.cur[indexPath.section][indexPath.row][@"titleForBreakevenPrice"];
//            }
//            
//            float r = [self.brain resultOfTrade];
//            if (r < 0) {
//                c.result.textColor =[UIColor greenColor];
//            }
//            else if (r > 0) {
//                c.result.textColor = [UIColor redColor];
//            }
//            else {
//                c.result.textColor = [UIColor blackColor];
//            }
//            UIView* v = [[UIView alloc]initWithFrame:CGRectMake(0,0,32,c.contentView.frame.size.height)];
//            c.accessoryView = v;
//            
//        }
//        c.result.text = self.cur[indexPath.section][indexPath.row][@"value"];
//        return c;
//    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return tableView.sectionHeaderHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return tableView.sectionFooterHeight;
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    return tableView.tableFooterView;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle: indexPath.description message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}





@end
