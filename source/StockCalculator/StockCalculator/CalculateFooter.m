//
//  CalculateCell.m
//  StockCalculator
//
//  Created by zuohaitao on 15/10/17.
//  Copyright © 2015年 zuohaitao. All rights reserved.
//

#import "CalculateFooter.h"

@interface CalculateFooter ()

@end

@implementation CalculateFooter
@synthesize calculate;
@synthesize reset;
-(void) layoutSubviews {
    [self.contentView setFrame:CGRectMake(0, 0, self.frame.size.width, self.contentView.frame.size.height)];
}

@end
