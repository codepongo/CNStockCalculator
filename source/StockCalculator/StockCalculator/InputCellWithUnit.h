//
//  InputCell.h
//  cnstockcalculator
//
//  Created by zuohaitao on 15/10/14.
//  Copyright © 2015年 zuohaitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InputCellWithUnit : UITableViewCell

@property(nonatomic, weak) IBOutlet UITextField* input;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property(weak, nonatomic) IBOutlet UILabel* unit;
- (IBAction)edit:(id)sender;
@end
