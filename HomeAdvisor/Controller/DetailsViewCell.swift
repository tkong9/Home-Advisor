//
//  DetailsViewCell.swift
//  HomeAdvisor
//
//  Created by TAEWON KONG on 1/27/20.
//  Copyright © 2020 TAEWON KONG. All rights reserved.
//

import UIKit

class DetailsViewCell: UITableViewCell {
    
    @IBOutlet weak var proName: UILabel!
    @IBOutlet weak var ratingInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
