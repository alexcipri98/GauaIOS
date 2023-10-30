//
//  ClasifierOfClassPerson.swift
//  Gaua
//
//  Created by Alex Ciprián López on 26/10/23.
//

import Foundation

struct ClasifierOfClassOfPerson {
    func calculateClassOfPerson(gender: String, genderToShow: String) -> ClassOfPerson {
        switch gender {
        case "male_gender_parameter".localized:
            switch genderToShow {
            case "female_gender_parameter".localized:
                return .classA
            case "male_gender_parameter".localized:
                return .classC
            default:
                return .classE
            }
        case "female_gender_parameter".localized:
            switch genderToShow {
            case "male_gender_parameter".localized:
                return .classB
            case "female_gender_parameter".localized:
                return .classD
            default:
                return .classF
            }
        default:
            switch genderToShow {
            case "male_gender_parameter".localized:
                return .classH
            case "female_gender_parameter".localized:
                return .classG
            default:
                return .classI
            }
        }
    }
}
