//
//  Subject+CoreDataProperties.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 24.05.22.
//
//

import Foundation
import CoreData


extension Subject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subject> {
        return NSFetchRequest<Subject>(entityName: "Subject")
    }

    @NSManaged public var lessonTime: String?
    @NSManaged public var numSubgroup: Int16
    @NSManaged public var auditory: String?
    @NSManaged public var startLessonTime: String?
    @NSManaged public var endLessonTime: String?
    @NSManaged public var gradebookLesson: String?
    @NSManaged public var subject: String?
    @NSManaged public var note: String?
    @NSManaged public var lessonType: String?
    @NSManaged public var studentGroupModelList: String?
    @NSManaged public var zaoch: Bool
    @NSManaged public var gradebookLessonlist: String?
    @NSManaged public var weekNumber: NSSet?
    @NSManaged public var studentGroup: NSSet?
    @NSManaged public var employee: NSSet?

}

// MARK: Generated accessors for weekNumber
extension Subject {

    @objc(addWeekNumberObject:)
    @NSManaged public func addToWeekNumber(_ value: WeekNumber)

    @objc(removeWeekNumberObject:)
    @NSManaged public func removeFromWeekNumber(_ value: WeekNumber)

    @objc(addWeekNumber:)
    @NSManaged public func addToWeekNumber(_ values: NSSet)

    @objc(removeWeekNumber:)
    @NSManaged public func removeFromWeekNumber(_ values: NSSet)

}

// MARK: Generated accessors for studentGroup
extension Subject {

    @objc(addStudentGroupObject:)
    @NSManaged public func addToStudentGroup(_ value: Group)

    @objc(removeStudentGroupObject:)
    @NSManaged public func removeFromStudentGroup(_ value: Group)

    @objc(addStudentGroup:)
    @NSManaged public func addToStudentGroup(_ values: NSSet)

    @objc(removeStudentGroup:)
    @NSManaged public func removeFromStudentGroup(_ values: NSSet)

}

// MARK: Generated accessors for employee
extension Subject {

    @objc(addEmployeeObject:)
    @NSManaged public func addToEmployee(_ value: Lecturer)

    @objc(removeEmployeeObject:)
    @NSManaged public func removeFromEmployee(_ value: Lecturer)

    @objc(addEmployee:)
    @NSManaged public func addToEmployee(_ values: NSSet)

    @objc(removeEmployee:)
    @NSManaged public func removeFromEmployee(_ values: NSSet)

}

extension Subject : Identifiable {

}
