//
//  Record.m
//  StockCalculator
//
//  Created by jack on 15/11/11.
//  Copyright © 2015年 zuohaitao. All rights reserved.
//

#import "Record.h"
#import "Rate.h"
#import "StockCalculator-Swift.h"
@interface Record()
-(instancetype)init;
@end
@implementation Record
+ (instancetype)sharedRecord {
    @synchronized(self) {
        if (instance == nil) {
            instance = [[Record alloc] init];
            return instance;
        }
        return instance;
    }
}

-(instancetype)init {
    if (self = [super init]) {
        self.db = [[SQLiteManager alloc]initWithDatabaseNamed:@"stockcalc.db"];

        {
            NSFileManager *f = [NSFileManager defaultManager];
            BOOL bRet = [f fileExistsAtPath:[self.db getDatabasePath]];
            if (bRet) {
                NSError *err;
                [f removeItemAtPath:[self.db getDatabasePath] error:&err];
            }
            self.db = [[SQLiteManager alloc]initWithDatabaseNamed:@"stockcalc.db"];
            
        }

//        NSString* sqlSentence = @"CREATE TABLE IF NOT EXISTS record (code TEXT, buy.price FLOAT, buy.quantity FLOAT, sell.price FLOAT, sell.quantity FLOAT, commission FLOAT, stamp FLOAT, transfer FLOAT, taxandduties FLOAT, gainorlost FLOAT, breakevenprice FLOAT, commissionrate FLOAT, stamprate FLOAT, transferrate FLOAT);";
        NSString* sqlSentence = @"CREATE TABLE IF NOT EXISTS record ([code] TEXT, [buy.price] FLOAT, [buy.quantity] FLOAT, [sell.pirce] FLOAT, [sell.quantity] FLOAT, [rate.commission] FLOAT, [rate.stamp] Float, [rate.transfer] Float,[commission] FLOAT, [stamp] Float, [transfer] Float, [fee] FLOAT, [gainorloss] FLOAT, [breakevenprice] FLOAT, [time] TimeStamp NOT NULL DEFAULT (datetime('now','localtime')));";
        
        NSError *error = [self.db doQuery:sqlSentence];
        
        if (error != nil) {
            NSLog(@"Error: %@",[error localizedDescription]);
            return nil;
        }
        
        NSLog(@"%@",[self.db getDatabaseDump]);
        
        return self;
    }
    return nil;
}

-(BOOL)add:(NSDictionary*)record{

    NSArray* values = [NSArray arrayWithArray:[record allValues]];
    for (id v in values) {
        if ([[v class] isEqual:@"NSString"]) {
            NSString* value = (NSString*)v;
            value = [NSString stringWithFormat:@"'%@'", v];
        }
    }
    
    NSString *sqlSentence = [NSString stringWithFormat:@"INSERT INTO record (%@) values (%@);",[[record allKeys] componentsJoinedByString:@","], [values componentsJoinedByString:@","]];

    NSError *error = [self.db doQuery:sqlSentence];
    if (error != nil) {
        NSLog(@"Error: %@",[error localizedDescription]);
    }
    
    NSString *dump = [self.db getDatabaseDump];
    NSLog(@"%@", dump);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"recordChanged" object:nil];
    return YES;
    
}

-(NSUInteger)count {
    NSArray* r = [self.db getRowsForQuery:@"SELECT count(*) FROM record"];
    return ((NSNumber*)r[0][@"count(*)"]).integerValue;
}

-(NSArray*)getRecords:(NSRange)range {
    NSString* sql = [NSString stringWithFormat:@"SELECT * FROM record ORDER BY ROWID DESC LIMIT %ld OFFSET %ld",  range.length, range.location];
    NSArray* r = [self.db getRowsForQuery:sql];
    return r;
}

-(NSDictionary*)recordForIndexPath:(NSInteger)indexPath {
    NSRange range = {indexPath, 1};
    NSArray* r = [self getRecords:range];
    return r[0];
    
}
-(void)removeAtIndex:(NSInteger)index {
    NSString *sqlSentence = [NSString stringWithFormat:@"DELETE record WHERE index=%ld", index];
    
    NSError *error = [self.db doQuery:sqlSentence];
    if (error != nil) {
        NSLog(@"Error: %@",[error localizedDescription]);
    }
    
    NSString *dump = [self.db getDatabaseDump];
    NSLog(@"%@", dump);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"recordChanged" object:nil];
    return;
}

@end
