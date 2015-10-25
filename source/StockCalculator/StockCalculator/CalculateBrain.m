//
//  CalculateBrain.m
//  StockCalculator
//
//  Created by zuohaitao on 15/10/25.
//  Copyright © 2015年 zuohaitao. All rights reserved.
//

#import "CalculateBrain.h"

#pragma mark -
#pragma mark Rate
@implementation Rate
-(instancetype)init{
    self = [super init];
    self.stamp = 0.001;
    return self;
}
@end

#pragma mark -
#pragma mark Trade

@implementation Trade
-(void)setPrice:(float)p {
    self.price = p;
    self->_amount = p * self.quantity;
}

-(void)setQuantity:(NSInteger)q {
    self.quantity = q;
    self->_amount = self.price * q;
}

-(instancetype) initWithPrice:(float)p AndAmount:(float)q {
    self = [super init];
    self.price = p;
    self.quantity = q;
    self->_amount = price * quantity;
    return self;
}
@synthesize price, quantity, amount = _amount;
@end

#pragma mark -
#pragma mark CalculateBrain

@interface CalculateBrain()
-(float)commission:(float)amount;
-(float)stamp:(float)amount;
-(float)transfer:(float)quantity;
@end

@implementation CalculateBrain
- (instancetype) init {
    self = [super init];
    self.inSZ = NO;
    self.calculateForGainOrLost = YES;
    return self;
}


- (float) commission:(float)amount {
    if (amount <= 10000.000) {
        return 5.000;
    }
    return (amount * self.rate.commission);
}

-(float)stamp:(float)amount {
    float stamp = 1.000;
    if (amount * 0.001 > stamp) {
        stamp = amount * self.rate.stamp;
    }
    return stamp;

}

-(float)transfer:(float)quantity {
    if (self.inSZ) {
        return 0;
    }
    int transfer = (int)quantity % 1000 == 0 ? 0:1;
    transfer += (int)quantity / 1000;
    return transfer;
}

-(float)commissionOfTrade {
    if (!self.calculateForGainOrLost) {
        return [self commission:self.buy.amount];
    }
    return  [self commission:self.buy.amount] + [self commission:self.sell.amount];
}

-(float)stampOfTrade {
    if (!self.calculateForGainOrLost) {
        return [self stamp:self.buy.amount];
    }
    return [self stamp:self.sell.amount];
}

-(float)transferOfTrade {
    if (!self.calculateForGainOrLost) {
        return [self transfer:self.buy.quantity];
    }
    return [self transfer:self.buy.quantity] + [self transfer:self.buy.quantity];
}

-(float)taxesAndDutiesOfTrade {
    return [self commissionOfTrade] + [self stampOfTrade] + [self transferOfTrade];
}

@end