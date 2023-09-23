//
//  AddViewController.swift
//  СafeCheckList
//
//  Created by Yury on 18/09/2023.
//

import UIKit

class AddViewController: UIViewController {
    
    // MARK: - Properties
    
    var rating: Int?
    var navigationTitle: String?
    var ratingCafe: Int?
    var cafeName: String?
    
    // MARK: - IB Outlets

    @IBOutlet weak var starRatingImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var textFiled: UITextField!
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        saveButton.isEnabled = false
        navigationItem.title = navigationTitle
        textFiled.text = cafeName
        let starImageName = "\(ratingCafe ?? 0)stars"
            starRatingImage.image = UIImage(named: starImageName)
    }
    
    // MARK: - IB Actions
    
    @IBAction func gestRecognizerTapped(_ sender: UITapGestureRecognizer) {
        let starWidth = starRatingImage.bounds.width / 5
        let starIndex = Int(sender.location(in: starRatingImage).x / starWidth)
        
        Logger.log("The star with index \(starIndex) was pressed")
        
        let starImages = ["1stars", "2stars", "3stars", "4stars", "5stars"]
        if starIndex >= 0 && starIndex < starImages.count {
            let imageName = starImages[starIndex]
            starRatingImage.image = UIImage(named: imageName)
        }
        
        updateSaveButtonState()
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }

}

// MARK: - Text field delegate

extension AddViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - Methods

extension AddViewController {
    
    func updateSaveButtonState() {
        guard let text = textFiled.text else { return }
        saveButton.isEnabled = !text.isEmpty
        
        switch starRatingImage.image {
            case UIImage(named: "1stars"):
                rating = 1
            case UIImage(named: "2stars"):
                rating = 2
            case UIImage(named: "3stars"):
                rating = 3
            case UIImage(named: "4stars"):
                rating = 4
            case UIImage(named: "5stars"):
                rating = 5
            default:
                return
        }
    }
}
