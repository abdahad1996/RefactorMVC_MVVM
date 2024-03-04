//
//  ApiManager.swift
//  EDeveloperMVC
//
//  Created by MiciH on 7/19/21.
//


import Foundation


typealias GetUsers = ( @escaping (Result<[User], Error>) -> Void) -> Void


class ApiManager {
    
    static let shared = ApiManager()
    
    private init(){}
    
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void ){
        //1.url
        let urlString = "https://jsonplaceholder.typicode.com/users"
        
        let url = URL(string: urlString)!
        
        //2. session
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //3.handle error
            if let error = error{
                completion(.failure(error))
            }
            //4.handle data
            guard let data = data else{
                return
            }
            //5. handle decoding
            do{
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            }
            catch (let error){
                completion(.failure(error))
            }
        }.resume()
    }
}






























/*
 func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void){
     let urlString = "http://jsonplaceholder.typicode.com/users"
     //1. url
     let url = URL(string: urlString)!
     //2. create the url task
     URLSession.shared.dataTask(with: url) { (data, response, error) in
         //3. error handle
         if let error = error{
             completion(.failure(error))
             return
         }
         //4. data handle
         guard let data = data else{
             fatalError("can not get data")
         }
         //5. do try catch for decoding
         do{
             let users = try JSONDecoder().decode([User].self, from: data)
             completion(.success(users))
         }
         catch(let error){
             completion(.failure(error))
         }
     }.resume()
 }
 */

