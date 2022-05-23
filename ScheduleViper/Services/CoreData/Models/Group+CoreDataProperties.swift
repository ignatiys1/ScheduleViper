//
//  Group+CoreDataProperties.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 24.05.22.
//
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group")
    }

    @NSManaged public var name: String?
    @NSManaged public var facultyId: Int16
    @NSManaged public var facultyName: String?
    @NSManaged public var specialityDepartmentEducationFormId: Int16
    @NSManaged public var specialityName: String?
    @NSManaged public var course: Int16
    @NSManaged public var id: Int16
    @NSManaged public var calendarId: String?

}

extension Group : Identifiable {

}
