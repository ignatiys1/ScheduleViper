//
//  WeekNumber+CoreDataProperties.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 24.05.22.
//
//

import Foundation
import CoreData


extension WeekNumber {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeekNumber> {
        return NSFetchRequest<WeekNumber>(entityName: "WeekNumber")
    }

    @NSManaged public var weekNumber: Int16
    @NSManaged public var subject: Subject?

}

extension WeekNumber : Identifiable {

}
