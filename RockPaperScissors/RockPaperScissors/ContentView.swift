//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Joshua Hales on 28/09/2022.
//

import SwiftUI


struct ContentView: View {
    
    @State private var cpuMoveChoiceLose = ["Paper", "Scissors" ,"Rock"]
    @State private var cpuMoveChoiceWin = ["Scissors", "Rock" ,"Paper"]
    @State private var moves = ["🪨", "📄", "✂️"]
    @State private var playerWin = Bool.random()
    @State private var playerScore = 0
    @State private var chosenMove = Int.random(in: 0..<3)
    @State private var showResult = false
    @State private var roundResult = ""
    @State private var questionsAnswered = 0
    @State private var gameOver = false
    
    var body: some View {
        ZStack {
                RadialGradient(stops: [
                    .init(color: Color(red: 0.6, green: 0.8, blue: 0.9), location: 0.3),
                    .init(color: Color(red: 0.2, green: 0.7, blue: 1), location: 0.3)
                ], center: .top, startRadius: 200, endRadius:  700)
            .ignoresSafeArea()
                VStack {
                    Text("Your score is \(playerScore)")
                        .font(.system(size:20))
                    Spacer()
                    Text("My move is")
                        .font(.system(size: 35, weight: .semibold, design: .default))
                        .foregroundStyle(.secondary)
                    if playerWin == false {
                        Text(cpuMoveChoiceLose[chosenMove])
                            .font(.system(size: 55, weight: .bold, design: .default))
                        
                    }
                    else {
                        Text(cpuMoveChoiceWin[chosenMove])
                            .font(.system(size: 55, weight: .bold, design: .default))
                    }
                    Spacer()
        
                    VStack(spacing: 30) {
                        ForEach(0..<3) { number in
                            Button {
                               playerMoveChosen(number)
                            } label: {
                                Text(moves[number]).font(.system(size: 30))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(.thinMaterial)
                        }
                        
                        
                        if playerWin == true {
                            Text("You should win")
                                .font(.system(size: 20, weight: .semibold, design: .default))
                        } else {
                            Text("You should lose")
                                .font(.system(size: 20, weight: .semibold, design: .default))
                        }
                    }
                }
            }
        
        
                .alert(roundResult, isPresented: $showResult) {
                    Button("Continue", action: shoot)
                }
                .alert("Your final score is \(playerScore)/10", isPresented: $gameOver) {
                    Button("Restart", action: reset)
                }
    }
    
    func playerMoveChosen(_ number: Int) {
            if number == chosenMove {
                playerScore += 1
                roundResult = "Correct!"
            } else {
                if playerScore == 0 {
                    roundResult = "Wrong! - \(moves[chosenMove]) was correct"
                } else {
                    playerScore -= 1
                    roundResult = "Wrong! - \(moves[chosenMove]) was correct"
                }
                    }
        questionsAnswered += 1
        showResult = true
            }
        
    
    func shoot() {
        if questionsAnswered == 10 {
            gameOver = true
        }
        playerWin.toggle()
        chosenMove = Int.random(in: 0..<3)
    }
    
    func reset() {
        playerScore = 0
        questionsAnswered = 0
        shoot()
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
