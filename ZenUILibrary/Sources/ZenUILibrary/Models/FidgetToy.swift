//
//  FidgetToy.swift
//  ZenUI
//
//  Created by David on 25.03.2024.
//

import Foundation

public struct FidgetToy: Hashable, Identifiable {
    public var id = UUID()
    public var name: String
    public var imageName: String
    
    public init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
    //let urlString: String
    //let description: String
}

public struct FidgetToysData {
    
    public enum ToyName: String, CaseIterable {
        case fidgetSpinner = "Fidget Spinner"
        case switchButton = "Switch"
        case randomNumber = "Random Number"
        case newtonsCradle = "Newton's Cradle"
        case rubberDuck = "Rubber Duck"
        case cookieClicker = "Cookie Clicker"
        case coinToss = "Coin Toss"
        case magic8Ball = "Magic 8 Ball"
        case dice = "Dice"
        case randomCard = "Random Card"
        case chamomile = "Chamomile"
        case button = "Button"
        case slider = "Slider"
        case xylophone = "Xylophone"
        case drawingBoard = "Drawing Board"
        case ticTacToe = "Tic-Tac-Toe"
        case rockPaperScissors = "Rock Paper Scissors"
        case concentration = "Concentration"
        case connect4 = "Connect 4"
    }
    
    public static let sampleFidgetToy = FidgetToy(name: ToyName.switchButton.rawValue,
                                                  imageName: ToyName.switchButton.imageName())
    
    public static let fidgetToys: [FidgetToy] = ToyName.allCases.map { toyName in
        FidgetToy(name: toyName.rawValue,
                  imageName: toyName.imageName())
    }
}

extension FidgetToysData.ToyName {
    func imageName() -> String {
        switch self {
        case .fidgetSpinner:
            return "fidget-spinner"
        case .switchButton:
            return "switch"
        case .randomNumber:
            return "number"
        case .newtonsCradle:
            return "newtons-cradle"
        case .rubberDuck:
            return "rubber-duck"
        case .cookieClicker:
            return "tap"
        case .coinToss:
            return "coin"
        case .magic8Ball:
            return "magic-ball"
        case .dice:
            return "dice"
        case .randomCard:
            return "poker"
        case .chamomile:
            return "chamomile"
        case .button:
            return "button"
        case .slider:
            return "slider"
        case .xylophone:
            return "xylophone-instrument"
        case .drawingBoard:
            return "blackboard"
        case .ticTacToe:
            return "tic-tac-toe"
        case .rockPaperScissors:
            return "rock-paper-scissors"
        case .concentration:
            return "memory"
        case .connect4:
            return "connect-4"
        }
    }
}
