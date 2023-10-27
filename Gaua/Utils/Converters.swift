//
//  Converters.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import Foundation
import UIKit
import SwiftUI

struct Converters {
    
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    static func fromDateToString(date: Date) -> String {
        return dateFormatter.string(from: Date())
    }
    
    static func fromStringToDate(string: String) -> Date? {
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
        if let date = dateFormatter.date(from: birthday) {
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: date, to: Date())
            return ageComponents.year
        }
        return nil
    }
    
}
