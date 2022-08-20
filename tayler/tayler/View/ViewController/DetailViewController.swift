//
//  DetailViewController.swift
//  tayler
//
//  Created by 서은수 on 2022/08/20.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var auctionImage: UIImage!
    var timeDataArray = ["04", "01", "45", "17"]
    var timeUnitArray = ["Days", "Hours", "Minutes", "Seconds"]
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var auctionImageView: UIImageView!
    @IBOutlet weak var timeCollectionView: UICollectionView!
    
    @IBOutlet weak var explainLabel: UILabel!
    
    @IBOutlet weak var buyTicketView: UIView!
    @IBOutlet weak var underTapView: UIView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setNavigationBar()
        setAttributes()
        setLayouts()
        setCollectionView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1320)
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
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.28
        explainLabel.attributedText = NSMutableAttributedString(string: "Cats is a song written by Andrew Lloyd Webber, based on T. S. Elliott's poem A Guide to Becoming a Wise Cat, and premiered in London's West End in 1981, and then on Broadway in 1982. it's a musical It is one of the most successful musicals in the world, and is also called the world's four greatest musicals. Among these musicals, <Memory> became a popular song in Korea.", attributes: [NSAttributedString.Key.kern: -0.17, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        // top 여백 제거
        scrollView.contentInset = .init(top: -100, left: 0, bottom: 0, right: 0)
        
        underTapView.layer.cornerRadius = 15
        
        buyTicketView.layer.cornerRadius = 26
        buyTicketView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        buyTicketView.layer.shadowOpacity = 1
        buyTicketView.layer.shadowOffset = CGSize(width: 0, height: 0)
        buyTicketView.layer.position = buyTicketView.center
    }
    
    private func setLayouts() {
        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(underTapView.snp.bottom).offset(30)
        }
    }
    
    private func setCollectionView() {
        let nibName = UINib(nibName: "TimeCollectionViewCell", bundle: nil)
        timeCollectionView.register(nibName, forCellWithReuseIdentifier: TimeCollectionViewCell.identifier)
        timeCollectionView.delegate = self
        timeCollectionView.dataSource = self
    }
    
    // MARK: - @objc Functions
    
    /* 이전 화면으로 돌아가기 */
    @objc
    private func showPrevious(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        timeDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCollectionViewCell.identifier, for: indexPath) as? TimeCollectionViewCell else { fatalError() }
        
        // 셀 내용 설정.
        cell.timeLabel.text = timeDataArray[indexPath.item]
        cell.timeUnitLabel.text = timeUnitArray[indexPath.item]
        if indexPath.item == 3 {
            cell.circles.isHidden = true
        }
        
        return cell
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 73, height: 66)
    }
    
    // 아이템 간의 최소 간격 설정.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(6)
    }
}
