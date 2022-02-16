//
//  SeatViewController.swift
//  TicketApp
//
//  Created by Mustafa Pekdemir on 15.02.2022.
//

import UIKit
import ALBusSeatView

class SeatViewController: UIViewController {
    @IBOutlet var seatView: UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    class SeatViewController: UIViewController {
        
        @IBOutlet weak var seatView: ALBusSeatView!
        var dataManager = SeatDataManager()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            seatView.config = ExampleSeatConfig()
            seatView.delegate = dataManager
            seatView.dataSource = dataManager
            
            let mock = MockSeatCreater()
            let first = mock.create(count: 45)
            let second = mock.create(count: 45)
            dataManager.seatList = [first,second]
            seatView?.reload()
        }

    }
}
