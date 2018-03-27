//
//  UsersViewController.swift
//  Example
//
//  Created by William Boles on 11/11/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import UIKit
import CoreDataServices
import CoreData

class UsersViewController: UIViewController {
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium

        return dateFormatter
    }()
    
    var _users: [User]?
    var users: [User] {
        if(_users == nil) {
            let sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: false)
            
            _users = ServiceManager.shared.mainManagedObjectContext.retrieveEntries(entityClass: User.self, sortDescriptors: [sortDescriptor])
        }
        
        return _users!
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 88.0
    }

    // MARK: - ButtonActions
    
    @IBAction func addUserButtonPressed(sender: UIBarButtonItem) {
        let shouldAddUserOnMainContext = arc4random_uniform(2) == 0
        
        if shouldAddUserOnMainContext {
            addUserOnMainContext()
        } else {
            addUserOnBackgroundContext()
        }
    }
    
    @IBAction func resetUsersButtonPressed(sender: UIBarButtonItem) {
        ServiceManager.shared.reset()
        
        clearAndReloadUsers()
    }
    
    // MARK: - AddUser
    
    func addUserOnMainContext() {
        let user = NSEntityDescription.insertNewObject(entityClass: User.self, managedObjectContext: ServiceManager.shared.mainManagedObjectContext)
        
        user.userID = UUID().uuidString
        user.name = "Bob MainContext"
        user.dateOfBirth = Date.randomDate(daysBack: 30000)
        
        ServiceManager.shared.saveMainManagedObjectContext()
        
        clearAndReloadUsers()
    }
    
    func addUserOnBackgroundContext() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            ServiceManager.shared.backgroundManagedObjectContext.performAndWait({
                let user = NSEntityDescription.insertNewObject(entityClass: User.self, managedObjectContext: ServiceManager.shared.backgroundManagedObjectContext)
                
                user.userID = UUID().uuidString
                user.name = "Anna BackgroundContext"
                user.dateOfBirth = Date.randomDate(daysBack: 30000)
                
                ServiceManager.shared.saveBackgroundManagedObjectContext()
                
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

extension UsersViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        
        let user = users[indexPath.row]
        
        cell.nameLabel.text = "NAME: \(user.name!)"
        cell.ageLabel.text = "AGE: \(user.age!)"
        cell.dateOfBirthLabel.text = "DOB: \(dateFormatter.string(from: user.dateOfBirth! as Date))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let totalUsers = ServiceManager.shared.mainManagedObjectContext.retrieveEntriesCount(entityClass: User.self)
        return "Total Users: \(totalUsers)"
    }
}

extension UsersViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let user = users[indexPath.row]
        
        let predicate = NSPredicate(format: "userID==%@", user.userID!)
        ServiceManager.shared.mainManagedObjectContext.deleteEntries(entityClass: User.self, predicate: predicate)
        ServiceManager.shared.saveMainManagedObjectContext()
        
        clearAndReloadUsers()
    }
}

extension Date {
    
    // MARK: - Random
    
    static func randomDate(daysBack: Int)-> Date{
        let day = arc4random_uniform(UInt32(daysBack))+1
        let hour = arc4random_uniform(23)
        let minute = arc4random_uniform(59)
        
        let today = Date()
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.day = -Int(day - 1)
        offsetComponents.hour = Int(hour)
        offsetComponents.minute = Int(minute)
        
        let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0))
        
        return randomDate!
    }
}
