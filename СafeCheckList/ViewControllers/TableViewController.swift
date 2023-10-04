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
        setupUI()
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
            StorageManager.shared.saveToFile(dataModel: dataModel)
        }
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }
    
    // MARK: - Navigation
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let add = segue.destination as? AddViewController else { return }
        
        if segue.identifier == "addNewCafe" {
            segueInitiatedByAccessoryDetails = false
            SeguePrepareManager.shared.addNewCafe(to: add)
        } else if segue.identifier == "editCafe", let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
            segueInitiatedByAccessoryDetails = true
            SeguePrepareManager.shared.editCafe(to: add, model: &dataModel, indexPath: indexPath)
        }
    }
    
    @IBAction func  unwindSegueToMainScreen(segue: UIStoryboardSegue) {
        guard let addViewController = segue.source as? AddViewController else { return }
        
        // Inserting a new section in tableView
        if !segueInitiatedByAccessoryDetails {
            UnwindManager.shared.insertNewSection(from: addViewController, model: &dataModel, table: tableView)
            StorageManager.shared.saveToFile(dataModel: dataModel)
        } else if segueInitiatedByAccessoryDetails {
            // Updating cafe information to the data model
            guard let indexPath = selectedIndexPath else { return }
            UnwindManager.shared.updateCurrentSection(from: addViewController, model: &dataModel, indexPath: indexPath, table: tableView)
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

// MARK: - Methods
extension TableViewController {
    
    private func setupUI() {
        if !dataModel.isEmpty {
            StorageManager.shared.loadFromFile(dataModel: dataModel) { cafe in
                self.dataModel = cafe
                self.tableView.reloadData()
            }
        }
    }
    
}

