//
//  FidgetToyDetailView.swift
//  ZenUI
//
//  Created by David on 25.03.2024.
//

import SwiftUI
import ZenUILibrary

struct FidgetToyDetailView: View {
    var fidgetToy: FidgetToy
    
    var body: some View {
        VStack {
            FidgetToyTitleView(fidgetToy: fidgetToy)
            Spacer()
            
            switch fidgetToy.name {
            case FidgetToysData.ToyName.randomNumber.rawValue:
                RandomNumberGeneratorView()
            case FidgetToysData.ToyName.newtonsCradle.rawValue:
                NewtonsCradleContentView()
            case 
                FidgetToysData.ToyName.dice.rawValue:
                DiceContentView()
            case FidgetToysData.ToyName.randomCard.rawValue:
                RandomCardContentView()
            case 
                FidgetToysData.ToyName.coinToss.rawValue:
                CoinTossContentView()
            case 
                FidgetToysData.ToyName.cookieClicker.rawValue:
                CookieClickerContentView()
            case 
                FidgetToysData.ToyName.rubberDuck.rawValue:
                RubberDuckContentView()
            case 
                FidgetToysData.ToyName.magic8Ball.rawValue:
                Magic8BallContentView()
            case 
                FidgetToysData.ToyName.switchButton.rawValue:
                SwitchButtonContentView()
            case 
                FidgetToysData.ToyName.slider.rawValue:
                SliderContentView()
            case 
                FidgetToysData.ToyName.button.rawValue:
                PushButtonContentView()
            case 
                FidgetToysData.ToyName.chamomile.rawValue:
                ChamomileContentView()
            case 
                FidgetToysData.ToyName.xylophone.rawValue:
                XylophoneContentView()
            case 
                FidgetToysData.ToyName.drawingBoard.rawValue:
                DrawingBoardContentView()
            case 
                FidgetToysData.ToyName.ticTacToe.rawValue:
                TicTacToeContentView()
            case
                FidgetToysData.ToyName.rockPaperScissors.rawValue:
                RockPaperScissorsContentView()
            case
                FidgetToysData.ToyName.concentration.rawValue:
                ConcentrationContentView()
            case
                FidgetToysData.ToyName.fidgetSpinner.rawValue:
                FidgetSpinnerContentView()
            case FidgetToysData.ToyName.connect4.rawValue:
                ConnectFourContentView()
            default:
                Text("Other Fidget Toy Detail View")
            }

        }
    }
}

struct FidgetToyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FidgetToyDetailView(fidgetToy: FidgetToysData.sampleFidgetToy)
            .preferredColorScheme(.light)
    }
}

