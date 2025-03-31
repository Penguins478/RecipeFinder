//
//  Recipe.swift
//  RecipeFinder
//
//  Created by Troy Tamura on 3/31/25.
//

import Foundation

struct RecipeAPIResponse: Decodable {
    let meals: [Recipe]
}

struct Recipe: Decodable {
    let idMeal: String
    let strMeal: String
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strYoutube: String?
    
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    
    var ingredients: [String] {
        var list: [String] = []
        for i in 1...20 {
            let mirror = Mirror(reflecting: self)
            if let ingredient = mirror.children.first(where: { $0.label == "strIngredient\(i)" })?.value as? String,
               let measure = mirror.children.first(where: { $0.label == "strMeasure\(i)" })?.value as? String,
               !ingredient.trimmingCharacters(in: .whitespaces).isEmpty {
                list.append("\(measure) \(ingredient)")
            }
        }
        return list
    }
}

