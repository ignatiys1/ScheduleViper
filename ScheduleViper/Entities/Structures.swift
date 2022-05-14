//
//  Structures.swift
//  Schedule
//
//  Created by Ignat Urbanovich on 19.12.21.
//

import Foundation


typealias SubjectToView = (subject:String, auditory:String, lessonTime:String, lessonType:String, employeeName:String)

enum ErrorTypes {
    case error, loadingGroupsError, loadingScheduleError
    
}

struct Group: Decodable, Encodable{
    
    
    var name = ""
    var facultyId : Int?
    var facultyName: String?
    var specialityDepartmentEducationFormId : Int?
    var specialityName: String?
    var course: Int?
    var id = 0
    var calendarId: String?
    
    
    init(){}
    
    init? (json: [String: Any]) {
        guard
            let name = json["name"] as? String,
            let id = json["id"] as? Int
        else {
            return nil
        }
        
        self.name = name
        self.id = id
       
        self.facultyId = json["facultyId"] as? Int
        self.facultyName = json["facultyName"] as? String
        self.specialityDepartmentEducationFormId = json["specialityDepartmentEducationFormId"] as? Int
        self.specialityName = json["specialityName"] as? String
        self.course = json["course"] as? Int
        self.calendarId = json["calendarId"] as? String
        
    }
    
    static func getArray(from jsonArray: Any) -> [Group]? {
        guard let jsonArray = jsonArray as? Array<[String: Any]> else { return nil }
        var groups: [Group] = []
        
        for jsonObject in jsonArray {
            if let group = Group(json: jsonObject) {
                groups.append(group)
            }
        }
        return groups
    }
    
}

struct Lecturer: Decodable,  Encodable {
    var firstName: String?
    var lastName: String?
    var middleName: String?
    var degree: String?
    var rank: String?
    var photoLink : String?
    var calendarId : String?
    var academicDepartment: [String] = []
    var urlId : String?
    var fio : String?
    
    var id = 0
    
}

struct SomeSchedule: Decodable, Encodable {
    
    var employee: Lecturer?
    var studentGroup: Group?
    var schedules: [ScheduleItem] = []
    
    var todayDate: Date?
    var todaySchedules: [Subject] = []
    
    var examSchedules: [ScheduleItem] = []
    
    var currentWeekNumber: Int?
    var dateStart: Date?
    var dateEnd: Date?
    var sessionStart: Date?
    var sessionEnd: Date?
    
    static func != (lhs: SomeSchedule, rhs: SomeSchedule) -> Bool {
        if lhs.studentGroup?.id == rhs.studentGroup?.id, lhs.todayDate == rhs.todayDate, lhs.currentWeekNumber == rhs.currentWeekNumber {
            return false
        }
        return true
    }
    
}

struct ScheduleItem : Decodable, Encodable {
    var weekDay: String?
    var schedule: [Subject] = []
}


struct Subject : Decodable, Encodable {
    
    var weekNumber : [Int] = []
    var studentGroup : [String] = []
    var studentGroupInformation : [String] = []
    var numSubgroup: Int?
    var auditory: [String] = []
    var lessonTime: String?
    var startLessonTime: String?
    var endLessonTime: String?
    var gradebookLesson : String?
    var subject: String?
    var note: String?
    var lessonType: String?
    var employee: [Lecturer] = []
    var studentGroupModelList: String? =  nil
    var zaoch: Bool = false
    var gradebookLessonlist: String? = nil
    
    
    
}

enum SubjectTypes: String {
    case LK = "ЛК"
    case LR = "ЛР"
    case PZ = "ПЗ"
}
