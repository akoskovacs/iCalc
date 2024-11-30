//
//  ContentView.swift
//  iCalc
//
//  Created by Ákos Kovács on 2024. 11. 30..
//

import SwiftUI

struct ContentView: View {
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.settings, .zero, .comma, .equals],
    ]

    @State var value = "0"
    @State var lastValue: Double? = nil
    @State var isExpectingNew = false
    @State var operation: Operation? = nil
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 52))
                        .foregroundStyle(.white)
                        .padding()
                }
                .padding()
                
                
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                didTap(item)
                            },
                            label: {
                                Text(item.rawValue)
                                    .font(.system(size: 27))
                                    .frame(width: buttonWidthOf(item), height: buttonHeightOf(item))
                                    .background(item.backgroundColor())
                                    .foregroundColor(Color.white)
                                    .cornerRadius(buttonWidthOf(item) / 2)
                            })
                        }
                    }
                }
                .padding(.bottom, 1)
            }
        }
    }
    
    func currentValue() -> Double {
        Double(value) ?? 0
    }
    
    func prevValue() -> Double {
        lastValue ?? 0
    }
    
    func setOperation(_ operation: Operation) {
        self.lastValue = Double(value) ?? 0
        self.isExpectingNew = true
        self.operation = operation
    }
    
    func didTap(_ item: CalcButton) {
        switch item {
        case .clear:
            self.value = "0"
            self.lastValue = nil
            self.isExpectingNew = false
            self.operation = nil
            break
            
        case .plus, .minus, .multiply, .divide:
            setOperation(item.operation()!)
            break
            
        case .negative:
            let number = Double(value) ?? 0
            self.value = (number * -1).formatted()
            break
            
        case .equals:
            let done = self.operation?.binaryDo(prevValue(), currentValue()) ?? 0
            self.lastValue = done
            self.value = done.formatted()
            self.isExpectingNew = true
            break
            
        default:
            if item.isNumber() {
                if self.isExpectingNew {
                    self.value = item.rawValue
                    self.isExpectingNew = false
                } else {
                    self.value = value.starts(with: "0") ? item.rawValue : value + item.rawValue
                }
            }
        }
    }
    
    func buttonWidthOf(_ item: CalcButton) -> CGFloat {
        (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    func buttonHeightOf(_ item: CalcButton) -> CGFloat {
        (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

#Preview {
    ContentView()
}
