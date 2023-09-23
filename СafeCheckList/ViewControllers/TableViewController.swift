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
    private var selectedIndexPath: IndexPath?
    var segueInitiatedByAccessoryDetails = false
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !dataModel.isEmpty {
            StorageManager.shared.loadFromFile(dataModel: dataModel) { cafe in
                self.dataModel = cafe
                self.tableView.reloadData()
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCellTableViewCell
        
        cell.delegate = self
        cell.tableView = tableView
        cell.cellConfig(indexPath: indexPath, dataModel: dataModel)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Process check or uncheck image
        UtilityManager.shared.dataModelCheckedImageStatus(dataModel: &dataModel, indexPath: indexPath)
        UtilityManager.shared.hideOrUnhideImage(dataModel: dataModel, tableView: tableView, indexPath: indexPath)
        StorageManager.shared.saveToFile(dataModel: dataModel)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            dataModel.remove(at: indexPath.section)
            tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let add = segue.destination as? AddViewController
        
        if segue.identifier == "addNewCafe" {
            segueInitiatedByAccessoryDetails = false
            
            add?.navigationTitle = "Add new cafe"
        } else if segue.identifier == "editCafe" {
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                segueInitiatedByAccessoryDetails = true
                
                add?.navigationTitle = "Edit cafe details"
                add?.cafeName = dataModel[indexPath.section].name
                add?.ratingCafe = dataModel[indexPath.section].rating
                add?.notes = dataModel[indexPath.section].note
            }
        }
    }
    
    @IBAction func  unwindSegueToMainScreen(segue: UIStoryboardSegue) {
        guard let addViewController = segue.source as? AddViewController else { return }
        
        if segueInitiatedByAccessoryDetails == false {
            let name = addViewController.cafeNameTextFiled.text ?? ""
            let rating = addViewController.ratingInDataMadel ?? 0
            let note = addViewController.notesAboutCafe.text ?? ""
            // Adding new cafe information to the data model
            let newSectionIndex = dataModel.count
            dataModel.append(Cafe(name: name, rating: rating, checked: false, note: note))
            // Save changes to file
            StorageManager.shared.saveToFile(dataModel: dataModel)
            
            // Inserting a new section in tableView
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.tableView.insertSections(IndexSet(integer: newSectionIndex), with: .automatic)
            }
        } else if segueInitiatedByAccessoryDetails == true {
            guard let indexPath = selectedIndexPath else { return }
            // Updating cafe information to the data model
            dataModel[indexPath.section].name = addViewController.cafeNameTextFiled.text ?? ""
            dataModel[indexPath.section].rating = addViewController.ratingInDataMadel ?? 0
            dataModel[indexPath.section].note = addViewController.notesAboutCafe.text ?? ""
            // Updating a section in a tableView
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            // Save changes to file
            StorageManager.shared.saveToFile(dataModel: dataModel)
        }
        segueInitiatedByAccessoryDetails = false
    }
    
}

// MARK: - Custom cell delegate

extension TableViewController: CustomCellDelegate {
    func starImageDidChange(imageName: String, forSection section: Int) {
        // Geting the Cafe object corresponding to the section
        var selectedCafe = dataModel[section]
        // Update the rating property of the Cafe object based on the name of the star image
        switch imageName {
            case "0stars":
                selectedCafe.rating = 0
            case "1stars":
                selectedCafe.rating = 1
            case "2stars":
                selectedCafe.rating = 2
            case "3stars":
                selectedCafe.rating = 3
            case "4stars":
                selectedCafe.rating = 4
            case "5stars":
                selectedCafe.rating = 5
            default:
                selectedCafe.rating = 0
        }
        // Updating the data model in the dataModel array and save it to a file
        dataModel[section] = selectedCafe
        StorageManager.shared.saveToFile(dataModel: dataModel)
    }
    
}

