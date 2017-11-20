//
//  UsersViewController.swift
//  Book
//
//  Created by Alexandr Voronoy on 19.11.17.
//  Copyright © 2017 Alexandr Voronoy. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var tableView: UITableView!
    
    private var datasource: [User] = []
    private var filteredData: [User] = []
    private var isSearchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupTable()
        setupDatasource()
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDeleted), name: .UserDeleted, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userEdited), name: .UserEdited, object: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? UserDetailsViewController else { return }
        guard let cell = sender as? UserTableViewCell,
            let indexPath = tableView.indexPath(for: cell) else { return }
        let user = getUser(for: indexPath)
        destVC.user = user
    }
    // MARK: - Private Methods
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
    }
    private func updateSearchContentIfNeeded() {
         guard isSearchActive else { return }
         let searchText = searchBar.text ?? ""
        fileteredContent(byName: searchText)
    }
    private func setupDatasource() {
        datasource = DataManager.instance.users.sorted(by: { $0.secondName < $1.secondName })
        tableView.reloadData()
        updateSearchContentIfNeeded()
    }
    private func fileteredContent(byName name: String) {
        isSearchActive = !name.isEmpty
        filteredData.removeAll()
        for user in datasource {
            if user.secondName.lowercased().contains(name.lowercased()) {
                filteredData.append(user)
            } else if user.firstName.lowercased().contains(name.lowercased()) {
                filteredData.append(user)
            } else if user.email.lowercased().contains(name.lowercased()) {
                filteredData.append(user)
            } else if user.phone.lowercased().contains(name.lowercased()) {
                filteredData.append(user)
            }
        }
        tableView.reloadSections(IndexSet(integer: 0), with: .none)
    }
    private func getUser(for indexPath: IndexPath) -> User {
        return isSearchActive ? filteredData[indexPath.row] : datasource[indexPath.row]
    }
}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? filteredData.count : datasource.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as? UserTableViewCell else {
            fatalError("Error")
        }
        let user = getUser(for: indexPath)
        let userAvatar = user.image ?? #imageLiteral(resourceName: "placeholder")
        let userPhone = user.phone
        cell.update(name: user.secondName, phone: userPhone, image: userAvatar)
        
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let user = DataManager.instance.users[indexPath.row]
        DataManager.instance.deleteUser(user)
    }
}

// MARK: - UISearchBarDelegate
extension UsersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fileteredContent(byName: searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

// MARK: - Notification
extension UsersViewController {
    @objc private func userDeleted() {
        setupDatasource()
    }
    @objc private func userEdited() {
        setupDatasource()
    }
}
