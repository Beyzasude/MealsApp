//
//  SearchViewModel.swift
//  Meals
//
//  Created by Beyza Sude Erol on 29.08.2023.
//

import Foundation

final class SearchViewModel {
    
    //closure yapısıdır.
    var onSuccess: (() -> ())?
    var onError: ((_ errorStr: String) -> ())?
    
    var meals: [Meal]?
    
    
    func loadMeals(searchText: String) {
        let resource = Resource<RecipeModel>(url: .search(searchText: searchText))
        NetworkManager.shared.fetchMeals(resource: resource) { result in
            switch result {
            case .success(let succcess):
                self.meals = succcess.meals
                self.onSuccess?()
            case .failure(let failure):
                self.onError?(failure.localizedDescription)
            }
        }
    }
    
    func cellForRow(at indexPath: IndexPath) -> Meal? {
        return meals?[indexPath.row]
    }
    
    func numberOfItems(in section: Int) -> Int {
        return meals?.count ?? 0
    }
    
}
