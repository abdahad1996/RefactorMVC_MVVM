//
//  ViewController.swift
//  EDeveloperMVC
//
//  Created by MiciH on 7/19/21.
//

import UIKit

class UsersTableVC: UIViewController {

    var getUsers:GetUsers = { completion in
       
            ApiManager.shared.getUsers { result in
                DispatchQueue.main.async {
                completion(result)
            }
        }
       
    }
    var users: [User] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Users"
        
        configureTableView()
        
        getUsersFromSingleTone()
    }
    
    func getUsersFromSingleTone(){
        getUsers { (result) in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            case.success(let users):
                
                    self.users = users
                    self.tableView.reloadData()
              
            }
        }
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension UsersTableVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? UserCell
        
        cell?.nameLabel.text = users[indexPath.row].name
        cell?.emailLabel.text = users[indexPath.row].email
        
        if users[indexPath.row].name.contains("C"){
            cell?.backgroundColor = .green
        }
        else{
            cell?.backgroundColor = .white
        }
        
        return cell ?? UITableViewCell()
    }
    
    
}

