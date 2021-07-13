//
//  FavouriteTicket+CoreDataProperties.swift
//  GBAvia
//
//  Created by therealniks on 08.07.2021.
//
//

import Foundation
import CoreData


extension FavouriteTicket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteTicket> {
        return NSFetchRequest<FavouriteTicket>(entityName: "FavouriteTicket")
    }

    @NSManaged public var created: Date?
    @NSManaged public var departure: Date?
    @NSManaged public var expires: Date?
    @NSManaged public var returnDate: Date?
    @NSManaged public var airlane: String?
    @NSManaged public var from: String?
    @NSManaged public var to: String?
    @NSManaged public var price: Int64
    @NSManaged public var flightNumber: Int16

}

extension FavouriteTicket : Identifiable {

}
