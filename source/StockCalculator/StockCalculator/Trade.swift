//
//  Trade.swift
//  StockCalculator
//
//  Created by zuohaitao on 15/11/3.
//  Copyright © 2015年 zuohaitao. All rights reserved.
//

import Foundation
@objc(Trade)
class Trade:NSObject {
    var amount:Float = 0.000
    var quantity:Float  = 0.000{
        didSet {
            self.amount = self.price * self.quantity
        }
    }
    
    var price:Float = 0.000{
        didSet {
            self.amount = self.price * self.quantity
        }
    }
}
