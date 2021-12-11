//
//  NationalCell.swift
//  CurrencyPB
//
//  Created by Dmitrii on 09.11.2021.
//

import UIKit

class NationalCell: UITableViewCell {

    
    @IBOutlet weak var nationalCurrencyNameLabel: UILabel!
    @IBOutlet weak var nationalUKRLabel: UILabel!
    @IBOutlet weak var nationalUSLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
