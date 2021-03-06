//
//  ExtractRecipeView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/15.
//

import SwiftUI

struct ExtractRecipeDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: ExtractRecipeDetailViewModel
    
    init(recipe: ExtractRecipe) {
        self._viewModel = .init(wrappedValue:ExtractRecipeDetailViewModel(recipe: recipe))
    }
    
    var body: some View {
        VStack {
            TitleView
            
            ReusableView
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .listStyle(.plain)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text(viewModel.recipe.title)
                            Image(systemName: "info.circle")
                                .font(.system(.subheadline))
                                .foregroundColor(.blue)
                        }
                        .onTapGesture {
                            viewModel.showBaseInfo.toggle()
                        }
                        .sheet(isPresented: $viewModel.showBaseInfo) {
                            ExtractRecipeBaseInfoView(recipe: viewModel.recipe,
                                                    viewMode: viewModel.isRecipeEditing ? .update : .read)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        // Dismiss Button
                        Button {
                            dismiss()
                        } label: {
                            HStack {
                                Image(systemName: "chevron.backward")
                                Text("추출 레시피")
                                    .padding(.leading, -5)
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            if viewModel.isRecipeEditing { viewModel.completeEditing() }
                            else { viewModel.startEditing() }
                        } label: {
                            Text(viewModel.isRecipeEditing ? "완료" : "편집")
                        }
                    }
                    
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button("완료") {
                                viewModel.sendStopFocus()
                            }
                        }
                    }
                }
        }
        .popup(isPresented: $viewModel.isPickerShowing) {
            BottomPopupView(isPresented: $viewModel.isPickerShowing) {
                MinuteSecondPicker(timeInt: viewModel.getSelectedStep().extractTime,
                                   isShowing: $viewModel.isPickerShowing)
            }
        }
        .fullScreenCover(isPresented: $viewModel.isRecipeExecuteShowing) {
            ExtractRecipeExecuteView(recipe: viewModel.recipe)
        }
        .alert(isPresented: $viewModel.isAlertShowing) {
            Alert(title: Text("미완료 항목"),
                  message: Text("작성을 완료하지 않은 항목이 있습니다."),
                  dismissButton: .default(Text("확인")))
        }
    }
}

extension ExtractRecipeDetailView {
    
    @ViewBuilder var TitleView: some View {
        HStack {
            Text("추출 단계")
                .font(.largeTitle)
                .bold()
                .padding(.leading)
            
            Button {
                viewModel.isRecipeExecuteShowing = true
            } label: {
                Image(systemName: "play.fill")
                    .font(.system(size: 15))
                    .padding(7)
                    .foregroundColor(.white)
                    .background{
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.blue)
                    }
            }
            .isHidden(viewModel.isRecipeEditing ? true : false)
            Spacer()
        }
        .padding(.top)
    }
    
    @ViewBuilder var ReusableView: some View {
        if viewModel.isRecipeEditing {
            AnyView(ListView)
        }
        else {
            AnyView(ScrollView)
        }
    }
    
    @ViewBuilder var ListView: some View {
        List {
            RecipeStepCell
            AddNewStepButton
        }
        .environment(\.editMode, viewModel.isRecipeEditing ?
            .constant(.active) : .constant(.inactive))
    }
    
    @ViewBuilder var ScrollView: some View {
        SwiftUI.ScrollView {
            RecipeStepCell
        }
    }
    
    @ViewBuilder var RecipeStepCell: some View {
        ForEach($viewModel.recipe.steps) { $step in
            ExtractRecipeDetailCell(step: $step,
                                    viewModel: self.viewModel)
            .padding(.vertical, -4)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 3.5, leading: 0, bottom: 3.5, trailing: 0))
        }
        .onMove(perform: viewModel.moveStep)
        .onDelete(perform: viewModel.deleteStep)
    }
    
    
    @ViewBuilder var AddNewStepButton: some View {
        HStack {
            Spacer()
            Image(systemName: "plus")
                .font(.system(.title))
                .padding()
            Spacer()
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(radius: 5.0)
        }
        .padding()
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        .onTapGesture {
            viewModel.addNewStep()
        }
    }
}

struct ExtractRecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = ExtractRecipeDummyData.extractRecipeList[3]
        ExtractRecipeDetailView(recipe: recipe)
    }
}
