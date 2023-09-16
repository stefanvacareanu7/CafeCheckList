//
//  TableViewController.swift
//  СafeList
//
//  Created by Yury on 04/09/2023.
//

import UIKit

class TableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var dataModel = Cafe.shared
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.delegate = self
        tableView.addGestureRecognizer(tapGesture)
        
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    // MARK: - Table view
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataModel.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Creating and casting custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCellTableViewCell
        
        // Configure the cell
        cell.cellConfig(indexPath: indexPath, dataModel: dataModel)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Process check or uncheck image
        dataModel[indexPath.section].checked = !dataModel[indexPath.section].checked
        
        if let customCell = tableView.cellForRow(at: indexPath) as? CustomCellTableViewCell {
            if dataModel[indexPath.section].checked {
                customCell.uncheckedImage.isHidden = true
                customCell.checkedImage.isHidden = false
            } else {
                customCell.uncheckedImage.isHidden = false
                customCell.checkedImage.isHidden = true
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            dataModel.remove(at: indexPath.section)
            tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
        }
    }
}

// MARK: - Methods

extension TableViewController: UIGestureRecognizerDelegate {
    
    // MARK: - Gesture recognizer section

    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
        let location = gestureRecognizer.location(in: tableView)
        
        if let indexPath = tableView.indexPathForRow(at: location) {
            if let cell = tableView.cellForRow(at: indexPath) as? CustomCellTableViewCell {
                
                let locationInCell = gestureRecognizer.location(in: cell)
                
                if cell.starsRatingImage.frame.contains(locationInCell) {
                    handleStarTap(at: indexPath, in: cell, location: gestureRecognizer.location(in: cell.starsRatingImage))
                } else {
                    handleCellTap(at: indexPath, in: cell)
                }
            }
        }
    }
    
    private func handleStarTap(at indexPath: IndexPath, in cell: CustomCellTableViewCell, location: CGPoint) {
        // The width of each star in the rated image
        let starWidth = cell.starsRatingImage.bounds.width / 5
        
        // Determine the index of the star the user clicked on
        let starIndex = Int(location.x / starWidth)
        
        print("The star with index \(starIndex) was pressed in the section with index \(indexPath.section)")
        
        // Update the image according to the selected starIndex
        let starImages = ["1star", "2stars", "3stars", "4stars", "5stars"]
        if starIndex >= 0 && starIndex < starImages.count {
            let imageName = starImages[starIndex]
            cell.starsRatingImage.image = UIImage(named: imageName)
        }
        
    }
    
    private func handleCellTap(at indexPath: IndexPath, in cell: CustomCellTableViewCell) {
        dataModel[indexPath.section].checked = !dataModel[indexPath.section].checked
        
        if dataModel[indexPath.section].checked {
            cell.uncheckedImage.isHidden = true
            cell.checkedImage.isHidden = false
        } else {
            cell.uncheckedImage.isHidden = false
            cell.checkedImage.isHidden = true
        }
    }
    
}

