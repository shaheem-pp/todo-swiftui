//
//  AddView.swift
//  ToDoList
//
//  Created by Shaheem PP on 18/03/24.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var textFieldText: String = ""
    @State var errorText: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView{
            VStack{
                TextField("Enter your next task...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.886))
                    .cornerRadius(10)
                //                    .onChange(of: textFieldText) { newValue in
                //                        showError()
                //                    }
                //                Text(errorText)
                //                    .foregroundColor(.red)
                Button(action: saveButtonPressed, label:{
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
            .padding(14)
        }
        .navigationTitle("Add an Item 🖊️")
        .alert(isPresented: $showAlert, content: {
            getAlert()
        })
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func showError(){
        if textIsAppropriate(){
            errorText = ""
        }else {
            errorText = "Item must have more than 3 characters!"
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3{
            alertTitle = "Your New To-Do item must be atleast 3 characters 😰"
            showAlert.toggle()
            return false
        } else {
            return true
        }
    }
    
    func getAlert() -> Alert{
        Alert(title: Text(alertTitle))
    }
    
}

#Preview {
    NavigationView{
        AddView()
    }
    .environmentObject(ListViewModel())
}
