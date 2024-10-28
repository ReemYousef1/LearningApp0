
// ContentView.swift
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LearningViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.learningItems) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.title).font(.headline)
                        Text(item.description).font(.subheadline)
                    }
                    Spacer()
                    if item.completed {
                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                    } else {
                        Button(action: { viewModel.markAsCompleted(item: item) }) {
                            Text("Complete")
                        }
                    }
                }
            }
            .navigationTitle("Learning Items")
        }
    }
}
