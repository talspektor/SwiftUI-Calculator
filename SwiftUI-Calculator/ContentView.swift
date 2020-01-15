    //
//  ContentView.swift
//  SwiftUI-Calculator
//
//  Created by Tal Spektor on 14/01/2020.
//  Copyright © 2020 Tal Spektor. All rights reserved.
//

import SwiftUI
    
    enum CalculatorButton: String {
        case zero, one, two, three, four, five, six, seven, eight, nine
        case equals, plus, minus, multiply, divide, decimal
        case ac, plusMinus, percent
        
        var title: String {
            switch self {
            case .zero: return "0"
            case .one: return "1"
            case .two: return "2"
            case .three: return "3"
            case .four: return "4"
            case .five: return "5"
            case .six: return "6"
            case .seven: return "7"
            case .eight: return "8"
            case .nine: return "9"
            case .plusMinus: return "+/-"
            case .minus: return "-"
            case .plus: return "+"
            case .percent: return "%"
            case .equals: return "="
            case .decimal: return "."
            case .multiply: return "X"
            case .divide: return "/"
            default:
                return "AC"
            }
        }
        
        var backgroung: Color {
            switch self {
            case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
                return Color(.darkGray)
            case .ac, .plusMinus, .percent:
                return Color(.lightGray)
            default:
                return Color(.orange)
            }
        }
    }
    
// Env object
    // Glogal Appllication state
    class GlobalEnvierment: ObservableObject {
        @Published var display = ""
        
        func receiveInput(calculatorButton: CalculatorButton) {
            self.display = calculatorButton.title
        }
    }

struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnvierment
    
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.six, .seven, .eight, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals]
    ]
    
    var body: some View {
        
        ZStack (alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing: 12) {
                HStack {
                    Spacer()
                    Text(env.display)
                        .foregroundColor(.white)
                        .font(.system(size: 64))
                }.padding()
                
                
                ForEach(buttons, id: \.self) { row in
                    HStack (spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            CalculatorButtonView(button: button)
                            
                            
                            
                        }
                    }
                }
            }.padding(.bottom)
        }
        
        
    }
    
    
}
    
    struct CalculatorButtonView: View {
        
        var button: CalculatorButton
        @EnvironmentObject var env: GlobalEnvierment
        
        var body: some View {
            Button(action: {
                
                self.env.receiveInput(calculatorButton: self.button)
                
            }) {
                Text(button.title)
                .font(.system(size: 32))
                .frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4)
                .foregroundColor(.white)
                .background(button.backgroung)
                .cornerRadius(self.buttonWidth(button: button))
            }
        }
        
        private func buttonWidth(button: CalculatorButton) -> CGFloat {
            if button == .zero {
                return (UIScreen.main.bounds.width - 4 * 12) / 2
            }
            return (UIScreen.main.bounds.width - 5 * 12) / 4
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvierment())
        
    }
}
