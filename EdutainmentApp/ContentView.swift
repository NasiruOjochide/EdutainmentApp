//
//  ContentView.swift
//  EdutainmentApp
//
//  Created by Danjuma Nasiru on 13/01/2023.
//

import SwiftUI

//struct Settings: View{
//    @State private var multiplicationTable = 2
//    @State private var TableRange = 12
//    @State private var animationAmount = 1.5
//
//    var body: some View{
//
//    }
//}

struct Question {
    var question : String
    var answer : Int
}

//struct setting_preview: PreviewProvider {
//    static var previews: some View {
//        Settings()
//    }
//}

struct ContentView: View {
    
    @State private var multiplicationTable = 10
    @State private var NoOfQuestions = 10
    @State private var animationAmount = 1.5
    @State private var settingsView = true
    @State private var questions = [Question]()
    @State private var questionArrayPosition = 0
    @State private var startCount = 0
    @State private var answer : Int?
    @State private var score = 0
    @State private var showFinalAlert = false
    @FocusState private var textFieldFocused : Bool
    
    var body: some View {
        if settingsView{
            VStack(alignment: .center, spacing: 20){
                
                Text("Settings").font(.title).padding()
                
                Stepper("Choose Multiplication table: \(multiplicationTable)", value: $multiplicationTable, in: 2...12).padding().font(.title3)
                
                HStack{
                    Text("No. of Questions : \(NoOfQuestions)")
                    Spacer()
                    Spacer()
                    
                    Button{
                        NoOfQuestions -= 1
                    } label: {Image(systemName: "minus.circle")}.foregroundColor(.red)
                    Spacer()
                    Button(action: {
                        NoOfQuestions += 1
                    }, label: {Image(systemName: "plus.circle")}).foregroundColor(.green)
                }.padding().font(.title3)
                
                Button{
                    while startCount < NoOfQuestions{
                        
                        questions.append(Question(question: "What is \(startCount + 1) * \(multiplicationTable)", answer: (startCount + 1) * multiplicationTable))
                        
                        startCount += 1
                    }
                    startCount = 0
                    settingsView = false
                } label: {
                    Text("Start Game")
                }.padding().background(LinearGradient(colors: [.red, .purple], startPoint: .leading, endPoint: .trailing)).foregroundColor(.white).clipShape(RoundedRectangle(cornerRadius: 10))
                Spacer()
                
            }
        }else{
            VStack{
                Text(questions[startCount].question)
                TextField("Enter your answer", value: $answer, format: .number).keyboardType(.numberPad).focused($textFieldFocused)
                Button{
                    if startCount < questions.count-1 {
                        if answer == questions[startCount].answer{
                            score += 1
                        }
                        startCount += 1
                    }
                    
                    else{
                        if answer == questions[startCount].answer{
                            score += 1
                            
                        }
                        showFinalAlert = true
                    }
                    
                    textFieldFocused = false
                }label: {
                    Text("Submit")
                }
                
                Text("Score: \(score)")
            }.alert("Weldone", isPresented: $showFinalAlert) {
                Button{
                    startCount = 0
                    settingsView = true
                } label: {
                    Text("Try Again")
                }
            } message: {
                Text("Your final score is : \(score)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
