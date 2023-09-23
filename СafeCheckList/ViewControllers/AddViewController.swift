//
//  AddViewController.swift
//  СafeCheckList
//
//  Created by Yury on 18/09/2023.
//

import UIKit

class AddViewController: UIViewController {
    
    // MARK: - Properties
    
    var ratingInDataMadel: Int?
    var navigationTitle: String?
    var ratingCafe: Int?
    var cafeName: String?
    var notes: String?
    private var originalNotesText: String?
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var starRatingImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var notesAboutCafe: UITextView!
    @IBOutlet weak var cafeNameTextFiled: UITextField!
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = navigationTitle
        notesAboutCafe.layer.borderWidth = 1.0
        notesAboutCafe.layer.borderColor = UIColor.systemGray6.cgColor
        notesAboutCafe.layer.cornerRadius = 8.0
        notesAboutCafe.text = notes
        originalNotesText = notesAboutCafe.text
        cafeNameTextFiled.text = cafeName
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

// MARK: - Text view delegate

extension AddViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateSaveButtonState()
    }
    
}

// MARK: - Methods

extension AddViewController {
    
    func updateSaveButtonState() {
        guard let text = cafeNameTextFiled.text else { return }
        
        let currentTextViewText = notesAboutCafe.text ?? ""
        let isTextViewChanged = currentTextViewText != originalNotesText
        
        saveButton.isEnabled = !text.isEmpty || isTextViewChanged
        
        switch starRatingImage.image {
            case UIImage(named: "1stars"):
                ratingInDataMadel = 1
            case UIImage(named: "2stars"):
                ratingInDataMadel = 2
            case UIImage(named: "3stars"):
                ratingInDataMadel = 3
            case UIImage(named: "4stars"):
                ratingInDataMadel = 4
            case UIImage(named: "5stars"):
                ratingInDataMadel = 5
            default:
                return
        }
    }
}
