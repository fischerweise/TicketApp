//
//  ChairModel.swift
//  TicketApp
//
//  Created by Mustafa Pekdemir on 11.02.2022.
//

import Foundation

class ChairModel {
    
    var chairID: Int
    var isBuy: Bool
    var isKeep: Bool
    
    init(isBuy: Bool,
         isKeep: Bool,
         chairID: Int) {
        self.isBuy = isBuy
        self.isKeep = isKeep
        self.chairID = chairID
    }
    
    func isBuyOrKeep() -> Bool {
        var turn: Bool
        if(self.isKeep || self.isBuy) {
            turn = true
        } else {
            turn = false
        }
        return turn
    }
    
}
