//
//  iCalcApp.swift
//  iCalc
//
//  Created by Ákos Kovács on 2024. 11. 30..
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case plus = "+"
    case minus = "-"
    case multiply = "×"
    case divide = "÷"
    case equals = "="
    case clear = "AC"
    case negative = "±"
    case percent = "%"
    case comma = ","
    case settings = "⚙️"
    
    func isNumber() -> Bool {
        Int(self.rawValue) != nil
    }
    
    func toNumber() -> Int? {
        Int(self.rawValue) ?? nil
    }
    
    func backgroundColor() -> Color {
        switch self {
        case .plus, .minus, .multiply, .divide, .equals:
            return Color.orange
        case .clear, .negative, .percent:
            return Color(.gray)
        default:
            return Color(UIColor(red: 45/255.0, green: 50/255.0, blue: 55/255.0, alpha: 1))
        }
    }
    
    func operation() -> Operation? {
        switch self {
        case .plus: return Operation.addition
        case .minus: return Operation.substraction
        case .multiply: return Operation.multiplication
        case .divide: return Operation.substraction
        default: return nil
        }
    }
}
