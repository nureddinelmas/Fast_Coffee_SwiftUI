//
//  OrderViewModel.swift
//  fast_coffee
//
//  Created by Nureddin Elmas on 2022-11-14.
//

import Foundation

enum HttpMethod : String {
    case get = "GET"
    case post = "POST"
}
struct Resource {
   
    let url : URL = URL(string: "https://warp-wiry-rugby.glitch.me/orders")!
    let httpMethod: HttpMethod = .get
    let body : Data? = nil
}

enum NetworkError : Error {
    case domainError
    case UrlError
    case resultError
}

class OrderViewModel : ObservableObject {
    @Published var orders = [Order]()
    
    
    init() {
        getOrders()
    }
    
    func getOrders() {

        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else { fatalError("URL is not exist") }
       
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
           
            if let data = data, error == nil {
              
                let result = try? JSONDecoder().decode([Order].self, from: data)
               
                if let result = result {
                    
                    DispatchQueue.main.async {
                        self.orders = result
                        print(self.orders)
                    }
                }
            }
        }.resume()
        
    }
    
    
    func postOrder(order: Order, completion: @escaping (Bool) -> Void ){
       
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else { fatalError("URL is not exist") }
       

        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("Error encoding order! ")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print(request)
        
        URLSession.shared.dataTask(with: request) { result, _, error in
           
            if let result = result {
                try? JSONDecoder().decode(Order.self, from: result)
                completion(true)
            } else {
                completion(false)
            }
          
        }.resume()
       
    }
}
