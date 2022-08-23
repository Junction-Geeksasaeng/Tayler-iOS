//
//  TimeCollectionViewCell.swift
//  tayler
//
//  Created by 서은수 on 2022/08/20.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {

    static let identifier = "TimeCell"
    
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeUnitLabel: UILabel!
    @IBOutlet weak var circles: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setAttributes()
    }
    
    private func setAttributes() {
        timeView.layer.cornerRadius = 5
        timeLabel.font = .robotoFont(.robotoBold, size: 24)
        timeUnitLabel.font = .robotoFont(.robotoMedi, size: 13)
    }

}
