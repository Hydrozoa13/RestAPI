//
//  AlbomsTVC.swift
//  RestAPI
//
//  Created by Евгений Лойко on 19.10.23.
//

import UIKit

class AlbumsTVC: UITableViewController {
    
    var userId: Int?
    var albums: [Album] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAlbums()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let album = albums[indexPath.row]
        cell.textLabel?.text = album.title
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Private functions
    
    private func fetchAlbums() {
        let urlPath = "\(ApiConstants.albumsPath)?userId=\(userId ?? 0)"
        guard let url = URL(string: urlPath) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self,
                  let data = data else { return }
            do {
                albums = try JSONDecoder().decode([Album].self, from: data)
                print(albums)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }
}