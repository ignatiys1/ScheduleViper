//
//  GroupsConfigurator.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 4.05.22.
//

import Foundation

class GroupsConfigurator: GroupsConfiguratorProtocol {
    
    func configure(with viewController: GroupsTableViewController) {
        let presenter = GroupsPresenter(view: viewController)
        let interactor = GroupsInteractor(presenter: presenter)
        let router = GroupsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
