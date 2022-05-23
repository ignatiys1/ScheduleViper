//
//  Lecturer+CoreDataProperties.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 24.05.22.
//
//

import Foundation
import CoreData


extension Lecturer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lecturer> {
        return NSFetchRequest<Lecturer>(entityName: "Lecturer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var middleName: String?
    @NSManaged public var degree: String?
    @NSManaged public var rank: String?
    @NSManaged public var photoLink: String?
    @NSManaged public var calendarId: String?
    @NSManaged public var urlId: String?
    @NSManaged public var fio: String?
    @NSManaged public var id: Int16

}

extension Lecturer : Identifiable {

}
