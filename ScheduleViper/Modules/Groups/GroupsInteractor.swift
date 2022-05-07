//
//  GroupsInteractor.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 4.05.22.
//

import Foundation


class GroupsInteractor: GroupsInteractorProtocol {

    weak var presenter: GroupsPresenterProtocol!
    
    let scheduleService: ScheduleServiceProtocol = ScheduleService()
    let serverService: ServerServiceProtocol = ServerService()
    
    required init(presenter: GroupsPresenterProtocol) {
        self.presenter = presenter
    }
    
    //MARK: - GroupsInteractorProtocol methods
    
    func getNumberOfGroups(name: String) -> Int {
        if name == "" {
            return scheduleService.allGroups.count
        } else {
            return (scheduleService.allGroups.filter() {$0.name.contains(name)}).count
        }
    }
    
    func getGroupName(with id: Int, name: String) -> String? {
        if id >= 0 && id < scheduleService.allGroups.count {
            if name == "" {
                return scheduleService.allGroups[id].name
            } else {
                return (scheduleService.allGroups.filter() {$0.name.contains(name)})[id].name
//                var currentId = 0
//                for group in scheduleService.allGroups {
//                    if group.name.contains(name) {
//                        if currentId == id {
//                            return group.name
//                        } else {
//                            currentId += 1
//                        }
//                    }
//                }
            }
        }
        return nil
    }
    
    func setCurrentGroup(with index: Int, name: String) {
        if name == "" {
        scheduleService.currentGroup = scheduleService.allGroups[index]
        } else {
            var currentId = 0
            for (id,group) in scheduleService.allGroups.enumerated() {
                if group.name.contains(name) {
                    if currentId == index {
                        scheduleService.currentGroup = scheduleService.allGroups[id]
                        return
                    } else {
                        currentId += 1
                    }
                }
            }
        }
    }
    
}
