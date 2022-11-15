//
//  AddNewOrderView.swift
//  fast_coffee
//
//  Created by Nureddin Elmas on 2022-11-14.
//

import SwiftUI

struct AddNewOrderView: View {
    @State private var favoriteSize = "small"
    @State private var favoriteType = "latte"
    @State private var nameText = ""
    @State private var emailText = ""
    @ObservedObject var apiOrder : OrderViewModel
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    
   var colors = ["Red", "Green", "Blue"]
    var colorsM = ["Red" : Color.red, "Green" : Color.green, "Blue" : Color.blue]
    var body: some View {
        NavigationView {
            
        
        VStack{
            List {
                Picker("Select your type : ", selection: $favoriteType) {
                    ForEach(types, id: \.self){item in
                        Text(item)
                    }
                }.pickerStyle(.automatic)
               
                Picker("What is you favorite color", selection: $favoriteSize){
                    ForEach(sizes, id: \.self){ item in
                        Text(item)
                        
                    }
                    
                }
                .pickerStyle(.automatic)
                HStack{
                    Text("Name : ")
                    TextField("name", text: $nameText)
                }
                
                HStack{
                    Text("Email : ")
                    TextField("email", text: $emailText)
                }
               

            }.listStyle(.inset)

        }.padding(20)
                .toolbar(content: {
                    ToolbarItem {
                        Button {
                            let order = Order(name: nameText, email: emailText, type: favoriteType, size: favoriteSize)
                            apiOrder.postOrder(order: order , completion: {sonuc in
                                apiOrder.orders.append(order)
                               
                              
                            })
                            presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Text(verbatim: "Save")
                        }

                    }
                })
                .navigationTitle("Add New Order")
        }
    }
}
