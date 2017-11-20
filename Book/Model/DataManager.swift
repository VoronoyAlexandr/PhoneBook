//
//  DataManager.swift
//  PhoneBook
//
//  Created by Alexandr Voronoy on 18.11.17.
//  Copyright © 2017 Alexandr Voronoy. All rights reserved.
//

import Foundation

final class DataManager {
    static let instance = DataManager()
    
    private (set) var users: [User] = [].sorted(by: { $0.secondName < $1.secondName })
    init() {
        self.generateUsers()
    }
    
    func generateUsers() {
        users.append(User(firstName: "Sasha", secondName: "Voronoy", email: "servermed@gmail.com", phone: "+380631376863", image: #imageLiteral(resourceName: "man2_64x64")))
        users.append(User(firstName: "Lonni", secondName: "Simpkiss", email: "lsimpkiss0@home.pl", phone: "+220 111 340 1720", image: #imageLiteral(resourceName: "woman2_64x64")))
        users.append(User(firstName: "Issiah", secondName: "Mulrenan", email: "imulrenan1@infoseek.co.jp", phone: "+1234567789", image: #imageLiteral(resourceName: "man1_64x64")))
        users.append(User(firstName: "Sig", secondName: "Tolomelli", email: "stolomelli2@gravatar.com", phone: "+93 146 581 9393", image: #imageLiteral(resourceName: "woman5_64x64")))
        users.append(User(firstName: "Gayelord", secondName: "Laugheran", email: "glaugheran3@yahoo.com", phone: "+385 758 877 2576", image: #imageLiteral(resourceName: "man4_64x64")))
        users.append(User(firstName: "Terrijo", secondName: "Domenge", email: "tdomenge4@angelfire.com", phone: "+86 107 106 8894", image: #imageLiteral(resourceName: "woman1_64x64")))
        users.append(User(firstName: "Leta", secondName: "Buist", email: "lbuist5@unesco.org", phone: "+81 379 605 7773", image: #imageLiteral(resourceName: "man3_64x64")))
        users.append(User(firstName: "Lianna", secondName: "Ranby", email: "lranby6@ustream.tv", phone: "+94 809 798 6187", image: #imageLiteral(resourceName: "woman3_64x64")))
        users.append(User(firstName: "Caro", secondName: "Gowrich", email: "cgowrich7@nps.gov", phone: "+880 390 197 2541", image: #imageLiteral(resourceName: "man5_64x64")))
        users.append(User(firstName: "Vaughn", secondName: "Sprosson", email: "vsprosson8@skype.com", phone: "+27 945 651 1456", image: #imageLiteral(resourceName: "woman4_64x64")))
    }
    
    func addUser(_ user: User) {
        users.append(user)
        NotificationCenter.default.post(name: .UserEdited, object: nil)
    }
    
    func deleteUser(_ user: User) {
        guard let index = users.index(of: user) else { return }
        users.remove(at: index)
         NotificationCenter.default.post(name: .UserDeleted, object: nil)    }
    
    func editUser(_ user: User) {
        var currentUsers = users
        guard !currentUsers.isEmpty else { return }
        guard let index = getIndex(of: user, in: users) else { return }
        currentUsers[index] = user
        users = currentUsers
        NotificationCenter.default.post(name: .UserEdited, object: nil)
    }
    
    private func getIndex(of user: User, in usersArray: [User]) -> Int? {
        var indexOfUser: Int?
        for (index, item) in usersArray.enumerated() {
            if item.id == user.id {
                indexOfUser = index
                break
            }
        }
        return indexOfUser
    }
}
