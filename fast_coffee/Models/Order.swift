




import Foundation

struct Order : Codable, Identifiable {
    let id = UUID()
    let name : String
    let email : String
    let type : String
    let size : String
    
}

enum CoffeType : String, Codable, CaseIterable{
    case cappucino
    case latte
    case expresso
    case cartado
}

var types: [String] {
    return CoffeType.allCases.map { $0.rawValue.capitalized }
}

var sizes:[String] {
    return CoffeSize.allCases.map{ $0.rawValue.capitalized }
}

enum CoffeSize : String, Codable, CaseIterable {
    case small
    case medium
    case large
}
