//
//  CalculatorViewController.h
//  cnstockcalculator
//
//  Created by zuohaitao on 15/10/13.
//  Copyright © 2015年 zuohaitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController
<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate
>
@property(nonatomic, weak) IBOutlet UITableView* layout;
@property(nonatomic, strong) NSArray* all;
@property(nonatomic, strong) NSMutableArray* cur;
@property(nonatomic, strong) UIButton* keyBoardBackground;
@property(nonatomic, assign) CGPoint layoutOriginContentOffset;
@property(nonatomic, assign) BOOL kindOfTrade;
- (IBAction)changeTradeType:(id)sender;

@end

