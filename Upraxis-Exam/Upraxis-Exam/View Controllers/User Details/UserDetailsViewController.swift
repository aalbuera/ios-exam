//
//  UserDetailsViewController.swift
//  Upraxis-Exam
//
//  Created by Al John Albuera on 05/01/2019.
//  Copyright © 2019 Al John Albuera. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    var cachedUserInfo: CachedUserInfo?
    @IBOutlet weak var lblFirstname: UILabel!
    @IBOutlet weak var lblLastname: UILabel!
    @IBOutlet weak var lblBirthday: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblContactPerson: UILabel!
    @IBOutlet weak var lblContactPersonNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = String(format: "%@'s Details", cachedUserInfo!.firstname!)
        self.populateData(cachedUserInfo!)
        
    }
    
    private func populateData(_ userInfo: CachedUserInfo) {
        
        self.lblFirstname.text = String(format: "First Name: %@", userInfo.firstname!)
        self.lblLastname.text = String(format: "Last Name: %@", userInfo.lastname!)
        self.lblBirthday.text = String(format: "Birthday: %@", userInfo.birthday!)
        self.lblEmail.text = String(format: "Email Address: %@", userInfo.emailAdd!)
        self.lblMobileNumber.text = String(format: "Mobile Number: %i", userInfo.mobileNumber!)
        self.lblAddress.text = String(format: "Address: %@", userInfo.address!)
        self.lblContactPerson.text = String(format: "Contact Person: %@", userInfo.contactPerson!)
        self.lblContactPersonNumber.text = String(format: "Contact Person Number: %i", userInfo.contactPersonNumber!)
        
        let convertedDate = Utils.convertStringToDate(dateString: userInfo.birthday!)
        let calculatedAge = Utils.calculateAgeFromCurrentDate(birtday: convertedDate)
        self.lblAge.text = String(format: "Age: %i", calculatedAge)
        
    }

}
