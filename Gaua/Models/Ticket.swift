//
//  Ticket.swift
//  Gaua
//
//  Created by Alex Ciprián López on 17/9/23.
//

import Foundation

struct Ticket: Identifiable, Codable {
    var id: String
    var pubID: String
    var clientID: String
    var dayOfParty: Date
    var dayOfBuy: Date
    var price: Double
    var typeOfTicket: Int // Los pubs podrán crear tipos de entrada, este entero las identifica. Por ejemplo, un pub podría tener el tipo 1 que incluye consumición y cuesta 15€
}
