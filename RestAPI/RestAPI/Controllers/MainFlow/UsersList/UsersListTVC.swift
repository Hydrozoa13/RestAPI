//
//  UsersListTVC.swift
//  RestAPI
//
//  Created by Евгений Лойко on 11.10.23.
//

import UIKit

class UsersListTVC: UITableViewController {
    
    var users: [User] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUsers()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = tableView.indexPathForSelectedRow,
           let vc = segue.destination as? UserDetailVC {
            vc.user = users[index.row]
        }
    }
    
    // MARK: - Private functions
    
    private func fetchUsers() {
        guard let usersURL = ApiConstants.usersURL else { return }
        URLSession.shared.dataTask(with: URLRequest(url: usersURL)) { [weak self] data, response, error in
            guard let self else { return }
            print(response as Any)
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                do {
                    self.users = try JSONDecoder().decode([User].self, from: data)
                    print(users)
                } catch {
                    print(error)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }
}
