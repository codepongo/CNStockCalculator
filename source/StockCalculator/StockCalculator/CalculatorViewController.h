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
@property(nonatomic, strong) NSArray* titles;
@property(nonatomic, strong) UIButton* keyBoardBackground;
@property(nonatomic, assign) CGPoint layoutOriginContentOffset;
- (IBAction)changeTradeType:(id)sender;

@end

