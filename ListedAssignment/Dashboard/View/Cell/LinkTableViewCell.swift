//
//  LinkTableViewCell.swift
//  ListedAssignment
//
//  Created by Heramb on 07/03/23.
//

import UIKit

class LinkTableViewCell: UITableViewCell {

    @IBOutlet weak var clicksLbl: UILabel!
    @IBOutlet weak var bottomBgView: UIView!
    @IBOutlet weak var webLinkLbl: UILabel!
    @IBOutlet weak var totalClicksLbl: UILabel!
    @IBOutlet weak var createdAtLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var originalImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bottomBgView.clipsToBounds = false
        bottomBgView.layer.cornerRadius = 8
        bottomBgView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        bottomBgView.addLineDashedStroke(pattern: [2, 2], radius: 8, color: UIColor(hexString: "#A6C7FF").cgColor)
        originalImgView.layer.cornerRadius = 8
        originalImgView.layer.borderColor = UIColor(hexString: "F5F5F5").cgColor
        originalImgView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
