//
//  UserTableViewCell.swift
//  Book
//
//  Created by Alexandr Voronoy on 19.11.17.
//  Copyright © 2017 Alexandr Voronoy. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak private var ibImageView: UIImageView!
    @IBOutlet weak private var ibName: UILabel!
    @IBOutlet weak private var ibPhone: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(name: String, phone: String, image: UIImage) {
        ibImageView.asCircle()
        ibName.text = name
        ibPhone.text = phone
        ibImageView.image = image
        
    }
}
