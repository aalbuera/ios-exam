//
//  ViewController.swift
//  Upraxis-Exam
//
//  Created by Al John Albuera on 03/01/2019.
//  Copyright © 2019 Al John Albuera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel = UserListViewModel()
    var cachedUserList: [CachedUserInfo] = []
    @IBOutlet weak var tblUserList: UITableView! {
        didSet {
            tblUserList.tableFooterView = UIView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cachedUserList = self.viewModel.fetchUserListArray()
        
        if self.cachedUserList.count == 0 {
            self.viewModel.getUserListFromAPI(2)
            
            self.viewModel.updateLoadingStatus = {
                print("LOADING...")
                self.tblUserList.isHidden = true
            }
            
            self.viewModel.showAlertClosure = {
                print("ERROR")
            }
            
            self.viewModel.didFinishFetch = {
                self.tblUserList.isHidden = false
                self.cachedUserList = self.viewModel.userListArray!
                self.tblUserList.reloadData()
            }
        } else {
            self.tblUserList.isHidden = false
            self.cachedUserList = self.viewModel.fetchUserListArray()
            self.tblUserList.reloadData()
        }
        

    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cachedUserList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let userInfo = self.cachedUserList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userListCell", for: indexPath)
        cell.textLabel?.text = userInfo.firstname! + " " + userInfo.lastname!
        
    
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let goToUserDetailsView = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        let cachedUserInfo = self.cachedUserList[indexPath.row]
        goToUserDetailsView.cachedUserInfo = cachedUserInfo
        self.navigationController?.pushViewController(goToUserDetailsView, animated: true)
        
    }
    
    
    
}
