//
//  UserTableViewCell.swift
//  Book
//
//  Created by Alexandr Voronoy on 19.11.17.
//  Copyright © 2017 Alexandr Voronoy. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var ibImageView: UIImageView!
    @IBOutlet weak var ibName: UILabel!
    @IBOutlet weak var ibPhone: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(name: String, phone: String, image: UIImage) {
        ibImageView.asCircle()
        ibName.text = name
        ibPhone.text = phone
        ibImageView.image = image
        
    }
}
