//
//  DetailViewController.swift
//  Meals
//
//  Created by Beyza Sude Erol on 31.08.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet private weak var detailImageView: UIImageView!
    @IBOutlet private var horizontalLabels: [UILabel]!
    @IBOutlet private weak var instructionsLabel: UILabel!
    
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onSuccess = updateUI()
        viewModel.onError = showError()
        
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
    
    func updateUI() -> () -> () {
        return {
            DispatchQueue.main.async {
                self.detailImageView.downloaded(from: self.viewModel.detailImageUrl)
                self.instructionsLabel.text = self.viewModel.instructions
                let _ = self.horizontalLabels.enumerated().map { index, label in
                    label.text = self.viewModel.horizontalStrings[index]
                }
            }
        }
    }
}
