//
//  ViewController.swift
//  Meals
//
//  Created by Beyza Sude Erol on 26.08.2023.
//

import UIKit

final class SearchViewController: UIViewController {

    @IBOutlet weak var mainSearchBar: UISearchBar!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollection()
        prepareNavigationBar()
        
        viewModel.onSuccess = reloadCollectionView()
        viewModel.onError = showError()
    }
    
    func prepareCollection() {
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
    }
    
    func prepareNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Search"
    }
    
    func prepareSearchBar() {
        mainSearchBar.delegate = self
    }
    
    func showError() -> (_ errorStr: String) -> () {
        return { errorStr in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error!", message: errorStr, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .cancel)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            }
        }
    }
    
    func reloadCollectionView() -> () -> () {
        return {
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.loadMeals(searchText: searchText)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.size.width - 40) / 2 , height: collectionView.bounds.size.height / 3 )
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.titleLabel.text = viewModel.cellForRow(at: indexPath)?.strMeal
        cell.subtitleLabel.text = viewModel.cellForRow(at: indexPath)?.strCategory
        cell.cellImageView.downloaded(from: viewModel.cellForRow(at: indexPath)?.strMealThumb ?? "", contentMode: .scaleAspectFill)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            let detailViewModel = DetailViewModel(selectedMealId: Int(viewModel.cellForRow(at: indexPath)?.idMeal ?? "0") ?? 0)
            vc.viewModel = detailViewModel
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
