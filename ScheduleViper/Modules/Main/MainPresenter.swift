//
//  MainPresenter.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 1.05.22.
//

import Foundation
import UIKit

class MainPresenter: MainPresenterProtocol, CalendarViewDelegate {
    
    weak var view: MainViewProtocol!
    weak var calendarView: CalendarViewProtocol!
    var interactor: MainInteractorProtocol!
    var router: MainRouterProtocol!
    
    //правильно ли хранение выбранной даты оставить в презентере?
    var currentDate: Date {
        didSet {
            view.reloadTable()
        }
    }
    
    required init(view: MainViewProtocol, calendarView: CalendarViewProtocol) {
        self.view = view
        self.calendarView = calendarView
        currentDate = calendarView.currentDate
    }
    
    // MARK: - MainPresenterProtocol methods
    
    func configureView() {
        if interactor.needToLoadSchedule {
            interactor.loadSchedule()
        }
        interactor.getAllGroups()
        
        calendarView.configureCalendarView()
        view.setupView()
        
        view.setButtonTitle(with: interactor.currentGroup.name)
        
        view.reloadTable()
        
    }

    func selectGroupButtonClicked() {
        router.showGroupsScene()
        
    }
    
    func updateSchedule() {
        if interactor.needToLoadSchedule {
            interactor.loadSchedule()
        }
        view.reloadTable()
    }
    
    func getNumberOfLessons() -> Int {
        return interactor.getNumberOfLessons(at: currentDate)
    }
    
    func getLessonInfo(for id: Int, completion: @escaping  (UIImage) -> Void) -> SubjectToView {
        let subject = interactor.getSubject(at: currentDate, with: id)
        if let subject = subject {
            if let stringUrl = subject.employee[0].photoLink {
                interactor.loadImage(from: stringUrl) { imageData in
                    if let image = UIImage(data: imageData) {
                        completion(image)
                    }
                }
            }
            return (subject.subject ?? "",subject.auditory[0],subject.lessonTime ?? "",subject.lessonType ?? "",subject.employee[0].fio ?? "")
        }
        return ("Error","","","","")
    }
    
    func loadImage(from stringUrl: String, completion: @escaping  (Data) -> Void) {
        
    }
    
    func loadingError(type: ErrorTypes, error: Error) {
        switch type {
        case .error:
            view.showAlert(text: "Some error", type: .error)
        case .loadingGroupsError:
            view.showAlert(text: "Groups loading error", type: .error)
        case .loadingScheduleError:
            view.showAlert(text: "Schedule loading error", type: .error)
        }
        
    }
    
    
    // MARK: - CalendarViewDelegate methods
    
    func select(date: Date) {
        currentDate = date
    }
    
    func setCalendarHeight(with value: Float) {
        view.setCalendarHeight(with: value)
    }
    
    

}

