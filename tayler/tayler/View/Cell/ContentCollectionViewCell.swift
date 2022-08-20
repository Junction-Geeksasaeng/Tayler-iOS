//
//  ContentCollectionViewCell.swift
//  tayler
//
//  Created by 서은수 on 2022/08/20.
//

import UIKit

struct Content {
    var title: String?
    var contentImage: UIImage?
    var dDay: String?
    var ticketNum: String?
    var tayCost: String?
}

class ContentCollectionViewCell: UICollectionViewCell {

    static let identifier = "ContentCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var dDayLabel: UILabel!
    @IBOutlet weak var ticketNumLabel: UILabel!
    @IBOutlet weak var tayLabel: UILabel!
    
    @IBOutlet weak var detailArrow: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 그라데이션 적용
        blurView.setGradient(startColor: .init(hex: 0xF1F1F1, alpha: 0.0), endColor: .init(hex: 0xF1F1F1, alpha: 1.0))
    }

}
