//
//  ContentView.swift
//  GuessHand
//
//  Created by Aaron on 2021/4/1.
//  Copyright © 2021 AaronDeng. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var comment: String = "电脑"
    let handsContents: [String] = ["石头", "剪刀", "布"]
    var handsFree: [String] = ["✊🏻", "✌🏻", "✋🏻"]
    @State var resultContent: String = "pending.."
    @State var correctCount: Int = Int.random(in: 0..<3)
    @State var buttonWasPresed: Bool = false
    @State var totalCount: Int = 0
    @State var nowScore: Int = 0
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ScoreView(content: "Total Count: ", nowScore: totalCount)
                    .offset(y: -50)
                VStack {
                    Text("\(comment): \(handsContents[correctCount])")
                        .font(.title)
                        .foregroundColor(Color.white)
                    HandView(content: handsFree[correctCount])
                }
                Text("\(resultContent)")
                    .font(.title)
                    .padding(.vertical, 75.0)
                    .foregroundColor(Color.orange)
//                    .animation(.easeInOut(duration: 0.5))
                HStack(spacing: 20) {
                    ForEach(0 ..< handsFree.count) { number in
                        Button(action: {
                            self.correctCount = Int.random(in: 0 ..< 3)
                            self.winGame(number: number)
                        }) {
                            HandView(content: self.handsFree[number], buttonWasPresed: self.buttonWasPresed)
                        }
                    }
                }
                ScoreView(content: "Your score: ", nowScore: nowScore)
                    .padding(.vertical, 30)
                Button(action: {
                    self.totalCount = 0
                    self.nowScore = 0
                }) {
                    Text("重新开始")
                        .frame(width: 150, height: 50)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .foregroundColor(Color.black)
                }
            }

        }
    }
    
    func winGame(number: Int) -> Void {
        totalCount += 1
        
        if correctCount+1 == number || correctCount - 2 == number  {
            // 电脑胜
            self.resultContent = "电脑胜利"
            nowScore -= 1
        } else if correctCount == number {
            // 平局
            self.resultContent = "平局"
        } else {
            // 玩家胜
            self.resultContent = "您获胜"
            nowScore += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HandView: View {
    var content: String = "✊🏻"
    var buttonWasPresed: Bool = false
    var body: some View {
        ZStack {
            if buttonWasPresed {
                Circle()
                    .stroke(Color.orange, lineWidth: 4)
                    .frame(width: 100, height: 100)
            } else {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 100, height: 100)
            }
            Text(content)
                .font(.largeTitle)
        }
    }
}

struct ScoreView: View {
    var content: String = ""
    var nowScore: Int = 0
    var body: some View {
        HStack {
            Text(content)
                .font(.headline)
            Text("\(nowScore)")
                .font(.title)
                .foregroundColor(Color.red)
        }
    }
}
 
