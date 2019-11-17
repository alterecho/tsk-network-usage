//
//  UsageTableViewCell.swift
//  NetworkUsageTests
//
//  Created by v.a.jayachandran on 17/11/19.
//  Copyright © 2019 v.a.jayachandran. All rights reserved.
//

import UIKit

class UsageTableViewCell: UITableViewCell {

    @IBOutlet weak var dataVolumeLabel: UILabel!
    @IBOutlet weak var quarterLabel: UILabel!

    var vm: UsageTableViewCellVM? {
        didSet {
            dataVolumeLabel.attributedText = NSAttributedString(
                string: vm?.dataVolume ?? "",
                attributes: [.foregroundColor : (vm?.isDecreaseOverPreviousQuarter ?? false) ?  UIColor.green : UIColor.red]
            )
            quarterLabel.text = vm?.quarter
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
