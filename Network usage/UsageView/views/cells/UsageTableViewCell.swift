//
//  UsageTableViewCell.swift
//  NetworkUsageTests
//
//  Created by v.a.jayachandran on 17/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import UIKit

class UsageTableViewCell: UITableViewCell {

    @IBOutlet var dataVolumeLabel: UILabel!

    var vm: UsageTableViewCellVM? {
        didSet {
            dataVolumeLabel.text = vm?.dataVolume
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
