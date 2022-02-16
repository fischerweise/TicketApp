//
//  TicketListViewController.swift
//  TicketApp
//
//  Created by Mustafa Pekdemir on 13.02.2022.
//

import Foundation
import UIKit
import ALBusSeatView

class TicketListViewController: UIViewController {
    
    @IBOutlet weak var parentView: UIView!
    
    @IBOutlet weak var gradiendView: GradientView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var ticketList: [TicketModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "TicketTableViewCell", bundle: nil),
                                forCellReuseIdentifier: TicketTableViewCell.identify)
    }
}

extension TicketListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ticketList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TicketTableViewCell = tableView.dequeueReusableCell(withIdentifier: TicketTableViewCell.identify) as! TicketTableViewCell

        cell.setCell(ticket: self.ticketList[indexPath.row])
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
