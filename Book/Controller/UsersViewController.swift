//
//  UsersViewController.swift
//  Book
//
//  Created by Alexandr Voronoy on 19.11.17.
//  Copyright © 2017 Alexandr Voronoy. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    private var datasource: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupDatasource()
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDeleted), name: .UserDeleted, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userEdited), name: .UserEdited, object: nil)
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func setupDatasource() {
        datasource = DataManager.instance.users
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? UserDetailsViewController else { return }
        guard let cell = sender as? UserTableViewCell,
            let indexPath = tableView.indexPath(for: cell) else { return }
        let user = datasource[indexPath.row]
        destVC.user = user
    }
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as? UserTableViewCell else {
            fatalError("Error")
        }
        let user = datasource[indexPath.row]
        let userAvatar = user.image ?? #imageLiteral(resourceName: "placeholder")
        let userPhone = user.phone
        cell.update(name: user.secondName, phone: userPhone, image: userAvatar)
        
        return cell
    }
}
extension UsersViewController {
    @objc private func userDeleted() {
        setupDatasource()
    }
    @objc private func userEdited() {
        setupDatasource()
    }
}
