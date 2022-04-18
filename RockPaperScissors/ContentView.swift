//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Ji Wang on 4/17/22.
//

import SwiftUI

struct ContentView: View {
    let moves = ["👊", "🖐", "✌️"]

    @State var points: Int = 0
    @State var rounds: Int = 0
    let maxRounds = 10

    @State var currentMove: Int = Int.random(in: 0 ..< 3)
    @State var selectedMove: Int!
    @State var shouldWin: Bool = .random()
    @State var gameEnds: Bool = false

    var body: some View {
        
        VStack {
            Spacer()
            
            Text("Rock! Paper! Scissors!")
                .font(.largeTitle.bold())
            
            Spacer()
            
            VStack(spacing: 15) {
                HStack {
                    Text("I have ")
                    Text("\(moves[currentMove])")
                        .bold()
                }

                HStack {
                    Text("To")
                    let shouldWinText = shouldWin ? "win" : "lose"
                    Text(shouldWinText.uppercased())
                        .bold()
                }
            }

            VStack {
                Text("Your choice should be: ")

                ForEach(0 ..< 3) { index in
                    Button(action: {
                        selectedMove = index
                        choiceMade()
                    }, label: {
                        Text("\(moves[index])".capitalized)
                            .bold()
                            .frame(width: 200, height: 50, alignment: .center)
                    })
                    .background(.regularMaterial)
                    .cornerRadius(5)
                }
            }
            .padding()

            Spacer()
            
            VStack(spacing: 15) {
                Text("Round: \(rounds)")
                    .font(.title.bold())
                Text("Points: \(points)")
                    .font(.title.bold())
            }
            .padding()
            
            Spacer()
        }
        .alert("Game Ends", isPresented: $gameEnds) {
            Button("Restart", action: restartGame)
        } message: {
            Text("You scored \(points)!\nClick to play again.")
        }
    }

    func choiceMade() {
        rounds += 1

        if didWin() {
            points += 10
        } else {
            points -= 10
        }

        if rounds == maxRounds {
            gameEnds = true
        }
        
        shuffleMoves()
    }

    func didWin() -> Bool {
        if shouldWin {
            switch currentMove {
            case 0: return selectedMove == 1
            case 1: return selectedMove == 2
            case 2: return selectedMove == 0
            default:
                return false
            }
        } else {
            switch currentMove {
            case 0: return selectedMove == 2
            case 1: return selectedMove == 0
            case 2: return selectedMove == 1
            default:
                return false
            }
        }
    }
    
    func shuffleMoves() {
        currentMove = Int.random(in: 0 ..< 3)
        shouldWin = .random()
    }

    func restartGame() {
        // TODO: restart game
        rounds = 0
        points = 0
        gameEnds = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
