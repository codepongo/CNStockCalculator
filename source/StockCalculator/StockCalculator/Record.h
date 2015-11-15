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
-(NSArray*)getRecords:(NSRange)range;
-(NSDictionary*)recordForIndexPath:(NSInteger)indexPath;
@end
static Record* instance;