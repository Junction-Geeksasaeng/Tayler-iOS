//
//  TicketTableViewCell.swift
//  tayler
//
//  Created by 서은수 on 2022/08/21.
//

import UIKit

struct Ticket {
    var num: String
    var price: String
    var percent: String
    var usdPrice: String
    
    static var ticketList: [Ticket] = [
        Ticket(num: "1", price: "1.1", percent: "12", usdPrice: "11.41"),
        Ticket(num: "2", price: "1.2", percent: "15", usdPrice: "12.41"),
        Ticket(num: "3", price: "1.3", percent: "22", usdPrice: "13.41"),
        Ticket(num: "4", price: "1.4", percent: "17", usdPrice: "14.41"),
        Ticket(num: "5", price: "1.5", percent: "19", usdPrice: "15.41")
    ]
}

class TicketTableViewCell: UITableViewCell {

    static let identifier = "TicketCell"
    
    @IBOutlet weak var ticketId: UILabel!
    @IBOutlet weak var ticketPrice: UILabel!
    @IBOutlet weak var ticketPercent: UILabel!
    @IBOutlet weak var ticketUsdPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
