//
//  PaymentViewController.swift
//  tayler
//
//  Created by 서은수 on 2022/08/21.
//

import UIKit

class PaymentViewController: UIViewController {

    var passedData: [Int]!
    var payTicketList: [Ticket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setPassedData()
    }
    
    private func setPassedData() {
        for i in passedData {
            payTicketList.append(Ticket.ticketList[i])
        }
    }

}
