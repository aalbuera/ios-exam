//
//  Extensions.swift
//  Upraxis-Exam
//
//  Created by Al John Albuera on 05/01/2019.
//  Copyright © 2019 Al John Albuera. All rights reserved.
//

import UIKit


class Utils {
    
    static func convertStringToDate(dateString: String) -> Date{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let convertedDate = dateFormatter.date(from: dateString)
        
        return convertedDate ?? Date()
    }
    
    static func calculateAgeFromCurrentDate(birtday: Date) -> Int {
        
        let now = Date()
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year], from: birtday, to: now)
        let age = ageComponents.year!
        
        return age
    }
    
}
