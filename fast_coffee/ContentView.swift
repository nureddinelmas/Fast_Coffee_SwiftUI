//
//  ContentView.swift
//  fast_coffee
//
//  Created by Nureddin Elmas on 2022-11-14.
//

import SwiftUI

struct ContentView: View {
    @StateObject var orderApi = OrderViewModel()
    
    init() {
        orderApi.getOrders()
    }
    var body: some View {
        NavigationView {
            List(orderApi.orders){ order in
                Text(order.name)     
            }
            .navigationTitle("Orders")
            .listStyle(.grouped).toolbar {
                NavigationLink {
                    AddNewOrderView(apiOrder: orderApi)
                } label: {
                    Text("Add").font(.custom("", size: 18))
                }
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
