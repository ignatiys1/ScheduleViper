//
//  ScheduleService.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 3.05.22.
//

import Foundation

protocol ScheduleServiceProtocol: class {
    var allGroups: [Group] { get }
    var schedule: SomeSchedule { get }
    var currentGroup: Group { get set }
    
    func saveAllGroups(with: Array<[String:Any]>, completion: @escaping (Error?) -> Swift.Void)
    func saveSchedule(with: Data, completion: @escaping (Error?) -> Swift.Void)
    
}

class ScheduleService: ScheduleServiceProtocol {
    
    private let storageService: StorageServiceProtocol = StorageService()
    let dateFormatter = DateFormatter()
    
    init() {
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        schedule = storageService.savedSchedule() ?? SomeSchedule()
        //currentGroup = schedule.studentGroup ?? Group()
        allGroups = storageService.savedAllGroups()
    }
    
    var currentGroup: Group {
        set {
            storageService.saveCurrentGroup(with: newValue)
        }
        get {
            storageService.savedCurrentGroup()
        }
    }
    
    var schedule: SomeSchedule {
        didSet {
            if (oldValue != schedule) {
                storageService.saveSchedule(with: schedule)
            }
        }
    }
    
    var allGroups: [Group] {
        didSet {
            storageService.saveAllGroups(with: allGroups)
        }
    }
    
    func saveAllGroups(with dict: Array<[String : Any]>, completion: @escaping (Error?) -> Swift.Void) {
        var groups: [Group] = []
        groups = readJson(dict: dict, [Group].self) ?? []
        
        if !groups.isEmpty {
            let sortedGroups = groups.sorted() {
                (Int($0.name) ?? 0) > (Int($1.name) ?? 0)
            }
            allGroups = sortedGroups
        }
    }
    
    func saveSchedule(with data: Data, completion: @escaping (Error?) -> Void) {
        var currentSchedule: SomeSchedule?
        
        currentSchedule = readJson(data: data, SomeSchedule.self)
        
        if let currentSchedule = currentSchedule {
            self.schedule = currentSchedule
            completion(nil)
        }
    }
    
}

//MARK: - Work with JSON
extension ScheduleService {
    func readJson<T>(dict: Array<[String:Any]>, _ type: T.Type) -> T? where T : Decodable {
        do {
            let json = try JSONSerialization.data(withJSONObject: dict)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: json)
        } catch {
            print(error)
        }
        return nil
    }
    
    func readJson<T>(data: Data, _ type: T.Type) -> T? where T : Decodable {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            guard let string = String(data: data, encoding: .utf8) else { return nil}
//            print(string)
//            let object = try decoder.decode(T.self, from: data)
//            debugPrint(object)
            return try decoder.decode(T.self, from: data)
        } catch {
            print(error)
        }
        return nil
    }
}
