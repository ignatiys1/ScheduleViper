//
//  GroupsPresenter.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 4.05.22.
//

import Foundation

class GroupsPresenter: GroupsPresenterProtocol {
    

    weak var view: GroupsViewProtocol!
    var interactor: GroupsInteractorProtocol!
    var router: GroupsRouterProtocol!
    
    var stringToSort = ""
    
    required init(view: GroupsViewProtocol) {
        self.view = view
    }
    
    // MARK: - GroupsPresenterProtocol methods
    
    func configureView() {
        
    }
    
    func getNumberOfGroups() -> Int {
        return interactor.getNumberOfGroups(name: stringToSort) 
    }
    
    func getGroupName(with id: Int) -> String {
        if let name = interactor.getGroupName(with: id, name: stringToSort) {
            return name.trimmingCharacters(in: .whitespaces)
        } else {
            return ""
        }
    }
    
    func groupIsSelected(index: Int) {
        interactor.setCurrentGroup(with: index, name: stringToSort)
    }
    
    func closeScene() {
        router.closeScene()
    }
    
    func sortGroups(with string: String) {
        stringToSort = string.trimmingCharacters(in: .whitespacesAndNewlines)
        view.reloadData()
    }
    
    
}
