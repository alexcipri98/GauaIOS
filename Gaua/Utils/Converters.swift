//
//  Converters.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import Foundation
import UIKit
import SwiftUI

class Converters {
    
    static func fromDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let currentDate = Date()

        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }
    
    static func fromStringToDate(string: String) -> Date? {
        //let dateString = "2023-07-12 14:30:00"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let date = dateFormatter.date(from: string) {
            return date
        } else {
            return nil
        }
    }

    static func convertBase64ToImage(base64String: String) -> UIImage? {
        if let imageData = Data(base64Encoded: base64String) {
            return UIImage(data: imageData)
        }
        return nil
    }
    
    static func calculateAge(from birthday: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: birthday) {
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: date, to: Date())
            return ageComponents.year
        }
        return nil
    }
    
}
