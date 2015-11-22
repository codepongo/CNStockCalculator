//
//  CalculateBrain.swift
//  StockCalculator
//
//  Created by zuohaitao on 15/11/22.
//  Copyright © 2015年 zuohaitao. All rights reserved.
//

import Foundation

@objc(CalculateBrain_)
class CalculateBrain_:NSObject {
    var code:String = ""
    var buy:Trade = Trade()
    var sell:Trade? = nil
    var rate:Rate = Rate()
    var commission:Float = 0.000
    var stamp:Float = 0.000
    var transfer:Float? = nil
    var inSZ:Bool {
        get {
            return self.transfer == nil
        }
        set {
            if newValue {
                self.transfer = nil
            }
            else {
                self.transfer = 0.000
            }
        }
    }
    var calculateForGainOrLoss:Bool {
        set {
            if newValue {
                self.sell = Trade()
            }
            else {
                self.sell = nil;
            }
        }
        get {
            return (self.sell != nil)
        }
    }
    func commission(amount:Float) -> Float {
        if amount == 0 {
            return 0.000
        }
        if amount < 10000.00 {
            return 5.000
        }
        
        return (amount * (self.rate.commssion / 1000))
        
    }
    func stamp(amount:Float) -> Float{
        if amount == 0 {
            return 0.000
        }
        if amount < 1000.00 {
            return 1.000
        }
        return amount * (self.rate.stamp / 1000)
    }
    func transfer(quantity:Float) -> Float {
        if self.transfer == nil {
            return 0.000
        }
        var transfer:Float = (quantity % 1000 == 0) ? 0: 1
        transfer += (quantity / 1000) * self.rate.transfer
        return transfer
    }
    
    func calculate() -> (Float, Float, Float, Float, Float) {
        self.commission = self.commission(self.buy.amount()) + (self.sell != nil ? self.commission(self.sell!.amount()): 0)
        self.stamp = self.sell != nil ? self.stamp(self.sell!.amount()) : self.stamp(self.buy.amount())
        if self.transfer != nil {
            self.transfer = self.transfer(Float(self.buy.quantity)) + (self.sell != nil ? self.transfer(Float(self.sell!.quantity)): 0)
        }
        let fee:Float = self.commission + self.stamp + self.transfer!
        let cost:Float = self.buy.amount() + fee
        let income = self.sell!.amount()
        var result:Float = 0.000
        if self.sell == nil {
            if self.buy.quantity != 0 {
                result = cost/Float(self.buy.quantity)
            }

        }
        else {
            result = income - cost
        }
        return (self.commission, self.stamp, self.transfer!, fee, result)
    }
    
}