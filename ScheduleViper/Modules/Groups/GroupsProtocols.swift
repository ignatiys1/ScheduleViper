//
//  GroupsProtocols.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 4.05.22.
//

import Foundation
import UIKit

protocol GroupsViewProtocol: class {
    func reloadData()
}

protocol GroupsPresenterProtocol: class {
    var router: GroupsRouterProtocol! { set get }
    
    func configureView()
    func getNumberOfGroups() -> Int
    func getGroupName(with id: Int) -> String
    func closeScene()
    func groupIsSelected(index: Int)
    func sortGroups(with: String)
}

protocol GroupsInteractorProtocol: class {
    func getNumberOfGroups(name: String) -> Int
    func getGroupName(with id: Int, name: String) -> String?
    func setCurrentGroup(with index: Int, name: String)
    
}

protocol GroupsRouterProtocol: class {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func closeScene()
}

protocol GroupsConfiguratorProtocol: class {
    func configure(with viewController: GroupsTableViewController)
}
