//
//  Record.m
//  StockCalculator
//
//  Created by jack on 15/11/11.
//  Copyright © 2015年 zuohaitao. All rights reserved.
//

#import "Record.h"

@interface SQLiteManager(stockCalc)
-(NSString* )databaseName;
@end

@implementation SQLiteManager(stockCalc)

-(NSString* )databaseName {
    return self->databaseName;
}

@end

@implementation Record
-(id)init {
    if (self = [super init]) {
        self.db = [[SQLiteManager alloc]initWithDatabaseNamed:@"stockcalc.db"];
        {
            NSFileManager *f = [NSFileManager defaultManager];
            BOOL bRet = [f fileExistsAtPath:[self.db databaseName]];
            if (bRet) {
                NSError *err;
                [f removeItemAtPath:[self.db databaseName] error:&err];
            }
            self.db = [[SQLiteManager alloc]initWithDatabaseNamed:@"stockcalc.db"];

        }
        [self.db openDatabase];
        NSError *error = [self.db doQuery:@"\
                          CREATE TABLE IF NOT EXISTS records (\
                          coder TEXT DEFAULT,\
                          buyprice FLOAT DEFAULT, \
                          buyacount FLOAT DEFAULT, \
                          sellprice FLOAT DEFAULT, \
                          sellaccount FLOAT DEFAULT,\
                          commission FLOAT DEFAULT,\
                          rate FLOAT DEFAULT,\
                          transfer FLOAT DEFAULT\
                          );"];
        if (error != nil) {
            NSLog(@"Error: %@",[error localizedDescription]);
        }
        
        NSLog(@"%@",[self.db getDatabaseDump]);
        
        return self;
    }
    return nil;
}


@end
