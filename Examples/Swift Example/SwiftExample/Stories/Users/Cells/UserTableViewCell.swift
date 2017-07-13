//
//  UserTableViewCell.swift
//  SwiftExample
//
//  Created by William Boles on 11/11/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    // MARK: - Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
