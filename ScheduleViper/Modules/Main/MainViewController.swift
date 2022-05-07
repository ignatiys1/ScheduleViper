//
//  ViewController.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 1.05.22.
//

import UIKit
import FSCalendar

class MainViewController: UIViewController, MainViewProtocol {
    
    var presenter: MainPresenterProtocol!
    var configurator: MainConfiguratorProtocol = MainConfigurator()
    let selfToGroupsSegueName = "selfToGroupsSegueName"
    
    
    var calendarView: CalendarView = CalendarView()
    var calendarHeight: NSLayoutConstraint!
    var swipeUp: UISwipeGestureRecognizer!
    var swipeDown: UISwipeGestureRecognizer!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        
        tableView.register(UINib(nibName: "ScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        swipeUp.direction = .up
        swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        swipeDown.direction = .down
        
        presenter.configureView()
        
    }
   
    
    // MARK: - Navigation methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
    // MARK: - Button actions
    
    @IBAction func selectGroupAction(_ sender: Any) {
        presenter.selectGroupButtonClicked()
    }
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer) {
        switch swipe {
        case swipeUp:
            if calendarView.scope == .month {
                calendarView.setScope(.week, animated: true)
            }
        case swipeDown:
            if calendarView.scope == .week {
                calendarView.setScope(.month, animated: true)
            }
        default: break
        }
    }
    
    // MARK: - MainViewProtocol methods
    
    func setConstraintsForCalendarView(){
        //Где должно быть все, что в этой функции
        view.addSubview(calendarView)
        
        calendarHeight = NSLayoutConstraint(item: calendarView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        
        view.addConstraint(calendarHeight)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 10)
        ])
        
        calendarView.addGestureRecognizer(swipeUp)
        calendarView.addGestureRecognizer(swipeDown)
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func setCalendarHeight(with value: Float) {
        calendarHeight.constant = CGFloat(value)
    }

    func showAlert(text: String, type: ErrorTypes) {
        switch type {
        case .error:
            let alertVC = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
            presenter.router.present(alertVC, animated: true, completion: nil)
        case .loadingGroupsError:
            break
        case .loadingScheduleError:
            break
        }
        
    }
}

// MARK: - TableView Delegate and DataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.getNumberOfLessons()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ScheduleTableViewCell {
            let subjectTuple = presenter.getLessonInfo(for: indexPath.section)
            cell.setInfoFrom(subjectTuple: subjectTuple)
            //правильно ли передавать адрес изображения из VC
            presenter.loadImage(from: subjectTuple.imgUrl) { [cell] imageData in
                //кто должен заниматься преобразованием Data в UIImage
                if let image = UIImage(data: imageData) {
                    cell.employeeImageView.image = image
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
   
    
}
