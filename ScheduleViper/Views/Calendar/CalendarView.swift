//
//  CalendarView.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 5.05.22.
//

import Foundation
import FSCalendar

protocol CalendarViewProtocol: class {
    var currentDate: Date { get set }
    func configureCalendarView()
    
}

protocol CalendarViewDelegate {
    func select(date: Date)
    func setCalendarHeight(with: Float)
    
}

class CalendarView: FSCalendar, CalendarViewProtocol, FSCalendarDelegate {
    
    var delegateView: CalendarViewDelegate?
    var calendarHeight: NSLayoutConstraint!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - CalendarViewProtocol methods
    
    var currentDate: Date {
        get {
            let date: Date = .now
            return self.selectedDate ?? date
        }
        set {
            self.select(newValue)
        }
    }
    
    
    
    func configureCalendarView() {
        delegate = self
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.scope = .week
        self.select(.now)

    }
 
    //MARK: - FSCalendarDelegate methods
    
//    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
//        calendarHeight.constant = bounds.height
//        //view.layoutIfNeeded()
//    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        delegateView?.setCalendarHeight(with: Float(bounds.height))
        self.superview?.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        delegateView?.select(date: date)
    }
    
}

