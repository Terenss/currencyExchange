//
//  TableViewCell.swift
//  CurrencyPB
//
//  Created by Dmitrii on 06.11.2021.
//

import UIKit

class PrivateCell: UITableViewCell {

    
    @IBOutlet weak var privateCurrencyName: UILabel!
    
    @IBOutlet weak var privateBuy: UILabel!
    
    @IBOutlet weak var privateSell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
