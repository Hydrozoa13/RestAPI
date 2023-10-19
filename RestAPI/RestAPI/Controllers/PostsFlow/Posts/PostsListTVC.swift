//
//  PostsListTVC.swift
//  RestAPI
//
//  Created by Евгений Лойко on 14.10.23.
//

import UIKit

class PostsListTVC: UITableViewController {
    
    var user: User?
    var posts: [Post] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPosts()
    }
    
    @IBAction func addPostAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "createNewPost", sender: nil)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { posts.count }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { true }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let postId = posts[indexPath.row].id
            NetworkService.deletePost(postId: postId) { [weak self] in
                self?.posts.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewPostVC {
            vc.user = user
        } else if let index = tableView.indexPathForSelectedRow,
                  let vc = segue.destination as? CommentsTVC {
            vc.postId = posts[index.row].id
        }
    }
    
    // MARK: - Private functions
    
    private func fetchPosts() {
        let userId = user?.id.description ?? ""
        let urlPath = "\(ApiConstants.postsPath)?userId=\(userId)"
        guard let url = URL(string: urlPath) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self,
                  let data = data else { return }
            do {
                posts = try JSONDecoder().decode([Post].self, from: data)
                print(posts)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }
}
