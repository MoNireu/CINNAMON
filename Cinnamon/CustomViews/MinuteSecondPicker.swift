//
//  MinuteSecondPicker.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/19.
//

import SwiftUI

struct MinuteSecondPicker: View {
    @Binding var timeInt: Int
    @Binding var isShowing: Bool
    @State private var minuteSelection: Int
    @State private var secondSelection: Int
    
    init(timeInt: Binding<Int>, isShowing: Binding<Bool>) {
        self._timeInt = timeInt
        self._isShowing = isShowing
        minuteSelection = Int(timeInt.wrappedValue / 60)
        secondSelection = Int(timeInt.wrappedValue % 60)
    }
    
    var minutes = [Int](0..<60)
    var seconds = [Int](0..<60)
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    timeInt = TimeConvertUtil.timeToSecond(minute: minuteSelection, second: secondSelection)
                    isShowing.toggle()
                } label: {
                    Text("완료")
                }
                .padding()
            }
            
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Picker(selection: self.$minuteSelection, label: Text("")) {
                        ForEach(0 ..< self.minutes.count) { index in
                            Text("\(self.minutes[index]) 분").tag(index)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: geometry.size.width/2, height: geometry.size.height, alignment: .center)
                    .compositingGroup()
                    .clipped()
                    
                    Picker(selection: self.$secondSelection, label: Text("")) {
                        ForEach(0 ..< self.seconds.count) { index in
                            Text("\(self.seconds[index]) 초").tag(index)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: geometry.size.width/2, height: geometry.size.height, alignment: .center)
                    .compositingGroup()
                    .clipped()
                }
            }
            .frame(height: 200)
            .padding(.bottom, 30)
        }
        .background(Color.clear)
    }
}

struct MinuteSecondPicker_Previews: PreviewProvider {
    static var previews: some View {
        MinuteSecondPicker(timeInt: .constant(10), isShowing: .constant(true))
    }
}
