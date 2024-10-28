//
//  p3.swift
//  learningApp
//
//  Created by Reem on 25/04/1446 AH.
//

import SwiftUI

struct p3: View {
    @State private var inp = ""
    @State private var selectedTimeFrame = "Month"
    let timeFrames = ["Week", "Month", "Year"]
//    init() {
//        // Customize the back button color to orange
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithTransparentBackground()
//        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.orange]
//        appearance.backButtonAppearance.normal.backgroundImage = UIImage(systemName: "chevron.backward")?.withTintColor(.orange, renderingMode: .alwaysOriginal)
//
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//    }


    var body: some View {
        VStack {
            
            Text("I want to learn")
                .font(.system(size: 19))
                .position(x:70, y:20)
                .foregroundColor(.white)
            
            TextField("Swift", text: $inp)
            //                        .background(Color(hex: "#2C2C2E")) // Background for text field
                .foregroundColor(Color.white) // Pure white text without opacity for maximum clarity
                .cornerRadius(5) // Rounded corners
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2) // Shadow for depth
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 11)
                .position(x:190, y:30)
            
            Divider()
                .frame(height: 0.5) // Set the divider thickness to 0.5 points
                .background(Color.gray) // Divider color
                .padding(.horizontal, 15)
                .position(x:190, y:20)
            
            
        
        Text("I want to learn it in a")
            .font(.system(size: 19))
            .foregroundColor(.white)
            .padding(.leading, 16)
            .position(x:90, y:15)


        
        // Time frame selection buttons
        HStack {
            ForEach(timeFrames, id: \.self) { timeFrame in
                Button(action: {
                    selectedTimeFrame = timeFrame // Update selected timeframe
                }) {
                    Text(timeFrame)
                        .fontWeight(selectedTimeFrame == timeFrame ? .bold : .medium) // Bold selected button
                        .foregroundColor(selectedTimeFrame == timeFrame ? .black : Color(hex: "#FF9F0A")) // Adjust text color
                        .padding()
                        .frame(width: 91.0) // Button width
                        .background(selectedTimeFrame == timeFrame ? Color(hex: "#FF9F0A") : Color(hex: "#2C2C2E")) // Background color
                        .cornerRadius(19) // Rounded button
                        .padding(.bottom, 502.0)
                       
                }
            }
        }
        
        .padding(.horizontal, 30) // Horizontal padding for alignment
        .padding(.vertical, 10) // Vertical padding for spacing
    }
        
        .background(Color.black.ignoresSafeArea())
        .navigationTitle("Learning goal")
        .bold()
        .navigationBarTitleDisplayMode(.inline) // Inline title mode
        .navigationBarItems(trailing: // Place the update button in the navigation bar
                            NavigationLink(
                                               destination: p2(selectedTimeFrame: selectedTimeFrame, learningTopic: inp)
                                           ) {
            Text("Update")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "#FF9F0A"))
                .padding(8)
                .cornerRadius(8)
        }
        )

} }
#Preview {
    p3()
}
