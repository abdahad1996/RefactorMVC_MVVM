//
//  ViewController.swift
//  EDeveloperMVC
//
//  Created by MiciH on 7/19/21.
//

import UIKit

class UserApiAdpater {
    static func getUsers(completion: @escaping (Result<[User], Error>) -> Void ){
        ApiManager.shared.getUsers { result in
            DispatchQueue.main.async {
                completion(result)
            }
            
        }
    }
}
    
    class UsersTableVC: UIViewController {
        
    var getUsers:GetUsers = UserApiAdpater.getUsers(completion:)
        
    
    private var users: [UserViewModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Users"
        
        configureTableView()
        
        getUsersFromSingleTone()
    }
    
    private func getUsersFromSingleTone(){
        getUsers { (result) in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            case.success(let users):
                
                self.users = users.map(UserViewModel.init)
                self.tableView.reloadData()
                
            }
        }
    }
    
    private func configureTableView(){
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
        
        let user = users[indexPath.row]
        cell?.nameLabel.text = user.name
        cell?.emailLabel.text = user.email
        
        if user.isHighlighted{
            cell?.backgroundColor = .green
        }
        else{
            cell?.backgroundColor = .white
        }
        
        return cell ?? UITableViewCell()
    }
    
    
}

struct UserViewModel{
    let name:String
    let email:String
    let isHighlighted:Bool
    
    init(user:User){
        name = user.name
        email = user.email
        isHighlighted = user.name.starts(with: "C")
    }
}
