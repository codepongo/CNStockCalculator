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

@implementation Record
-(id)init {
    if (self = [super init]) {
        self.db = [[SQLiteManager alloc]initWithDatabaseNamed:@"stockcalc.db"];
//        {
//            NSFileManager *f = [NSFileManager defaultManager];
//            BOOL bRet = [f fileExistsAtPath:[self.db getDatabasePath]];
//            if (bRet) {
//                NSError *err;
//                [f removeItemAtPath:[self.db getDatabasePath] error:&err];
//            }
//            self.db = [[SQLiteManager alloc]initWithDatabaseNamed:@"stockcalc.db"];
//
//        }
       NSError *error = [self.db doQuery:@"CREATE TABLE IF NOT EXISTS record (code TEXT, buyingprice FLOAT, buyingamount FLOAT, sellingprice FLOAT, sellingamount FLOAT, commission FLOAT, stamp FLOAT, transfer FLOAT, taxandduties FLOAT, gainorlost FLOAT, breakevenprice FLOAT, commissionrate FLOAT, stamprate FLOAT, transferrate FLOATß);"];
        
        if (error != nil) {
            NSLog(@"Error: %@",[error localizedDescription]);
            return nil;
        }
        
        //NSLog(@"%@",[self.db getDatabaseDump]);
        
        return self;
    }
    return nil;
}
//
//-(BOOL)add:(NSDictionary*)record {
//    NSString* code = [record objectForKey:@"code"];
//    Trade* buy = [[Trade alloc]init];
//    buy.price = ((NSNumber*)[record objectForKey:@"buyingprice"]).floatValue;
//    return YES;
//    
//}


@end
