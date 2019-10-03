//
//  Artticle+CoreDataProperties.swift
//  
//
//  Created by Олег on 02.10.2019.
//
//

import Foundation
import CoreData

extension Artticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Artticle> {
        return NSFetchRequest<Artticle>(entityName: "Entity")
    }

    @NSManaged public var decriptionTextt: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var keywords: String?
    @NSManaged public var sourceUrl: String?
    @NSManaged public var tittle: String?
    @NSManaged public var url: String?

}
