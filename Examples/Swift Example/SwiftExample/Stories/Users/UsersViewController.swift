//
//  UsersViewController.swift
//  SwiftExample
//
//  Created by William Boles on 11/11/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import UIKit
import CoreDataServices
import CoreData

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var _users: [User]?
    var users: [User] {
        get {
            if(_users == nil) {
                let sortDescriptor = NSSortDescriptor.init(key: "age", ascending: true)
                
                _users = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntries(entityClass: User.self, sortDescriptors: [sortDescriptor])
            }
            
            return _users!
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addUserBarButtonItem: UIBarButtonItem!
    
    //MARK: - ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        addUserBarButtonItem.action = #selector(UsersViewController.addUserButtonPressed)
        addUserBarButtonItem.target = self
    }

    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        
        let user = users[indexPath.row]
        
        cell.nameLabel.text = "NAME: \(user.name!)"
        cell.ageLabel.text = "AGE: \(user.age)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let totalUsers = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntriesCount(entityClass: User.self)
        return "Total Users: \(totalUsers)"
    }
    
    //MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let user = users[indexPath.row]
        
        let predicate = NSPredicate(format: "userID==%@", user.userID!)
        ServiceManager.sharedInstance.mainManagedObjectContext.deleteEntries(entityClass: User.self, predicate: predicate)
        ServiceManager.sharedInstance.saveMainManagedObjectContext()
        
        clearAndReloadUsers()
    }
    
    //MARK: - ButtonActions
    
    func addUserButtonPressed(sender: UIBarButtonItem) {
        let shouldAddUserOnMainContext = arc4random_uniform(2) == 0
        
        if shouldAddUserOnMainContext {
            addUserOnMainContext()
        } else {
            addUserOnBackgroundContext()
        }
    }
    
    //MARK: - AddUser
    
    func addUserOnMainContext() {
        let user = NSEntityDescription.insertNewObject(entityClass: User.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext)
        
        user.userID = UUID().uuidString
        user.name = "Bob MainContext"
        user.age = Int16(arc4random_uniform(102))
        
        ServiceManager.sharedInstance.saveMainManagedObjectContext()
        
        clearAndReloadUsers()
    }
    
    func addUserOnBackgroundContext() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            ServiceManager.sharedInstance.backgroundManagedObjectContext.performAndWait({
                let user = NSEntityDescription.insertNewObject(entityClass: User.self, managedObjectContext: ServiceManager.sharedInstance.backgroundManagedObjectContext)
                
                user.userID = UUID().uuidString
                user.name = "Anna BackgroundContext"
                user.age = Int16(arc4random_uniform(102))
                
                ServiceManager.sharedInstance.saveBackgroundManagedObjectContext()
                
                DispatchQueue.main.async(execute: {
                    self?.clearAndReloadUsers()
                })
            })
        }
    }
    
    func clearAndReloadUsers() {
        _users = nil
        tableView.reloadData()
    }
}

