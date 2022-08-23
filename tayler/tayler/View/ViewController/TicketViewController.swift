//
//  TicketViewController.swift
//  tayler
//
//  Created by 서은수 on 2022/08/21.
//

import UIKit

class TicketViewController: UIViewController {

    // MARK: - Properties
    
    var selectedTicketsIdx: [Int] = []
    
    // MARK: - Subviews
    
    let nextLabel: UILabel = {
        let label = UILabel()
        label.text = "Next"
        label.font = .robotoFont(.robotoMedi, size: 17)
        label.textColor = .black
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Buy Tickets"
        label.font = .robotoFont(.robotoMedi, size: 17)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Outlets
    
    @IBOutlet weak var ticketTableView: UITableView!
    @IBOutlet weak var underTapView: UIView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setAttributes()
        setTableView()
        setLabelTap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Functions
    
    private func setAttributes() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: nextLabel)
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "BackBlackArrow"), style: .plain, target: self, action: #selector(showPrevious(sender:)))
        
        underTapView.layer.cornerRadius = 15
    }
    
    private func setTableView() {
        let nibName = UINib(nibName: "TicketTableViewCell", bundle: nil)
        ticketTableView.register(nibName, forCellReuseIdentifier: TicketTableViewCell.identifier)
        ticketTableView.delegate = self
        ticketTableView.dataSource = self
    }
    
    private func setLabelTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapNextLabel))
        nextLabel.isUserInteractionEnabled = true
        nextLabel.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - @objc Functions
    
    /* 이전 화면으로 돌아가기 */
    @objc
    private func showPrevious(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func tapNextLabel() {
        print("NEXT 버튼 클릭")
        let paymentVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentViewController
        paymentVC.passedData = selectedTicketsIdx
        self.navigationController?.pushViewController(paymentVC, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension TicketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Ticket.ticketList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TicketTableViewCell.identifier, for: indexPath) as? TicketTableViewCell else { return UITableViewCell() }
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .none
        cell.selectedBackgroundView = backgroundView
        
        let item = indexPath.item
        cell.ticketId.text = "#\(Ticket.ticketList[item].num)"
        cell.ticketPrice.text = Ticket.ticketList[item].price
        cell.ticketPercent.text = "\(Ticket.ticketList[item].percent)%"
        cell.ticketUsdPrice.text = "$\(Ticket.ticketList[item].usdPrice)"
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택된 셀 데이터
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? TicketTableViewCell else { return }
        if selectedCell.backgroundColor != .init(hex: 0xF1F1F1) {
            selectedCell.backgroundColor = .init(hex: 0xF1F1F1)
            // 선택된 티켓 배열에 index 추가
            selectedTicketsIdx.append(indexPath.item)
        } else {
            selectedCell.backgroundColor = .white
            selectedTicketsIdx.remove(at: selectedTicketsIdx.firstIndex(of: indexPath.item)!)
        }
        print("현재 selectedTicketsIdx", selectedTicketsIdx)
    }
}
