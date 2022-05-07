//
//  UIExtensions.swift
//  ScheduleViper
//
//  Created by Ignat Urbanovich on 6.05.22.
//

import Foundation
import UIKit

extension UITextField {
    
    func availableAdding(string: String) -> Bool {
        switch string {
        case "":
            return self.text != ""
        case "0"..."9":
            return true
        default:
            return false
        }
    }
    
    func addString(_ string: String) {
        var newValue: String = self.text ?? ""
        var addingString = string
        if addingString == "", newValue.count > 0 {
            newValue.removeLast()
        } else if addingString != "" {
            if addingString == "," {
                addingString = "."
            }
            newValue.append(addingString)
        }
        self.text = newValue
    }
    
}
