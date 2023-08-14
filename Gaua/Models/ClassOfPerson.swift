//
//  ClassOfPerson.swift
//  Gaua
//
//  Created by Alex Ciprián López on 9/8/23.
//

import Foundation

enum ClassOfPerson: String {
    case classA = "classA"//H -> M
    case classB = "classB" //M -> H
    case classC = "classC"//H -> H
    case classD = "classD"//M -> M
    case classE = "classE"//H -> H & M
    case classF = "classF"//M -> H & M
    case classG = "classG"//O -> M
    case classH = "classH"//O -> H
    case classI = "classI"//O -> H & M
    
    /*
     A -> (B F H I)
     B -> (A E G I)
     C -> (C E H I)
     D -> (D F G I)
     E -> (B C G I H)
     F -> (A D G I H)
     */
}
