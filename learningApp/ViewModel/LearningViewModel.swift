
// LearningViewModel.swift
import Foundation

class LearningViewModel: ObservableObject {
    @Published var learningItems: [LearningItem] = []

    init() {
        loadLearningItems()
    }

    func loadLearningItems() {
        self.learningItems = [
            LearningItem(id: 1, title: "Swift Basics", description: "Learn the basics of Swift", completed: false),
            LearningItem(id: 2, title: "MVVM Pattern", description: "Understand MVVM in iOS", completed: false)
        ]
    }

    func markAsCompleted(item: LearningItem) {
        if let index = learningItems.firstIndex(where: { $0.id == item.id }) {
            learningItems[index] = LearningItem(
                id: item.id,
                title: item.title,
                description: item.description,
                completed: true
            )
        }
    }
}
