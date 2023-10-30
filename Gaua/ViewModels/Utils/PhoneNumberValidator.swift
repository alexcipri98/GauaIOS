//
//  PhoneNumberValidator.swift
//  Gaua
//
//  Created by Alex Ciprián López on 26/10/23.
//

import Foundation
import libPhoneNumber

struct PhoneNumberValidator {
    static let defaultPrefix = "+34"

    func isValidPhoneNumber(prefix: String, phoneNumber: String) -> Bool {
        guard let phoneUtil = NBPhoneNumberUtil.sharedInstance() else {
            return false
        }
        
        do {
            let phoneNumberParsed = try phoneUtil.parse("\(prefix)\(phoneNumber)", defaultRegion: nil)
            return phoneUtil.isValidNumber(phoneNumberParsed)
        } catch {
            return false
        }
    }
    
    func ensureValidPrefix(_ prefix: String) -> String {
        return prefix.isEmpty ? Self.defaultPrefix : prefix
    }
}
