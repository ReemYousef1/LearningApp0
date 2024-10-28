import SwiftUI

struct LearningTrackerViewModel: View {
    @State var streak = 10 // Set initial streak
    @State var totalDaysLearned = 0
    @State var usedFreezes = 2 // Example value for used freezes
    var selectedTimeFrame: String // Passed from p1
    var learningTopic: String // Passed from p1
    let maxFreezes: Int // Based on timeframe
    @State private var loggedDays: Set<Date> = [Calendar.current.startOfDay(for: Date())] // Example logged days
    @State private var frozenDays: Set<Date> = [] // Track frozen dates
    private let calendar = Calendar.current

    init(selectedTimeFrame: String, learningTopic: String) {
        self.selectedTimeFrame = selectedTimeFrame
        self.learningTopic = learningTopic

        // Set max freezes based on the selected timeframe
        switch selectedTimeFrame {
        case "Week":
            maxFreezes = 2
        case "Month":
            maxFreezes = 6
        case "Year":
            maxFreezes = 60
        default:
            maxFreezes = 0
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            // Calendar Month Navigation
            HStack {
                Button(action: { /* Handle previous month */ }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.orange)
                }
                
                Spacer()

                Text(calendarMonthYear())
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Spacer()

                Button(action: { /* Handle next month */ }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.orange)
                }
            }
            .padding(.horizontal)

            // Display day names
            HStack {
                ForEach(["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"], id: \.self) { dayName in
                    Text(dayName)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.gray)
                        .font(.caption)
                }
            }

            // Display actual dates with color indicators
            HStack(spacing: 10) {
                ForEach(currentWeekDates(), id: \.self) { date in
                    VStack {
                        Circle()
                            .fill(loggedDays.contains(date) ? Color.blue : (calendar.isDateInToday(date) ? Color.orange : Color.clear))
                            .frame(width: 30, height: 30)
                            .overlay(
                                Text("\(calendar.component(.day, from: date))")
                                    .foregroundColor(loggedDays.contains(date) ? .white : .primary)
                                    .font(.caption)
                            )
                    }
                }
            }

            // Display Streak and Freezes
            HStack(spacing: 40) {
                VStack {
                    Text("\(streak) 🔥")
                        .font(.title2)
                        .foregroundColor(.white)
                    Text("Day streak")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Divider()
                    .frame(height: 40)
                    .background(Color.white)

                VStack {
                    Text("\(usedFreezes) 🧊")
                        .font(.title2)
                        .foregroundColor(.white)
                    Text("Day frozen")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .padding()
        .background(Color.black)
        .preferredColorScheme(.dark)
    }

    // Get the month and year for display (e.g., "October 2024")
    private func calendarMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: Date())
    }

    // Get the dates for the current week
    private func currentWeekDates() -> [Date] {
        let today = Date()
        let startOfWeek = calendar.dateInterval(of: .weekOfMonth, for: today)?.start ?? today

        return (0..<7).compactMap { dayOffset in
            calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek)
        }
    }

    // Extension for hex color initialization
  
    // Preview for SwiftUI Canvas
    #Preview {
        LearningTrackerViewModel(selectedTimeFrame: "Week", learningTopic: "Swift")
    }
}
