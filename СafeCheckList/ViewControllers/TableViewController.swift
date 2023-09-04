//
//  TableViewController.swift
//  СafeList
//
//  Created by Yury on 04/09/2023.
//

import UIKit

class TableViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    var dataModel = Cafe.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - IB Actions
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        
        if let view = sender.view {
            let section = view.tag
            
            let indexPath = IndexPath(row: 0, section: section)
            
            if let cell = tableView.cellForRow(at: indexPath) as? CustomCellTableViewCell {
                let location = sender.location(in: cell.starsRatingImage)
                
                // We check that the touch happened in the area where the stars are located
                if location.x >= 0 && location.x <= cell.starsRatingImage.bounds.width {
                    // The width of each star in the rated image
                    let starWidth = cell.starsRatingImage.bounds.width / 5
                    
                    // Determine the index of the star the user clicked on
                    let starIndex = Int(location.x / starWidth)
                    
                    
                    print("The star with index \(starIndex) was pressed in the section with index \(section)")
                    
                    // Update the image according to the selected starIndex
                    switch starIndex {
                        case 0:
                            let imageName = "1star"
                            cell.starsRatingImage.image = UIImage(named: imageName)
                        case 1:
                            let imageName = "2stars"
                            cell.starsRatingImage.image = UIImage(named: imageName)
                        case 2:
                            let imageName = "3stars"
                            cell.starsRatingImage.image = UIImage(named: imageName)
                        case 3:
                            let imageName = "4stars"
                            cell.starsRatingImage.image = UIImage(named: imageName)
                        case 4:
                            let imageName = "5stars"
                            cell.starsRatingImage.image = UIImage(named: imageName)
                        default:
                            return
                            
                            // Reloading the cell
                            tableView.reloadRows(at: [indexPath], with: .none)
                    }
                }
            }
        }
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
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            dataModel.remove(at: indexPath.section)
            tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Config TapGestureRecognizer for custom cell
        if let customCell = tableView.cellForRow(at: indexPath) as? CustomCellTableViewCell {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            customCell.starsRatingImage.addGestureRecognizer(tapGesture)
            tapGesture.numberOfTapsRequired = 1
            tapGesture.delegate = self
            tapGesture.cancelsTouchesInView = false
            tapGesture.view?.tag = indexPath.section
            
            // Process the gesture tap
            handleTap(tapGesture)
            
            // Process check or uncheck image
            dataModel[indexPath.section].checked = !dataModel[indexPath.section].checked
            
            if dataModel[indexPath.section].checked {
                customCell.uncheckedImage.isHidden = true
                customCell.checkedImage.isHidden = false
            } else {
                customCell.uncheckedImage.isHidden = false
                customCell.checkedImage.isHidden = true
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
