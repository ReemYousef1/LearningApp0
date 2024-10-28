import SwiftUI

struct p2: View {
    @State var streak = 0 // Start streak at 0
    @State var totalDaysLearned = 0
    @State var usedFreezes = 0
    var selectedTimeFrame: String // Passed from p1
    var learningTopic: String // Passed from p1
    let maxFreezes: Int // Based on timeframe
    @State private var loggedDays: Set<Date> = [] // Track logged dates (date-only)
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
        NavigationView {
            VStack(spacing: 20) {
                // Display the current date
                Text("\(Date(), formatter: DateFormatter().fullDateFormatter)")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.leading, -186.0)
                    .padding(.top)
                
                // Display learning topic
                HStack {
                    Text("Learning \(learningTopic)")
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                        .padding(.leading, -23.0)
                    
                    Spacer()
                    NavigationLink(destination: p3()) {
                        Text("🔥")
                            .font(.system(size: 24))
                            .padding(10)
                            .background(Color(hex: "#2C2C2E"))
                            .clipShape(Circle())
                    }
                }
                    .padding(.horizontal)
                
                // Calendar and Streaks in One Rectangle
                VStack(spacing: 20) {
                    // Calendar section
                    VStack(spacing: 10) {
                        Text(calendarMonthYear())
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .padding(.leading, -171.0)
                        
                        // Day names
                        HStack{
                            ForEach(["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"], id: \.self) { dayName in
                                Text(dayName)
                                    .font(.system(size: 14))
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        // Display actual dates with color indicators
                        HStack(spacing: 10) {
                            ForEach(currentWeekDates(), id: \.self) { date in
                                VStack {
                                    Circle()
                                        .fill(
                                            frozenDays.contains(date) ? Color.blue :
                                                loggedDays.contains(date) ? Color(hex: "#FF9F0A"):
                                                calendar.isDateInToday(date) ? Color.clear : Color.clear
                                        )
                                        .frame(width: 40, height: 40)
                                        .blur(radius: 2)
                                        .overlay(
                                            Text("\(calendar.component(.day, from: date))")
                                                .foregroundColor(.white)
                                                .font(calendar.isDateInToday(date) ? .headline.bold() : .body)
                                        )
                                }
                            }
                        }
                    }
                    Divider()
                        .frame(width: 350)
                    
                        .background(Color.white)
                    // Streak and Freeze Stats
                    HStack(spacing: 40) {
                        VStack {
                            Text("\(streak) 🔥")
                                .font(.title)
                            Text("Day streak")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Divider()
                            .frame(height: 60)
                            .background(Color.white)
                        
                        VStack {
                            Text("\(usedFreezes) 🧊")
                                .font(.title)
                            Text("Day frozen")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal)
                
                // Large Circular Button for "Learned Today" or "Day Freezed"
                Button(action: {
                    if frozenDays.contains(stripTime(from: Date())) {
                        return // Do nothing if already frozen
                    } else if loggedDays.contains(stripTime(from: Date())) {
                        handleFreezeDay()
                    } else {
                        handleLogToday()
                    }
                }) {
                    Text(frozenDays.contains(stripTime(from: Date())) ? "Day Freezed" :
                            loggedDays.contains(stripTime(from: Date())) ? "Learned Today" : "Log today as Learned")
                    .font(.title2)
                    .bold()
                    .frame(width: 250, height: 250)
                    .background(frozenDays.contains(stripTime(from: Date())) ? Color.blue : Color.orange)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                }
                .padding()
                
                // Freeze Day Button
                Button(action: { handleFreezeDay() }) {
                    Text("Freeze day")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(usedFreezes < maxFreezes ? Color.blue : Color.gray)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .disabled(frozenDays.contains(stripTime(from: Date())) || usedFreezes >= maxFreezes)
                
                // Freeze Info Text
                Text("\(usedFreezes) out of \(maxFreezes) freezes used")
                    .foregroundColor(.gray)
                    .padding(.top, -17.0)
            }
            .padding()
            .background(Color.black)
            .preferredColorScheme(.dark)
        }
    } // eof nav

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

    // Handle logging today
    private func handleLogToday() {
        let today = stripTime(from: Date())

        guard !loggedDays.contains(today) else { return } // Ensure day is not logged more than once

        streak += 1
        loggedDays.insert(today)
        totalDaysLearned += 1
    }

    // Handle freezing a day
    private func handleFreezeDay() {
        let today = stripTime(from: Date())

        if !frozenDays.contains(today) && usedFreezes < maxFreezes {
            frozenDays.insert(today)
            usedFreezes += 1
        }
    }

    // Function to strip the time from a date
    private func stripTime(from date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from: components) ?? date
    }
}

// Extension for date formatting
extension DateFormatter {
    var fullDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMM" // Example: "Wednesday, 11 SEP"
        return formatter
    }
}

// Preview for SwiftUI Canvas
#Preview {
    p2(selectedTimeFrame: "Week", learningTopic: "Swift")
}
