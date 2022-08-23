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
    var ownerList:[String] = ["Owner : Haily", "Owner : Eunsu Seo", "Owner : Neo"]
    
    @IBOutlet weak var shoppingCartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setPassedData()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Functions
    
    private func setPassedData() {
        for i in passedData {
            payTicketList.append(Ticket.ticketList[i])
        }
    }
    
    private func setTableView() {
        let nibName = UINib(nibName: "ShoppingCartTableViewCell", bundle: nil)
        shoppingCartTableView.register(nibName, forCellReuseIdentifier: ShoppingCartTableViewCell.identifier)
        shoppingCartTableView.delegate = self
        shoppingCartTableView.dataSource = self
    }
    
    /* 이전 화면으로 돌아가기 */
    @IBAction func showPrevious(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showNextView(_ sender: Any) { 
        let payVC = self.storyboard?.instantiateViewController(withIdentifier: "PayVC") as! PayViewController
        self.navigationController?.pushViewController(payVC, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension PaymentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payTicketList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingCartTableViewCell.identifier, for: indexPath) as? ShoppingCartTableViewCell else { return UITableViewCell() }
        
        let item = indexPath.item
        cell.ticketId.text = "#\(payTicketList[item].num)"
        cell.ticketPrice.text = payTicketList[item].price
        cell.ticketPercent.text = "\(payTicketList[item].percent)%"
        cell.ticketUsdPrice.text = "$\(payTicketList[item].usdPrice)"
        cell.ticketOwner.text = "Owner : \(ownerList[item])"
        
        return cell
    }
}
