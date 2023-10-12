//
//  UsersListTVC.swift
//  RestAPI
//
//  Created by Евгений Лойко on 11.10.23.
//

import UIKit

class UsersListTVC: UITableViewController {
    
    var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
