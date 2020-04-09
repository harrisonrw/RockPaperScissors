//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Robert Harrison on 4/8/20.
//  Copyright © 2020 Robert Harrison. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    private var moves = ["Rock", "Paper", "Scissors"]
    
    @State private var computerMove = ""
    @State private var playerMove = ""
    @State private var message = "Choose your move"
    @State private var score = 0
    
    var body: some View {
        VStack {
            Text("Rock-Paper-Scissors")
                .font(.largeTitle)
                .fontWeight(.black)
            
            Text("Score: \(score)")
            
            Text("\(computerMove)")
            
            Text("\(message)")
            
            HStack {
                ForEach(0 ..< moves.count) { index in
                    Button(action: {
                        self.playerSelectedMove(atIndex: index)
                    }) {
                        Text(self.moves[index])
                    }
                }
            }
            
            Spacer()
            
        }
    }
    
    private func playerSelectedMove(atIndex playerIndex: Int) {
        playerMove = moves[playerIndex]
        
        let computerIndex = Int.random(in: 0...2)
        computerMove = moves[computerIndex]
        
        if (computerIndex + 1) % 3 == playerIndex {
            message = "You Win!"
            score += 10
        } else if computerIndex == playerIndex {
            message = "It's a Draw."
            score += 5
        } else {
            message = "You Lose!"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.message = "Get ready ..."
            self.computerMove = ""
            self.playerMove = ""
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.message = "Choose your move"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
