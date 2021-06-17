//
//  Palette+CoreDataProperties.swift
//  preferrd
//
//  Created by Timothy Ananda on 16/06/21.
//
//

import Foundation
import CoreData


extension Palette {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Palette> {
        return NSFetchRequest<Palette>(entityName: "Palette")
    }

    @NSManaged public var name: String?
    @NSManaged public var backgroundHex: String?
    @NSManaged public var headlineHex: String?
    @NSManaged public var bodyHex: String?
    @NSManaged public var buttonBgHex: String?
    @NSManaged public var buttonTextHex: String?

}

extension Palette : Identifiable {

}
