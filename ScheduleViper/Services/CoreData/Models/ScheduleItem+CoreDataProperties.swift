//
//  ScheduleItem+CoreDataProperties.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 24.05.22.
//
//

import Foundation
import CoreData


extension ScheduleItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScheduleItem> {
        return NSFetchRequest<ScheduleItem>(entityName: "ScheduleItem")
    }

    @NSManaged public var weekDay: String?
    @NSManaged public var schedule: NSSet?

}

// MARK: Generated accessors for schedule
extension ScheduleItem {

    @objc(addScheduleObject:)
    @NSManaged public func addToSchedule(_ value: Subject)

    @objc(removeScheduleObject:)
    @NSManaged public func removeFromSchedule(_ value: Subject)

    @objc(addSchedule:)
    @NSManaged public func addToSchedule(_ values: NSSet)

    @objc(removeSchedule:)
    @NSManaged public func removeFromSchedule(_ values: NSSet)

}

extension ScheduleItem : Identifiable {

}
