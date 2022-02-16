//
//  DateModel.swift
//  TicketApp
//
//  Created by Mustafa Pekdemir on 11.02.2022.
//

import Foundation

class DateModel {
    
    var day: Int
    var mounth: Int
    var year: Int
    
    init(day: Int,
         mounth: Int,
         year: Int) {
        self.day = day
        self.mounth = mounth
        self.year = year
    }
    
    func printDateModel() -> String {
        return "\(self.day) / \(self.mounth) / \(self.year)"
    }
    
}
