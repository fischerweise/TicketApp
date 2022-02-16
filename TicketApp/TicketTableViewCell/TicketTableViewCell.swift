//
//  TicketTableViewCell.swift
//  TicketApp
//
//  Created by Mustafa Pekdemir on 13.02.2022.
//

import UIKit

class TicketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var parentView: UIView! {
        didSet {
            self.parentView.addBorder(borderWidth: 1,
                                      color: UIColor.white.cgColor,
                                      cornerRadius: 10)
            self.parentView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        }
    }
    
    @IBOutlet weak var surname: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var accountId: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    static let identify = "TicketTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(ticket: TicketModel) {
        self.name.text = ticket.traveller.name
        self.surname.text = ticket.traveller.surname
        self.accountId.text = "\(ticket.traveller.id)"
        self.date.text = ticket.date.printDateModel()
    }
    
}
