//
//  ChairCollectionViewCell.swift
//  TicketApp
//
//  Created by Mustafa Pekdemir on 12.02.2022.
//

import UIKit
import ALBusSeatView

class ChairCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var parentView: UIView! {
        didSet {
            self.parentView.addBorder(borderWidth: 0.1,
                                      color: UIColor.clear.cgColor,
                                      cornerRadius: 5)
        }
    }
    
    @IBOutlet weak var chairLabel: UILabel! {
        didSet {
            self.chairLabel.textColor = UIColor.white
        }
    }
    
    override var isSelected: Bool{
        willSet {
            super.isSelected = newValue
            if newValue {
                self.parentView.backgroundColor = UIColor(hexString: "#141e30")
                self.chairLabel.textColor = UIColor.white
            } else {
                self.parentView.backgroundColor = UIColor.clear
                self.chairLabel.textColor = UIColor.white
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(chair: ChairModel) {
        self.chairLabel.text = "\(chair.chairID)"
    }

}
