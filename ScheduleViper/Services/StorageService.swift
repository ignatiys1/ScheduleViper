//
//  StorageService.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 3.05.22.
//

import Foundation
import Metal

protocol StorageServiceProtocol: class {
    func savedSchedule() -> SomeSchedule?
    func savedAllGroups() -> [Group]
    func savedCurrentGroup() -> Group
    
    func saveCurrentGroup(with group: Group?)
    func saveSchedule(with schedule: SomeSchedule?)
    func saveAllGroups(with groups: [Group])
}

class StorageService: StorageServiceProtocol {
    
    private let kSavedSchedule = "URBAN.SavedSchedule"
    private let kSavedGroup = "URBAN.SavedGroup"
    private let kSavedAllGroups = "URBAN.SavedAllGroups"
   
    // MARK: - StorageServiceProtocol methods
    
    func savedSchedule() -> SomeSchedule? {
        if let data = UserDefaults.standard.value(forKey:kSavedSchedule) as? Data {
            let schedule = try? PropertyListDecoder().decode(SomeSchedule.self, from: data)
            return schedule
        }
        return nil
    }
    
    func savedAllGroups() -> [Group] {
        if let data = UserDefaults.standard.value(forKey:kSavedAllGroups) as? Data {
            let groups = try? PropertyListDecoder().decode([Group].self, from: data)
            if let groups = groups {
                return groups
            }
        }
        return []
    }
    func savedCurrentGroup() -> Group {
        if let data = UserDefaults.standard.value(forKey:kSavedGroup) as? Data {
            let group = try? PropertyListDecoder().decode(Group.self, from: data)
            if let group = group {
                return group
            }
        }
        return Group()
    }
    
    func saveCurrentGroup(with group: Group?) {
        if let group = group {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(group), forKey: kSavedGroup)
            UserDefaults.standard.synchronize()
        }
    }
    
    func saveSchedule(with schedule: SomeSchedule?) {
        if let schedule = schedule {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(schedule), forKey: kSavedSchedule)
            UserDefaults.standard.synchronize()
        }
    }
    
    func saveAllGroups(with groups: [Group]) {
        if !groups.isEmpty {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(groups), forKey: kSavedAllGroups)
            UserDefaults.standard.synchronize()
        }
    }
}
