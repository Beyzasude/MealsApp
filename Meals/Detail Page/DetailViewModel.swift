//
//  DetailViewModel.swift
//  Meals
//
//  Created by Beyza Sude Erol on 31.08.2023.
//

import Foundation

final class DetailViewModel {
    
    private var selectedMealId: Int
    private var mealDetail: DetailMeal?

    
    var onSuccess: (()->())?
    var onError: ((_ errorStr: String)->())?
    
    init(selectedMealId: Int) {
        self.selectedMealId = selectedMealId
        fetchMealDetail()
    }
    
    func fetchMealDetail() {
        let resource = Resource<RecipeDetailModel>(url: .detail(mealId: selectedMealId))
        NetworkManager.shared.fetchMeals(resource: resource) { result in
            switch result {
            case .success(let succcess):
                self.mealDetail = succcess.meals.first
                self.onSuccess?()
            case .failure(let failure):
                self.onError?(failure.localizedDescription)
            }
        }
    }
    
    var detailImageUrl: URL {
        return URL(string: mealDetail?.strMealThumb ?? "")!
    }
    
    var instructions: String {
        return "Here is how to do it -> \(mealDetail?.strInstructions ?? "")"
    }
    
    var horizontalStrings: [String] {
        let strArr = ["Name: \(mealDetail?.strMeal ?? "")",
                      "Category: \(mealDetail?.strCategory ?? "")",
                      "Area: \(mealDetail?.strArea ?? "")"]
        return strArr
    }
}
