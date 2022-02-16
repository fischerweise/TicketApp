//
//  TimeModel.swift
//  TicketApp
//
//  Created by Mustafa Pekdemir on 11.02.2022.
//

import Foundation

class TimeModel {
    
    var hour: Int
    var minute: Int
    
    init(hour: Int,
         minute: Int) {
        self.hour = hour
        self.minute = minute
    }
    
    func printTimeModel() -> String {
        return "\(self.hour) : \(self.minute)"
    }
    
}
