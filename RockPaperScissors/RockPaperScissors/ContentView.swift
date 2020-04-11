//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Robert Harrison on 4/8/20.
//  Copyright © 2020 Robert Harrison. All rights reserved.
//

import SwiftUI

struct ComputerImageView: View {
    var computerMove: String
    
    private let computerMoveImages = [
        "Rock": "rock-large",
        "Paper": "paper-large",
        "Scissors": "scissors-large"
    ]
    
    var body: some View {
        Image(computerMoveImages[computerMove] ?? "no-move")
            .renderingMode(.original)
    }
}

typealias PlayerSelectedMoveAtIndex = (_ playerIndex: Int) -> ()

struct PlayerInputView: View {
    
    var moves: [String]
    var playerMove: String
    var playerSelectedMoveAtIndex: PlayerSelectedMoveAtIndex
    
    private let moveImages = [
        "Rock": "rock-small",
        "Paper": "paper-small",
        "Scissors": "scissors-small"
    ]
    
    var body: some View {
        HStack(spacing: 40) {
            ForEach(0 ..< moves.count) { index in
                Button(action: {
                    self.playerSelectedMoveAtIndex(index)
                }) {
                    Image(self.moveImages[self.moves[index]]!)
                        .foregroundColor(self.playerMove == self.moves[index] ? Color(red: 94.0/255.0, green: 53.0/255.0, blue: 177.0/255.0) : .black)
                }
            }
        }
    }
    
}

struct ContentView: View {
    
    private var moves = ["Rock", "Paper", "Scissors"]
    
    @State private var computerMove = ""
    @State private var playerMove = ""
    @State private var message = "Choose your move"
    @State private var score = 0
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Rock-Paper-Scissors")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(Color(red: 94.0/255.0, green: 53.0/255.0, blue: 177.0/255.0))
            
            Text("Score: \(score)")
                .font(.system(size: 20.0, weight: .medium))
            
            Spacer()
            
            ComputerImageView(computerMove: self.computerMove)
            
            Spacer()
            
            Text("\(message)")
                .font(.system(size: 20.0, weight: .medium))
            
            PlayerInputView(moves: self.moves, playerMove: self.playerMove) { index in
                self.playerSelectedMove(atIndex: index)
            }
        }
    }
    
    private func playerSelectedMove(atIndex playerIndex: Int) {
        playerMove = moves[playerIndex]
        
        let computerIndex = Int.random(in: 0...2)
        computerMove = moves[computerIndex]
        
        if (computerIndex + 1) % 3 == playerIndex {
            message = "\(playerMove) beats \(computerMove). You Win!"
            score += 10
        } else if computerIndex == playerIndex {
            message = "It's a Draw."
            score += 5
        } else {
            message = "\(computerMove) beats \(playerMove). You Lose!"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.message = "Get ready ..."
            self.computerMove = ""
            self.playerMove = ""
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
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
