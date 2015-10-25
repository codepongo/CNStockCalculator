//
//  CalculateBrain.h
//  StockCalculator
//
//  Created by zuohaitao on 15/10/25.
//  Copyright © 2015年 zuohaitao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rate:NSObject
@property (nonatomic) float commission;
@property (nonatomic) float stamp;
@property (nonatomic) float transfer;
@end

@interface Trade:NSObject {
    float _amount;
}
@property (nonatomic) float price;
@property (nonatomic) NSInteger quantity;
@property (nonatomic, readonly) float amount;
-(instancetype) initWithPrice:(float)price AndAmount:(float)quantity;
@end

@interface CalculateBrain : NSObject
@property (nonatomic, copy) NSString* code;
@property(nonatomic) BOOL inSZ;
@property(nonatomic) BOOL calculateForGainOrLost;
@property (nonatomic, strong) Rate* rate;
@property (nonatomic, strong) Trade* buy;
@property (nonatomic, strong) Trade* sell;
-(float)commissionOfTrade;
-(float)stampOfTrade;
-(float)transferOfTrade;
-(float)taxesAndDuties;
@end
