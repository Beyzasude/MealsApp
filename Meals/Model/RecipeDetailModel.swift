//
//  RecipeDetailModel.swift
//  Meals
//
//  Created by Beyza Sude Erol on 31.08.2023.
//

import Foundation

struct RecipeDetailModel: Codable {
    let meals: [DetailMeal]
}

struct DetailMeal: Codable {
    let strMeal: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
}
