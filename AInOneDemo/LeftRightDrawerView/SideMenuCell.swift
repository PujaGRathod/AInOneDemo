//
//  SideMenuCell.swift
//  RideShare
//
//  Created by sensussoft on 1/3/18.
//  Copyright © 2018 sensussoft. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {

    @IBOutlet var lblItem: UILabel!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblItem.font = UIFont(name: FONT_SF_REGULAR, size: 16.0)
        lblItem.textColor = APP_LABEL_TEXT_COLOR
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
