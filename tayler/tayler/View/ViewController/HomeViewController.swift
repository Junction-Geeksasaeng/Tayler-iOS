//
//  HomeViewController.swift
//  tayler
//
//  Created by 서은수 on 2022/08/20.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {

    // MARK: - Properties
    
    var categoryLabelArray: [UILabel] = []
    var contentsArray: [Content] = [
        Content(contentImage: UIImage(named: "Cats"), dDay: "D-4", ticketNum: "#1 - #300", tayCost: "1.0"),
        Content(contentImage: UIImage(named: "KinkyBoots"), dDay: "D-5", ticketNum: "#1 - #100", tayCost: "1.7"),
        Content(contentImage: UIImage(named: "Jekyll"), dDay: "D-7", ticketNum: "#1 - #239", tayCost: "0.8"),
        Content(contentImage: UIImage(named: "Chicago"), dDay: "D-9", ticketNum: "#1 - #108", tayCost: "2.1"),
        Content(contentImage: UIImage(named: "Wicked"), dDay: "D-10", ticketNum: "#1 - #80", tayCost: "1.1"),
        Content(contentImage: UIImage(named: "Phantom"), dDay: "D-347", ticketNum: "#1 - #100", tayCost: "0"),
    ] {
        didSet {
            contentCollectionView.reloadData()
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var todayHotView: UIView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var underTabView: UIView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttributes()
        setCollectionView()
        loadPapers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Functions
    
    private func setAttributes() {
        todayHotView.layer.cornerRadius = 10
        todayHotView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        todayHotView.layer.shadowOpacity = 1
        todayHotView.layer.shadowOffset = CGSize(width: 0, height: 0)
        todayHotView.layer.position = todayHotView.center
        
        for i in ["Musical", "Art", "Dance", "Movie", "Music"] {
            let label: UILabel = {
                let label = UILabel()
                label.text = i
                if i == "Musical" {
                    label.textColor = .black
                } else {
                    label.textColor = .init(hex: 0x7A7A7A)
                }
                return label
            }()
            categoryLabelArray.append(label)
        }
        
        categoryCollectionView.backgroundColor = .init(hex: 0xE6E6E6)
        contentCollectionView.backgroundColor = .init(hex: 0xE6E6E6)
        
        underTabView.layer.cornerRadius = 15
        
        // 스와이프 제스쳐로 VC를 pop할 수 있게 delegate 설정
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    private func setCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        let nibName = UINib(nibName: "ContentCollectionViewCell", bundle: nil)
        contentCollectionView.register(nibName, forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
    }
    
    // API를 통해 ticket papers 데이터를 가져옴
    private func loadPapers() {
        TicketsAPI.requestPapers(self)
    }
    
    // MARK: - @objc Functions
    
    @objc
    private func showAuctionDetail(sender: UIButton) {
        let view = sender.superview!
        let backgroundImageView = view.subviews[1] as! UIImageView
        let image = backgroundImageView.image
        
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        detailVC.auctionImage = image
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return categoryLabelArray.count
        } else {
            return contentsArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { fatalError() }
            
            // 순서대로 셀 내용 설정.
            cell.categoryLabel.text = categoryLabelArray[indexPath.item].text
            
            if indexPath.item == 0 {
                cell.categoryLabel.textColor = .black
                cell.underlineView.backgroundColor = .mainColor
            }
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier, for: indexPath) as? ContentCollectionViewCell else { fatalError() }
            
            let item = contentsArray[indexPath.item]
            cell.titleLabel.text = item.title
            cell.contentImageView.image = item.contentImage
            cell.dDayLabel.text = item.dDay
            cell.ticketNumLabel.text = item.ticketNum
            cell.tayLabel.text = item.tayCost
            cell.detailArrow.addTarget(self, action: #selector(showAuctionDetail(sender:)), for: .touchUpInside)
            
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: categoryLabelArray[indexPath.item].intrinsicContentSize.width, height: 25)
        } else {
            return CGSize(width: 162, height: 241)
        }
    }
    
    // 아이템 간의 최소 간격 설정.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.tag == 1 {
            return CGFloat(30)
        } else {
            return CGFloat(22)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.tag == 2 {
            return CGFloat(22)
        } else {
            return CGFloat(0)
        }
    }
}

// MARK: - UIGestureRecognizerDelegate

extension UIViewController: UIGestureRecognizerDelegate {
    
    /* 스와이프 제스쳐로 VC를 pop할 수 있게 설정 */
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
