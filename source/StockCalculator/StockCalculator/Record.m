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
/*
        {
            NSFileManager *f = [NSFileManager defaultManager];
            BOOL bRet = [f fileExistsAtPath:[self.db getDatabasePath]];
            if (bRet) {
                NSError *err;
                [f removeItemAtPath:[self.db getDatabasePath] error:&err];
            }
            self.db = [[SQLiteManager alloc]initWithDatabaseNamed:@"stockcalc.db"];
            
        }
*/
//        NSString* sqlSentence = @"CREATE TABLE IF NOT EXISTS record (code TEXT, buy.price FLOAT, buy.quantity FLOAT, sell.price FLOAT, sell.quantity FLOAT, commission FLOAT, stamp FLOAT, transfer FLOAT, taxandduties FLOAT, gainorlost FLOAT, breakevenprice FLOAT, commissionrate FLOAT, stamprate FLOAT, transferrate FLOAT);";
        NSString* sqlSentence = @"CREATE TABLE IF NOT EXISTS record ([code] TEXT, [time] TimeStamp NOT NULL DEFAULT (datetime('now','localtime')));";
        
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
    NSString* code = [record objectForKey:@"code"];
//    Trade* buy = [[Trade alloc]init];
//    buy.price = ((NSNumber*)[record objectForKey:@"buy.price"]).floatValue;
//    buy.quantity = ((NSNumber*)[record objectForKey:@"buy.quantity"]).floatValue;
//    
//    Trade* sell = [[Trade alloc]init];
//    sell.price = ((NSNumber*)[record objectForKey:@"sell.price"]).floatValue;
//    sell.quantity = ((NSNumber*)[record objectForKey:@"sell.quantity"]).floatValue;
//    Rate* rate = [[Rate alloc] init];
//    rate.commission = ((NSNumber*)[record objectForKey:@"rate.commission"]).floatValue;
//    rate.stamp = ((NSNumber*)[record objectForKey:@"rate.stamp"]).floatValue;
//    rate.transfer = ((NSNumber*)[record objectForKey:@"rate.transfer"]).floatValue;
//    
//    float commission = ((NSNumber*)[record objectForKey:@"commission"]).floatValue;
//    float stamp = ((NSNumber*)[record objectForKey:@"stamp"]).floatValue;
//    float transfer = ((NSNumber*)[record objectForKey:@"transfer"]).floatValue;
//    float taxAndDuties = ((NSNumber*)[record objectForKey:@"taxandduties"]).floatValue;
//    NSString* gainOrLoss = @"null";
//    {
//        NSNumber* result = [record objectForKey:@"gainorlost"];
//        if (result != nil) {
//            gainOrLoss = [NSString stringWithFormat:@"'%@'", result.stringValue];
//            
//        }
//    }
//    NSString* breakevenPrice = @"null";
//    {
//        NSNumber* result = [record objectForKey:@"breakevenprice"];
//        if (result != nil) {
//            breakevenPrice = [NSString stringWithFormat:@"'%@'", result.stringValue];
//        }
//    }
    NSString *sqlSentence = [NSString stringWithFormat:@"INSERT INTO record (code) values ('%@');",code];
    
//    NSString *sqlSentence = [NSString stringWithFormat:@"INSERT INTO record (code, buy.price, buy.quantity, sell.price, sell.quantity, rate.commission, rate.stamp, rate.transfer, commission, stamp, transfer, taxandduties, gainorlost, breakevenprice) values ('%@',%f, %f, %f, %f, %f,%f,%f, %f,%f, %f,%f, %@, %@);",code, buy.price, buy.quantity, sell.price, sell.quantity, rate.commission, rate.stamp, rate.transfer, commission, stamp, transfer,taxAndDuties, gainOrLoss, breakevenPrice];
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
