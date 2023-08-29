////
////  NewActivityWidgetLiveActivity.swift
////  NewActivityWidget
////
////  Created by DucVinh on 14.08.2023.
////
//
//import ActivityKit
//import WidgetKit
//import SwiftUI
//
////struct NewActivityWidgetAttributes: ActivityAttributes {
////    struct ContentState : Codable, Hashable {
////        var status : ValueStatus = .assigning
////    }
////}
////
////enum ValueStatus: String, CaseIterable, Codable, Equatable {
////    case assigning = "Assigning"
////    case accepted = "Accepted"
////    case inprocess = "Inprocess"
////    case completed = "Completed"
////}
//
//struct NewActivityWidgetLiveActivity: Widget {
//    var body: some WidgetConfiguration {
//        ActivityConfiguration(for: MockData.self) { context in
//            ExampleLiveActivityView(context: context)
//        } dynamicIsland: { context in
//            return DynamicIsland {
//                // Expanded UI goes here.  Compose the expanded UI through
//                // various regions, like leading/trailing/center/bottom
//                DynamicIslandExpandedRegion(.leading) {
//                    Text("Ahamove")
//                        .font(.system(size: 20))
//                        .fontWeight(.bold)
//                        .foregroundColor(Color(red: 254/256, green: 95/256, blue: 0/256, opacity: 1))
//                    
//                }
//                DynamicIslandExpandedRegion(.trailing) {
//                    VStack(alignment: .leading) {
//                        Text("")
//                            .font(.system(size: 16))
//                            .fontWeight(.bold)
//                    }
//                }
//                DynamicIslandExpandedRegion(.bottom) {
//                    VStack(alignment: .leading, spacing: 10) {
//                        
//                        VStack {
//                            Spacer().frame(width: 12)
//                            Text("")
//                                .font(.system(size: 14))
//                                .fontWeight(.medium)
//                        }
//                        
//                        HStack {
//                            Text("")
//                                .font(.system(size: 13))
//                                .fontWeight(.regular)
//                                .fixedSize(horizontal: false, vertical: true)
//                                .lineLimit(1)
//                        }
//                        
//                        HStack {
//                            Text("")
//                                .font(.system(size: 13))
//                                .fontWeight(.regular)
//                                .fixedSize(horizontal: false, vertical: true)
//                                .lineLimit(1)
//                        }
//                    }
//                }
//            } compactLeading: {
//                Text("")
//            } compactTrailing: {
//                Text("")
//            } minimal: {
//                Text("")
//            }
//            .keylineTint(Color.clear)
//        }
//    }
//}
//
//struct ExampleLiveActivityView: View{
//    @Environment(\.colorScheme) var colorScheme
//    let context: ActivityViewContext<MockData>
//    var body: some View {
//        ZStack {
//            VStack{
//                Image("live_activity_logo")
//                HStack{
//                    Text(title(status:context.state.status))
//                        .foregroundColor(colorScheme == .light ? ActivityColor.gray90 : ActivityColor.gray00)
//                        .font(.system(size: 18))
//                        .fontWeight(.bold)
//                    if context.state.status != .assigning {
//                        Text("1 phut")
//                            .foregroundColor(ActivityColor.primary50)
//                            .font(.system(size: 18))
//                            .fontWeight(.bold)
//                    }
//                }.padding(.horizontal, 16)
//                VStack{
//                    Text(subTitle(status:context.state.status))
//                        .foregroundColor(colorScheme == .light ? ActivityColor.gray60 : ActivityColor.gray20)
//                        .font(.system(size: 16))
//                        .fontWeight(.regular)
//                        .lineLimit(2)
//                        .padding(.horizontal, 16)
//                }
//            }
//        }.background(Color.gray)
//            .frame(maxHeight: .infinity, alignment: .bottom)
//    }
//    
//    func title(status: ValueStatus) -> String{
//        switch(status){
//        case .assigning:
//            return "Dang tim"
//        case .accepted:
//            return "Dang den"
//        case .inprocess:
//            return "Dang giao"
//        case .completed:
//            return "Da giao"
//        }
//    }
//    
//    func subTitle(status: ValueStatus) -> String {
//        switch(status) {
//        case .assigning:
//            return "Dang tim tai xe"
//        case .accepted:
//            return "Tai xe dang den"
//        case .inprocess:
//            return "Tai xe dang giao"
//        case .completed:
//            return "Giao thanh cong"
//        }
//    }
//}
