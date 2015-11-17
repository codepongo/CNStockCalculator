//
//  Record.h
//  StockCalculator
//
//  Created by jack on 15/11/11.
//  Copyright © 2015年 zuohaitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLiteManager.h"

@interface Record : NSObject
@property SQLiteManager* db;
+ (instancetype) sharedRecord;
- (bool)add:(NSDictionary*)record;
- (NSUInteger)count;
-(NSDictionary*)recordForIndexPath:(NSInteger)indexPath;
- (void)removeAtIndex:(NSInteger)index;
@end
static Record* instance;