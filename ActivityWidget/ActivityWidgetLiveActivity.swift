//
//  ActivityWidgetLiveActivity.swift
//  ActivityWidget
//
//  Created by DucVinh on 14.08.2023.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ActivityWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MockData.self) { context in
            ExampleLiveActivityView(context: context)
                .activityBackgroundTint(ActivityColor.activityBackground)
                .activitySystemActionForegroundColor(ActivityColor.gray90)
                .contentTransition(.identity)
        } dynamicIsland: { context in
            return DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.center) {
                    HStack(alignment: .center, spacing: 8) {
                        Image("ic_aha")
                        Text("Tài xế đang đến điểm lấy hàng")
                            .foregroundColor(ActivityColor.gray00)
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .frame(alignment: .center)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                }
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
            } compactLeading: {
                Image("ic_aha")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(4)
                    .offset(x: -4)
            } compactTrailing: {
                Text("")
            } minimal: {
                Text("")
            }
            .keylineTint(Color.clear)
        }
    }
    
    struct ExampleLiveActivityView: View{
        @Environment(\.colorScheme) var colorScheme
        let context: ActivityViewContext<MockData>
        @State var value: Double = 0
        @State private var progress: Double = 50.0

        var body: some View {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 0, style: .continuous)
                    .fill(colorScheme == .light ? ActivityColor.lightBackground : ActivityColor.darkBackground)
                VStack(alignment: .leading, spacing: 8){
//                    Image("live_activity_logo")
//                    HStack{
//                        Text(title(status:context.state.status))
//                            .foregroundColor(colorScheme == .light ? ActivityColor.gray90 : ActivityColor.gray00)
//                            .font(.system(size: 18))
//                            .fontWeight(.bold)
//                        if context.state.status != .assigning {
//                            Text("1 phut")
//                                .foregroundColor(ActivityColor.primary50)
//                                .font(.system(size: 18))
//                                .fontWeight(.bold)
//                        }
//                    }
//                    Text(subTitle(status:context.state.status))
//                        .foregroundColor(colorScheme == .light ? ActivityColor.gray60 : ActivityColor.gray20)
//                        .font(.system(size: 16))
//                        .fontWeight(.regular)
//                        .lineLimit(2)
//                    if context.state.status == ValueStatus.assigning{
//                        RoundedRectangle(cornerRadius: 3)
//                            .frame(maxWidth: .infinity, maxHeight: 3)
//                            .overlay(ActivityColor.gray20)
//                            .padding(.top, 10)
//                    }
                    if context.state.status == ValueStatus.accepted {
                        let start = Date().addingTimeInterval(0)
                        let end = Date().addingTimeInterval(60)
                        //let range = Date()...Date().addingTimeInterval(1800)
                        //   .thumbImage( Image("ic_driver"))
                        //                            Slider(value: range,in: 100)
                        //                                            .padding(30)
                        
                        //                            Text(timerInterval: range)
                        //                                .padding()
                        //                            SimpleBarProgressView(progress: value)
//                        ZStack{
//                        ProgressView(value: context.state.value, total: 100)
//                            .progressViewStyle(AnimationStyleView())
//                            .animation(.linear(duration: 1000), value: context.state.value)
//                            .padding(.trailing, 14)
//                        Image("ic_pickup_ride")
//                            .frame(maxWidth: .infinity ,alignment: .bottomTrailing)
//                            .padding(.top, 2)
//                    }.padding(.top, 10)
                        ProgressView(timerInterval: start...end, countsDown: false)
                        ProgressView(timerInterval: start...end, countsDown: false)
                            .progressViewStyle(ProgressTimeIntervalStyle(enđDate: end, startDate: start))
                }
                        if context.state.status == ValueStatus.completed {
                            HStack(alignment: .top, spacing: 12) {
                                Image("ic_star")
                                Image("ic_star")
                                Image("ic_star")
                                Image("ic_star")
                                Image("ic_star")
                            }.padding(.top, 8)
                        }
                }.padding(EdgeInsets(top: 16, leading: 16, bottom: 22, trailing: 16))
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            
            func title(status: ValueStatus) -> String{
                switch(status){
                case .assigning:
                    return "Đang xác nhận đơn hàng"
                case .accepted:
                    return "Tài xế đang đến điểm lấy hàng"
                case .inprocess:
                    return "Tài xế đang giao hàng"
                case .completed:
                    return "Đơn hàng hoàn thành"
                }
            }
            
            func subTitle(status: ValueStatus) -> String {
                switch(status) {
                case .assigning:
                    return "Đang tìm tài xế "
                case .accepted:
                    return "59-X1 222.22 \u{2022} Honda Wave"
                case .inprocess:
                    return "this is adress, phường 12, quận 12, Thành phố Hồ Chí Minh, test over flow with long text when set maxline"
                case .completed:
                    return "Bạn có cảm thấy hài lòng"
                }
            }
        }
    }

struct ProgressTimeIntervalStyle: ProgressViewStyle {
    let enđDate: Date
    let startDate: Date
    init(enđDate: Date, startDate: Date) {
        self.enđDate = enđDate
        self.startDate = startDate
    }
    func makeBody(configuration: Configuration) -> some View {
        var currentDate = Date()
        var range = startDate.distance(to: enđDate)
        var doneRange = currentDate.distance(to: enđDate)
        let fractionComleted:Float = Float(doneRange.seconds) / Float(range.seconds)
        VStack (alignment: .leading, spacing: 8) {
            Text("\(doneRange.seconds)")
            GeometryReader { geometry in
                
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.gray)
                        .frame(maxWidth: .infinity, maxHeight: 3)
                        .frame(width: geometry.size.width)
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.blue)
                        .frame(width: (geometry.size.width - 12) * CGFloat(fractionComleted), height: 3)
                    Image("ic_driver")
                        .frame(width: (geometry.size.width + 280) * CGFloat(fractionComleted))
                }
            }
            Spacer()
        }
        
    }
}
        //Slider(value: .constant(fractionComleted)).disabled(true)
    struct AnimationStyleView: ProgressViewStyle {
        var height: Double = 3.0
        
        func makeBody(configuration: Configuration) -> some View {
            let fractionComleted = configuration.fractionCompleted ?? 0
            GeometryReader { geometry in
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.gray)
                        .frame(maxWidth: .infinity, maxHeight: 3)
                        .frame(width: geometry.size.width)
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.blue)
                        .frame(width: (geometry.size.width - 12) * fractionComleted, height: 3)
                    Image("ic_driver")
                        .frame(width: (geometry.size.width + 280) * fractionComleted)
                }
            }
        }
    }

struct SimpleBarProgressView: View {
    let progress: CGFloat
    private let bgColor = Color.green.opacity(0.2)
    private let fillColor = Color.green
    
    var body: some View {
        VStack {
            GeometryReader { bounds in
                Capsule(style: .circular)
                    .fill(bgColor)
                    .overlay {
                        HStack {
                            Capsule(style: .circular)
                                .fill(fillColor)
                                .frame(width: bounds.size.width * progress)
                            
                            Spacer(minLength: 0)
                        }
                    }
                    .clipShape(Capsule(style: .circular))
            }
            .frame(height: 15)
        }
    }
}
extension TimeInterval {
    private var milliseconds: Int {
        return Int((truncatingRemainder(dividingBy: 1)) * 1000)
    }

    public var seconds: Int {
        return Int(self) % 60
    }

    private var minutes: Int {
        return (Int(self) / 60 ) % 60
    }

    private var hours: Int {
        return Int(self) / 3600
    }

    var stringTime: String {
        if hours != 0 {
            return "\(hours)h \(minutes)m \(seconds)s"
        } else if minutes != 0 {
            return "\(minutes)m \(seconds)s"
        } else if milliseconds != 0 {
            return "\(seconds)s \(milliseconds)ms"
        } else {
            return "\(seconds)s"
        }
    }
}
