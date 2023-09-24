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
        updateUI()
    }
    
    // MARK: - IB Actions
    
    @IBAction func gestRecognizerTapped(_ sender: UITapGestureRecognizer) {
        ActionManager.shared.updateStarsRating(image: starRatingImage, in: sender)
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
        UtilityManager.shared.updateSaveButton(cafeName: cafeNameTextFiled, 
                                               notes: notesAboutCafe,
                                               button: saveButton,
                                               image: starRatingImage,
                                               rating: &ratingInDataMadel,
                                               originalNotes: originalNotesText)
    }
    
    private func updateUI() {
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
    
}
