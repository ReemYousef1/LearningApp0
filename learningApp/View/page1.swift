//
//  p1.swift
//  learningApp
//
//  Created by Reem on 17/04/1446 AH.
//

import SwiftUI

struct p1: View {
    @State private var inputText: String = ""
    @State private var inp = ""
    @State private var selectedTimeFrame = "Month"
    let timeFrames = ["Week", "Month", "Year"]
    @State private var showLearningPage = false
    
    // Bind the TextField input
    
    var body: some View {
        
        
        ZStack {
            
            //                   Color.black // Set the background color
            //            Color.black // Set the background color
            
            //                       .ignoresSafeArea() // Ignore safe area to cover the entire screen
            
            VStack {
                //                       Text("              ")
                //                           .frame(width: 64.0, height: 64.0
                Text("🔥")
                    .font(.system(size: 45))
                    .padding(34)
                    .background(Color(hex: "#2C2C2E"))
                    .clipShape(Circle())
                    .frame(width: 129, height: 129)
                    .position(x:194 , y: 111)
                
                Text("Hello Learner!")
                    .font(.system(size: 32))
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, -37.0)
                    .position(x:120 , y:140)
                
                Text("This app will help you learn everyday !")
                    .font(.system(size: 17))
                    .fontWeight(.regular)
                    .foregroundColor(Color(hex: "#48484A"))
                    .padding(.bottom, -61.0)
                    .position(x:157, y:135)
                VStack(alignment: .leading){
                    Text("I want to learn")
                        .font(.system(size: 19))
                        .fontWeight(.bold)
                        .position(x:39, y:135)
                        .foregroundColor(.white)
            
                    TextField("Swift", text: $inp)
                        .padding(15)
                        .foregroundColor(Color.white)
                        .cornerRadius(5)
//                        .frame(maxWidth: 500)
                   
                        .foregroundColor(Color.white.opacity(0.9))
                        .padding(.bottom, 20)
                        .position(x:46, y:160)
                        Divider()
                        .background(Color.gray)
                        .frame(height: 1)
                        .padding(.horizontal,-140)
                        .position(x:46, y:160)
                }
                .padding(.horizontal, 30)
                VStack(alignment: .leading) {
                    Text("I want to learn it in a")
                        .font(.system(size: 19))
                    
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .position(x:65, y:175)
                    
                    HStack {
                        ForEach(timeFrames, id: \.self) { timeFrame in
                            Button(action: {
                                selectedTimeFrame = timeFrame
                            }) {
                                Text(timeFrame)
                                    .fontWeight(selectedTimeFrame == timeFrame ? .bold : .medium) // Make selected text bold
                                    .foregroundColor(selectedTimeFrame == timeFrame ? .black : Color(hex: "#FF9F0A")) 
                                //                                    .fontWeight(.medium)
                                    .padding()
                                    .frame(width: 91.0)
                                    .background(selectedTimeFrame == timeFrame ? Color(hex: "#FF9F0A") : Color(hex: "#2C2C2E"))
                                //                                    .foregroundColor(.black)
                                    .cornerRadius(19)
                                //                                    .position(x:46, y:209)
                            }
                            .position(x:46, y:209)
                            
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal, 30)
                
                Button(action: {
                    showLearningPage = true
                }) {
                    Text("Start")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex:"#FF9F0A"))
                        .cornerRadius(19)
                    //                                   .position(x:115, y:257)
                }
                .position(x:115, y:257)
                
                .padding(.horizontal, 85)
                .padding(.top, 40)
                .sheet(isPresented: $showLearningPage) {
                    p2(selectedTimeFrame: selectedTimeFrame, learningTopic: inp)
                    Spacer()
                }
                
            }
            .padding(.bottom, 400)
            .background(Color.black.ignoresSafeArea())
            
        } } }
    
    extension Color {
        init(hex: String) {
            let scanner = Scanner(string: hex)
            scanner.scanLocation = 1  // skip the '#'
            var rgb: UInt64 = 0
            scanner.scanHexInt64(&rgb)
            let r = Double((rgb >> 16) & 0xFF) / 255.0
            let g = Double((rgb >> 8) & 0xFF) / 255.0
            let b = Double(rgb & 0xFF) / 255.0
            self.init(red: r, green: g, blue: b)
        }
    }
    #Preview {
        p1()
    }
