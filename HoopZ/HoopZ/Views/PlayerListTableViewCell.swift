//
//  PlayerListTableViewCell.swift
//  HoopZ
//
//  Created by dadDev on 12/5/20.
//

import UIKit

class PlayerListTableViewCell: UITableViewCell {
    
    @IBOutlet var userNameLabel: UILabel!
    
    @IBOutlet var homeGymLabel: UILabel!
    
    @IBOutlet var availableLabel : UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
