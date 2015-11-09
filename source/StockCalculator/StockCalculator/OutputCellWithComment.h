//
//  OutputCellWithComment.h
//  cnstockcalculator
//
//  Created by zuohaitao on 15/10/14.
//  Copyright © 2015年 zuohaitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OutputCellWithComment : UITableViewCell

@property(nonatomic, weak) IBOutlet UILabel* title;
@property(weak, nonatomic) IBOutlet UILabel *result;
@property IBOutlet UIButton* comment;
@end
