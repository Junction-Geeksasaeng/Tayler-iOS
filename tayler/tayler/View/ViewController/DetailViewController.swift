//
//  DetailViewController.swift
//  tayler
//
//  Created by 서은수 on 2022/08/20.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var auctionImage: UIImage!
    
    // MARK: - Outlets
    
    @IBOutlet weak var auctionImageView: UIImageView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setNavigationBar()
        setAttributes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }

    // MARK: - Functions
    
    private func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "ShareImage")))
        self.navigationItem.title = "Auction Detail"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "BackArrow"), style: .plain, target: self, action: #selector(showPrevious(sender:)))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.robotoFont(.robotoMedi, size: 17),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]

        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
    
    private func setAttributes() {
        // 받은 데이터로 이미지 설정
        auctionImageView.image = auctionImage
        
        // 이미지의 왼쪽, 오른쪽 하단의 코너에만 cornerRadius를 적용
        auctionImageView.layer.masksToBounds = true
        auctionImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        auctionImageView.layer.cornerRadius = 30
    }
    
    // MARK: - @objc Functions
    
    /* 이전 화면으로 돌아가기 */
    @objc
    private func showPrevious(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
