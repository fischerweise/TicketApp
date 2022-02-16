//
//  Ticket.swift
//  TicketApp
//
//  Created by Mustafa Pekdemir on 11.02.2022.
//

import Foundation

class TicketModel {
    
    var traveller: TravellerModel
    var date: DateModel
    var time: TimeModel
    var chair: ChairModel
    
    init(traveller: TravellerModel,
         date: DateModel,
         time: TimeModel,
         chair: ChairModel) {
        self.traveller = traveller
        self.date = date
        self.time = time
        self.chair = chair
    }
    
    func printTicket() -> String {
        return "<\(self.traveller.name)><\(self.traveller.surname)><\(self.traveller.id)>,<\(self.date.printDateModel())>,<\(self.time.printTimeModel())>,<\(self.chair.chairID)>"
    }
}
