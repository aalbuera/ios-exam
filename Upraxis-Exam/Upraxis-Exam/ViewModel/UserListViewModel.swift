//
//  UserListViewModel.swift
//  Upraxis-Exam
//
//  Created by Al John Albuera on 05/01/2019.
//  Copyright © 2019 Al John Albuera. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

class UserListViewModel {
    
    private var userList: [CachedUserInfo]? {
        didSet {
            guard let userArr = userList else { return }
            self.setupUserInfo(userArr)
            self.didFinishFetch?()
        }
    }
    
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    var userListArray: [CachedUserInfo]?
    
    
    func getUserListFromAPI(_ indent: Int) {
        
        let userListPayload = ["indent": indent]
        
        ApiRouter.getUserInfoList(userList: userListPayload) { (response, error) in
            if let error = error {
                self.error = error
                self.isLoading = false
                return
            }
            self.error = nil
            self.isLoading = false
            
            
            let userJson = JSON(response!).arrayValue
            var userJsonArray: [CachedUserInfo] = []
            for userInfo in userJson {
                let firstname = userInfo["first_name"].stringValue
                let lastname = userInfo["last_name"].stringValue
                let bday = userInfo["birthday"].stringValue
                let contactPerson = userInfo["contact_person"].stringValue
                let contactPersonNumber = userInfo["contact_person_number"].intValue
                let email = userInfo["email"].stringValue
                let address = userInfo["address"].stringValue
                let mobileNum = userInfo["mobile_number"].intValue
                
                let userDetails = CachedUserInfo.init(firstname: firstname, lastname: lastname, birthday: bday, emailAdd: email, mobileNumber: mobileNum, address: address, contactPerson: contactPerson, contactPersonNumber: contactPersonNumber)
                
                userJsonArray.append(userDetails)
                
            }
            
            self.userList = userJsonArray
            self.cacheData(userJsonArray)
        }
    }
    
    private func setupUserInfo(_ userList: [CachedUserInfo]?) {
        
        if let userArray = userList {
            self.userListArray = userArray
        }
        
    }
    
    
    private func cacheData(_ userListData: [CachedUserInfo]?) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
       
        for user in userListData! {
             let userInfo = NSEntityDescription.insertNewObject(forEntityName: "UserInfo", into: context)
            userInfo.setValue(user.address, forKey: "address")
            userInfo.setValue(user.birthday, forKey: "bday")
            userInfo.setValue(user.contactPerson, forKey: "contactPerson")
            userInfo.setValue(user.contactPersonNumber, forKey: "contactPersonNumber")
            userInfo.setValue(user.emailAdd, forKey: "email")
            userInfo.setValue(user.firstname, forKey: "firstname")
            userInfo.setValue(user.lastname, forKey: "lastname")
            userInfo.setValue(user.mobileNumber, forKey: "mobileNum")
            
            do {
                try context.save()
                print("Success saving")
            } catch {
                
                print("Failed saving")
            }
            
        }

    }
    
    
    func fetchUserListArray() -> [CachedUserInfo] {
        
        var cachedListArray: [CachedUserInfo] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {

                let firstname = data.value(forKey: "firstname") as! String
                let lastname = data.value(forKey: "lastname") as! String
                let bday = data.value(forKey: "bday") as! String
                let contactPerson = data.value(forKey: "contactPerson") as! String
                let contactPersonNumber = data.value(forKey: "contactPersonNumber") as! Int
                let email = data.value(forKey: "email") as! String
                let address = data.value(forKey: "address") as! String
                let mobileNum = data.value(forKey: "mobileNum") as! Int
                
                let cachedList = CachedUserInfo.init(firstname: firstname, lastname: lastname, birthday: bday, emailAdd: email, mobileNumber: mobileNum, address: address, contactPerson: contactPerson, contactPersonNumber: contactPersonNumber)
                
                cachedListArray.append(cachedList)
                
            }
            
        } catch {
            
            print("Failed")
        }
        
        return cachedListArray
        
    }

}
