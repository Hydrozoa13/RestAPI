//
//  ToDoListTVC.swift
//  RestAPI
//
//  Created by Евгений Лойко on 19.10.23.
//

import UIKit

class ToDoListTVC: UITableViewController {
    
    var userId: Int?
    var toDos: [ToDo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ToDoCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchToDos()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ToDoCell
        let toDo = toDos[indexPath.row]
        cell.titleLbl.text = toDo.title
        switch toDo.completed {
            case true: cell.segmentedControl.selectedSegmentIndex = 1
            case false: cell.segmentedControl.selectedSegmentIndex = 0
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { true }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toDoId = toDos[indexPath.row].id
            NetworkService.deleteToDo(toDoId: toDoId) { [weak self] in
                self?.toDos.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewToDo {
            vc.userId = userId
        }
    }
    
    //MARK: - Private functions

    private func fetchToDos() {
        let urlPath = "\(ApiConstants.toDosPath)?userId=\(userId ?? 0)"
        guard let url = URL(string: urlPath) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self,
                  let data = data else { return }
            do {
                toDos = try JSONDecoder().decode([ToDo].self, from: data)
                print(toDos)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }
}
