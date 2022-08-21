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
