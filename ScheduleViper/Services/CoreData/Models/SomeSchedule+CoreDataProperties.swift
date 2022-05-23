//
//  SomeSchedule+CoreDataProperties.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 24.05.22.
//
//

import Foundation
import CoreData


extension SomeSchedule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SomeSchedule> {
        return NSFetchRequest<SomeSchedule>(entityName: "SomeSchedule")
    }

    @NSManaged public var todayDate: Date?
    @NSManaged public var currentWeekNumber: Int16
    @NSManaged public var dateStart: Date?
    @NSManaged public var dateEnd: Date?
    @NSManaged public var sessionStart: Date?
    @NSManaged public var sessionEnd: Date?
    @NSManaged public var employee: Lecturer?
    @NSManaged public var studentGroup: Group?
    @NSManaged public var todaySchedules: NSSet?
    @NSManaged public var schedules: NSSet?

}

// MARK: Generated accessors for todaySchedules
extension SomeSchedule {

    @objc(addTodaySchedulesObject:)
    @NSManaged public func addToTodaySchedules(_ value: Subject)

    @objc(removeTodaySchedulesObject:)
    @NSManaged public func removeFromTodaySchedules(_ value: Subject)

    @objc(addTodaySchedules:)
    @NSManaged public func addToTodaySchedules(_ values: NSSet)

    @objc(removeTodaySchedules:)
    @NSManaged public func removeFromTodaySchedules(_ values: NSSet)

}

// MARK: Generated accessors for schedules
extension SomeSchedule {

    @objc(addSchedulesObject:)
    @NSManaged public func addToSchedules(_ value: ScheduleItem)

    @objc(removeSchedulesObject:)
    @NSManaged public func removeFromSchedules(_ value: ScheduleItem)

    @objc(addSchedules:)
    @NSManaged public func addToSchedules(_ values: NSSet)

    @objc(removeSchedules:)
    @NSManaged public func removeFromSchedules(_ values: NSSet)

}

extension SomeSchedule : Identifiable {

}
