//
//  StateTableViewCell.swift
//  Patient Information
//
//  Created by Ngay Vong on 10/9/20.
//

import UIKit

class StateTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var stateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
