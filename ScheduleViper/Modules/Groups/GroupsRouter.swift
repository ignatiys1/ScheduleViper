//
//  GroupsRouter.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 4.05.22.
//

import Foundation
import UIKit

class GroupsRouter: GroupsRouterProtocol {
    
    weak var viewController: GroupsTableViewController!
    
    init(viewController: GroupsTableViewController) {
        self.viewController = viewController
    }
    
    func closeScene() {
        viewController.mainController.presenter.updateSchedule()
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}
