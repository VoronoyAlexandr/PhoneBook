//
//  UIImage + Extension.swift
//  PhoneBook
//
//  Created by Alexandr Voronoy on 18.11.17.
//  Copyright © 2017 Alexandr Voronoy. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func asCircle() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}
