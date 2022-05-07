//
//  MianInterantor.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 1.05.22.
//

import Foundation

class MainInteractor: MainInteractorProtocol {
    
    weak var presenter: MainPresenterProtocol!
    
    let scheduleService: ScheduleServiceProtocol = ScheduleService()
    let serverService: ServerServiceProtocol = ServerService()
    
    required init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    //MARK: - MainInteractorProtocol methods
    var needToLoadSchedule: Bool {
        get {
            return scheduleService.currentGroup.id != 0 && scheduleService.currentGroup.id != scheduleService.schedule.studentGroup?.id
        }
    }
    
    func getAllGroups() {
        serverService.getAllGroups(completion: { (dict, error) in
            if let error = error {
                self.presenter.loadingError(type: .loadingGroupsError, error: error)
                return
            }
            if let dictResponse = dict {
                self.scheduleService.saveAllGroups(with: dictResponse) { (error) in
                    if let error = error {
                        self.presenter.loadingError(type: .loadingGroupsError, error: error)
                        return
                    }
                    
                }
            }
        })
    }
    
    func loadSchedule() {
        serverService.getSchedule(forGroupId: scheduleService.currentGroup.id, completion: { (data, error) in
            if let error = error {
                self.presenter.loadingError(type: .loadingScheduleError, error: error)
                return
            }
            if let data = data {
                self.scheduleService.saveSchedule(with: data) { (error) in
                    if let error = error {
                        self.presenter.loadingError(type: .loadingScheduleError, error: error)
                        return
                    } else {
                        self.presenter.updateSchedule()
                    }
                }
            }
        })
    }
    
    func getNumberOfLessons(at date: Date) -> Int {
        var count = 0
        let schedule = scheduleService.schedule
        
        for schItem in schedule.schedules {
            if schItem.weekDay?.uppercased() == getWeekDay(for: date) {
                for subj in schItem.schedule {
                    for weekNum in subj.weekNumber {
                        if weekNum == 0 || weekNum == countWeekNum(for: date) {
                            count += 1
                            break
                        }
                    }
                }
            }
        }
        return count
    }
    
    func getSubject(at date: Date, with index: Int) -> Subject? {
        var currentIndex = 0
        let schedule = scheduleService.schedule
        
        for schItem in schedule.schedules {
            if schItem.weekDay?.uppercased() == getWeekDay(for: date) {
                for subj in schItem.schedule {
                    for weekNum in subj.weekNumber {
                        if weekNum == 0 || weekNum == countWeekNum(for: date) {
                            if currentIndex == index {
                                return subj
                            } else {
                                currentIndex += 1
                                break
                            }
                        }
                    }
                }
            }
        }
        return nil
    }
    
    func loadImage(from stringUrl: String, completion:  @escaping (Data) -> Void) {
        serverService.loadImage(from: stringUrl, completion: completion)
    }
    
    
    //MARK: - Other methods
    
    func getWeekDay(for date: Date) -> String {
        let calendarCurrent = Calendar.current
        let component = calendarCurrent.dateComponents([.weekday], from: date)
        
        guard let weekDay = component.weekday else {
            return ""
        }
        switch weekDay {
        case 2: return "ПОНЕДЕЛЬНИК"
        case 3: return "ВТОРНИК"
        case 4: return "СРЕДА"
        case 5: return "ЧЕТВЕРГ"
        case 6: return "ПЯТНИЦА"
        case 7: return "СУББОТА"
        case 1: return "ВОСКРЕСЕНЬЕ"
        default: return ""
        }
        
    }
    
    func countWeekNum(for date: Date) -> Int {
        let calendar = Calendar(identifier: .gregorian)
        if calendar.startOfDay(for: date) == calendar.startOfDay(for: scheduleService.schedule.todayDate ?? date) {
            return scheduleService.schedule.currentWeekNumber ?? 1
        } else if calendar.startOfDay(for: date) > calendar.startOfDay(for: (scheduleService.schedule.todayDate ?? date)) {
            var dateToCheck = calendar.startOfDay(for: date)
            while getWeekDay(for: dateToCheck) != "ВОСКРЕСЕНЬЕ" {
                dateToCheck.addTimeInterval(TimeInterval(86400))
            }
            var currentWeekNum = scheduleService.schedule.currentWeekNumber ?? 1
            while true {
                if dateToCheck >= date {
                    return currentWeekNum
                } else {
                    dateToCheck.addTimeInterval(TimeInterval(604800))
                    if currentWeekNum == 4 {
                        currentWeekNum = 1
                    } else {
                        currentWeekNum += 1
                    }
                }
            }
        }
        return 1
    }
    
}
