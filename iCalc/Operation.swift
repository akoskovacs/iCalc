//
//  iCalcApp.swift
//  iCalc
//
//  Created by Ákos Kovács on 2024. 11. 30..
//

import SwiftUI

enum Operation: String {
    case addition
    case substraction
    case multiplication
    case division
    
    func binaryDo(_ left: Double, _ right: Double) -> Double {
        switch self {
        case .addition: return left + right
        case .substraction: return left - right
        case .multiplication: return left * right
        case .division: return left / right
        }
    }
}
