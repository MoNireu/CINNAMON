//
//  ExtractRecipeExecute.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/31.
//

import SwiftUI

struct ExtractRecipeExecute: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(.linear)
            
            TopBarItemsView
            
            TabView {
                ExecuteStartView
                ExecuteStepView
                ExecuteStepView
                ExecuteStepView
            }
            .tabViewStyle(.page)
            
            BottomBarItemsView
        }
    }
}

extension ExtractRecipeExecute {
    
    @ViewBuilder var TopBarItemsView: some View {
        HStack {
            Button {
                self.dismiss()
            } label: {
                Image(systemName: "x.circle.fill")
                    .tint(.gray)
                    .font(.system(size: 25))
            }
            .padding()
            Spacer()
            Text("단계 ( 1 / 3 )")
            Spacer()
            Button {
                //TODO: 진동 제어
            } label: {
                Image(systemName: "iphone.radiowaves.left.and.right")
                    .tint(.gray)
                    .font(.system(size: 25))
            }
            .padding()
        }
    }
    
    
    @ViewBuilder var ExecuteStartView: some View {
        VStack {
            Spacer()
            
            VStack {
                Text("레시피 제목")
                Text("레시피 부제")
                Text("원두용량: 20g")
            }
            .frame(maxHeight: .infinity)
            
            VStack {
                Text("00:00")
                    .font(.system(size: 100))
                
                HStack {
                    Rectangle()
                        .frame(width: 300, height: 3)
                }
                .padding(.top, -30)
                
                Text("20ml")
                    .font(.largeTitle)
            }
            .frame(maxHeight: .infinity)
            .padding()
            
            Spacer()
                .frame(maxHeight: .infinity)
            
            Spacer()
        }
    }
    
    @ViewBuilder var ExecuteStepView: some View {
        VStack {
            VStack {
                Spacer()
                Text("00:00")
                    .font(.system(size: 100))
                
                HStack {
                    Rectangle()
                        .frame(width: 300, height: 3)
                }
                .padding(.top, -30)
                
                Text("20ml")
                    .font(.largeTitle)
                Spacer()
                    .visibility(.gone)
            }
            .frame(maxHeight: .infinity)
            
            VStack {
                Text("이곳에 설명이 들어갑니다. 이곳에 설명이 들어갑니다. 이곳에 설명이 들어갑니다. 이곳에 설명이 들어갑니다. 이곳에 설명이 들어갑니다. 이곳에 설명이 들어갑니다. 이곳에 설명이 들어갑니다. 이곳에 설명이 들어갑니다. 이곳에 설명이 들어갑니다. 이곳에 설명이 들어갑니다. 이곳에 설명이 들어갑니다. 이곳에 설명이 들어갑니다. 이곳에 설명이 들어갑니다. 이곳에 설명이 들어갑니다. ")
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }
            .visibility(.visible)
            .frame(maxHeight: .infinity)
        }
    }
    
    
    @ViewBuilder var BottomBarItemsView: some View {
        ZStack {
            HStack {
                Button("이전 단계") { print("") }
                    .padding()
                Spacer()
                Button("다음 단계") { print("") }
                    .padding()
            }
            
            Button("시작") { print() }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 10).fill(.blue))
                .padding()
        }
    }
}

struct ExtractRecipeExecute_Previews: PreviewProvider {
    static var previews: some View {
        ExtractRecipeExecute()
    }
}
