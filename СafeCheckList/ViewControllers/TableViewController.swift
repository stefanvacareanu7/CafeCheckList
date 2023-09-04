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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

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
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            dataModel.remove(at: indexPath.section)
            tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        dataModel[indexPath.section].checked = !dataModel[indexPath.section].checked
        guard let customCell = tableView.cellForRow(at: indexPath) as? CustomCellTableViewCell else { return }
        
        if dataModel[indexPath.section].checked {
            customCell.uncheckedImage.isHidden = true
            customCell.checkedImage.isHidden = false
        } else {
            customCell.uncheckedImage.isHidden = false
            customCell.checkedImage.isHidden = true
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
