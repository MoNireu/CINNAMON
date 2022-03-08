//
//  AccountSetupView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/07.
//

import SwiftUI

struct AccountSetupView: View {
    @ObservedObject private var viewModel: AccountSetupViewModel
    
    init(viewModel: AccountSetupViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Button {
                print()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 20.0, weight: .bold))
                    .padding(.horizontal)
                    .foregroundColor(.gray)
                
                Spacer()
            }

            Spacer()
            Spacer()
            
            HStack {
                ProgressView()
                    .padding()
                    .hidden()
                
                ZStack {
                    Rectangle()
                        .frame(height: 2.0)
                        .padding(.top, 50.0)
                    
                    TextField("아이디 입력", text: $viewModel.myId)
                        .disableAutocorrection(true)
                        .multilineTextAlignment(.center)
                        .font(.system(.title))
                        .onTapGesture {
                            print("Log -", #fileID, #function, #line, "아이디 입력시작.")
                            viewModel.disableCompleteButton()
                        }
                        .onSubmit {
                            print("Log -", #fileID, #function, #line, "아이디 입력 완료.")
                            viewModel.verifyId()
                    }
                }
                
                ProgressView()
                    .padding()
                    .hidden()
            }
            
            Text("이미 존재하는 아이디 입니다.")
                .foregroundColor(.red)
            
            Spacer()
            
            HStack {
                CheckBoxView(isChecked: $viewModel.isCheckBoxChecked)
                    .onTapGesture {
                        viewModel.isCheckBoxChecked.toggle()
                        viewModel.changeCompleteButtonState()
                    }
                
                Text("개인정보 이용 동의")
            }
            
            Spacer()
            
            Button {
                print()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(height: 50.0)
                        .foregroundColor(viewModel.isCompleteButtonDisabled ? .gray : .blue)
                        .padding(.horizontal)
                        .disabled(viewModel.isCompleteButtonDisabled)
                    Text("완료")
                        .foregroundColor(.white)
                }
            }

        }
    }
}

struct AccountSetupView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSetupView(viewModel: AccountSetupViewModel()).preferredColorScheme(.light)
    }
}
