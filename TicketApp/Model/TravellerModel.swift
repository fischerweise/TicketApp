//
//  TravellerModel.swift
//  TicketApp
//
//  Created by Mustafa Pekdemir on 11.02.2022.
//

import Foundation

class TravellerModel {
    
    var name: String
    var surname: String
    var id: Int
    
    init(name: String,
         surname: String,
         id: Int) {
        self.name = name
        self.surname = surname
        self.id = id
    }
    
    func printTraveller() -> String {
        return "\(self.name)-\(self.surname)-\(self.id)"
    }
    
}
