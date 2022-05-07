//
//  ScheduleTableViewCell.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 3.05.22.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lessonName: UILabel!
    @IBOutlet weak var lessonTime: UILabel!
    @IBOutlet weak var employeeImageView: UIImageView!
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var lessonType: UILabel!
    @IBOutlet weak var auditory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        employeeImageView.layer.cornerRadius = employeeImageView.frame.width/2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setInfoFrom(subjectTuple: SubjectToView) {
        self.lessonName.text = subjectTuple.subject
        self.lessonTime.text = subjectTuple.lessonTime
        self.employeeName.text = subjectTuple.employeeName
        self.auditory.text = subjectTuple.auditory
        
        switch subjectTuple.lessonType {
        case SubjectTypes.LK.rawValue:
            mainView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            self.lessonType.text = "Lecture"
        case SubjectTypes.LR.rawValue:
            mainView.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
            self.lessonType.text = "Lab"
        case SubjectTypes.PZ.rawValue:
            mainView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            self.lessonType.text = "Practical lesson"
        default:
            break
        }
        
    }
}
