//
//  MainConfigurator.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 1.05.22.
//

import Foundation

class MainConfigurator: MainConfiguratorProtocol {
    
    func configure(with viewController: MainViewController) {
        let presenter = MainPresenter(view: viewController, calendarView: viewController.calendarView)
        let interactor = MainInteractor(presenter: presenter)
        let router = MainRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        viewController.calendarView.delegateView = presenter
        
    }
}
