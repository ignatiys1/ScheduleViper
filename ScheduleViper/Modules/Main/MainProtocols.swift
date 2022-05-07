//
//  MainProtocols.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 1.05.22.
//

import Foundation
import UIKit

protocol MainViewProtocol: class {
    func reloadTable()
    func setCalendarHeight(with: Float)
    func setConstraintsForCalendarView()
    func showAlert(text: String, type: ErrorTypes)
}

protocol MainPresenterProtocol: class {
    var router: MainRouterProtocol! { set get }
    var currentDate: Date  { get set }
    
    func configureView()
    func selectGroupButtonClicked()
    func updateSchedule()
    
    func getNumberOfLessons() -> Int
    func getLessonInfo(for: Int) -> SubjectToView
    func loadImage(from: String, completion: @escaping (Data)->Void)
    
    func loadingError(type: ErrorTypes, error: Error)
    
}

protocol MainInteractorProtocol: class {
    var needToLoadSchedule: Bool { get }
    
    func getAllGroups()
    func loadSchedule()
    func getNumberOfLessons(at date: Date) -> Int
    func getSubject(at: Date, with: Int) -> Subject?
    func loadImage(from: String, completion:  @escaping (Data) -> Void)
}

protocol MainRouterProtocol: class {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func showGroupsScene()
    func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)
}

protocol MainConfiguratorProtocol: class {
    func configure(with viewController: MainViewController)
}
