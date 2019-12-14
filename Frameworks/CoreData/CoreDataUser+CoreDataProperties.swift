//
//  CoreDataUser+CoreDataProperties.swift
//  Frameworks
//
//  Created by Dimic Milos on 12/14/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreDataUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataUser> {
        return NSFetchRequest<CoreDataUser>(entityName: "CoreDataUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var subscription: String?

}
