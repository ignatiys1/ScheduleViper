//
//  MainRouter.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 1.05.22.
//

import Foundation
import UIKit

class MainRouter: MainRouterProtocol {
    
    weak var viewController: MainViewController!
    
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    func showGroupsScene() {
        viewController.performSegue(withIdentifier: viewController.selfToGroupsSegueName, sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? GroupsTableViewController)?.mainController = viewController
    }
    
    func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?) {
        viewController.present(viewControllerToPresent, animated: animated, completion: completion)
    }
}
