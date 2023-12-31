//
//  CommentsTVC.swift
//  RestAPI
//
//  Created by Евгений Лойко on 19.10.23.
//

import UIKit

class CommentsTVC: UITableViewController {
    
    var postId: Int?
    var comments: [Comment] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchComments()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let comment = comments[indexPath.row]
        cell.textLabel?.text = "\(comment.name ?? "Unknown")\n\n\(comment.body ?? "Unknown")\n"
        cell.detailTextLabel?.text = comment.email
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { true }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let commentId = comments[indexPath.row].id
            NetworkService.deleteComment(commentId: commentId) { [weak self] in
                self?.comments.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewCommentVC {
            vc.postId = postId
        }
    }
    
    //MARK: - Private functions
    
    private func fetchComments() {
        let urlPath = "\(ApiConstants.commentsPath)?postId=\(postId ?? 0)"
        guard let url = URL(string: urlPath) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self,
                  let data = data else { return }
            do {
                comments = try JSONDecoder().decode([Comment].self, from: data)
                print(comments)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }
}
