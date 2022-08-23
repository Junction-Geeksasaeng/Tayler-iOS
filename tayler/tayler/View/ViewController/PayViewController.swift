//
//  PayViewController.swift
//  tayler
//
//  Created by 서은수 on 2022/08/21.
//

import UIKit

class PayViewController: UIViewController {

    @IBOutlet weak var orderItemsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setAttributes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setAttributes() {
        orderItemsView.layer.cornerRadius = 10
        
        orderItemsView.layer.shadowRadius = 7
        orderItemsView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.13).cgColor
        orderItemsView.layer.shadowOpacity = 1
        orderItemsView.layer.shadowOffset = CGSize(width: 0, height: 0)
        orderItemsView.layer.masksToBounds = false
    }
    
    @IBAction func showPrevious(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapDoneButton(_ sender: Any) {
        let payCompleteVC = self.storyboard?.instantiateViewController(withIdentifier: "PayCompleteVC") as! PayCompleteViewController
        self.navigationController?.pushViewController(payCompleteVC, animated: true)
    }
}
