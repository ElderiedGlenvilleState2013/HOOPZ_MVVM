//
//  PendingRequestTableViewCell.swift
//  HoopZ
//
//  Created by dadDev on 12/15/20.
//

import UIKit

class PendingRequestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var gymLabel: UILabel!
    @IBOutlet weak var canPlayLabel: UILabel!
    
    @IBOutlet var profileImageView: UIImageView!
    
    @IBAction func acceptButtonPressed(_ sender: Any) {
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
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
