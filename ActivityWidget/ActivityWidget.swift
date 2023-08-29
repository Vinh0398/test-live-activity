//
////    ActivityWidget.swift
////    ActivityWidget
////
////    Created by DucVinh on 14.08.2023.
////
//
// import WidgetKit
// import SwiftUI
//
// struct Provider: TimelineProvider {
//     func placeholder(in context: Context) -> SimpleEntry {
//         SimpleEntry(date: Date())
//     }
//
//     func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//         let entry = SimpleEntry(date: Date())
//         completion(entry)
//     }  
//
//     func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//         var entries: [SimpleEntry] = []
//
////           Generate a timeline consisting of five entries an hour apart, starting from the current date.
//         let currentDate = Date()
//         for hourOffset in 0 ..< 5 {
//             let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//             let entry = SimpleEntry(date: entryDate)
//             entries.append(entry)
//         }
//
//         let timeline = Timeline(entries: entries, policy: .atEnd)
//         completion(timeline)
//     }
// }
//
// struct SimpleEntry: TimelineEntry {
//     let date: Date
// }
//
// struct ActivityWidgetEntryView : View {
//     var entry: Provider.Entry
//
//     var body: some View {
//         Text(entry.date, style: .time)
//     }
// }
//
// struct ActivityWidget: Widget {
//     let kind: String = "ActivityWidget"
//
//     var body: some WidgetConfiguration {
//         StaticConfiguration(kind: kind, provider: Provider()) { entry in
//             ActivityWidgetEntryView(entry: entry)
//         }
//         .configurationDisplayName("My Widget")
//         .description("This is an example widget.")
//     }
// }
//
// struct ActivityWidget_Previews: PreviewProvider {
//     static var previews: some View {
//         ActivityWidgetEntryView(entry: SimpleEntry(date: Date()))
//             .previewContext(WidgetPreviewContext(family: .systemSmall))
//     }
// }
