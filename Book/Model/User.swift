//
//  User.swift
//  PhoneBook
//
//  Created by Alexandr Voronoy on 18.11.17.
//  Copyright © 2017 Alexandr Voronoy. All rights reserved.
//

import UIKit

struct User {
    private static var objectCounter = 0
    let id: Int
    var firstName: String
    var secondName: String
    var email: String
    var phone: String
    var image: UIImage?

    init(firstName: String, secondName: String, email: String, phone: String, image: UIImage? = nil) {
        User.objectCounter += 1
        self.id = User.objectCounter
        self.firstName = firstName
        self.secondName = secondName
        self.email = email
        self.phone = phone
        self.image = image
    }
}
extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.phone == rhs.phone
    }
}
