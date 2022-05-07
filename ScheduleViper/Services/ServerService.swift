//
//  ServerService.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 3.05.22.
//

import Foundation
import Alamofire


protocol ServerServiceProtocol: class {
    func getAllGroups(completion: @escaping (Array<[String: Any]>?, Error?) -> Swift.Void)
    func getSchedule(forGroupId id: Int, completion: @escaping (Data?, Error?) -> Swift.Void)
    func loadImage(from: String, completion: @escaping (Data) -> Void)
}


class ServerService: ServerServiceProtocol {

    let base = "https://journal.bsuir.by/api/v1"
    
    let lecturers = "/employees"
    let groups = "/groups"
    let forGroup = "/studentGroup/schedule"
    
    
    //MARK: - ServerServiceProtocol methods
    
    func getAllGroups(completion: @escaping (Array<[String : Any]>?, Error?) -> Void) {
        AF.request(base+groups).validate().responseJSON { responseJSON in
            switch responseJSON.result {
            case .success(let value):
                guard let jsonArray = value as? Array<[String: Any]> else { return }
                completion(jsonArray, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getSchedule(forGroupId id: Int, completion: @escaping (Data?, Error?) -> Void) {
        AF.request(base+forGroup+"?id=\(id)").validate().responseData { responseData in
            switch responseData.result {
            case .success(let value):
                completion(value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func loadImage(from stringUrl: String, completion: @escaping (Data) -> Void) {
        AF.request(stringUrl).validate().responseData() { responseData in
            switch responseData.result {
            case .success(let value):
                completion(value)
            case .failure(_):
                break
            }
        }
    }
    
}
