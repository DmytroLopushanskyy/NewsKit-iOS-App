//
//  TableViewCell.swift
//  NewsKit-iOS-App
//
//  Created by Oleh Mykytyn on 9/24/19.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var swithcer: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
