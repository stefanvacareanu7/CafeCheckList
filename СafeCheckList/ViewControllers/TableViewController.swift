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
    var selectedIndexPath: IndexPath?
    var segueInitiatedByAccessoryDetails = false
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !dataModel.isEmpty {
            StorageManager.shared.loadFromFile(dataModel: dataModel) { cafe in
                self.dataModel = cafe
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
            }
        }
    }
    
    @IBAction func  unwindSegueToMainScreen(segue: UIStoryboardSegue) {
        guard let addViewController = segue.source as? AddViewController else { return }
        
        if segueInitiatedByAccessoryDetails == false {
            let name = addViewController.textFiled.text ?? ""
            let rating = addViewController.rating ?? 0
            // Добавление новой информации о кафе в модель данных
            let newSectionIndex = dataModel.count
            dataModel.append(Cafe(name: name, rating: rating, checked: false))
            StorageManager.shared.saveToFile(dataModel: dataModel)
            
            // Вставка новой секции в tableView
            tableView.insertSections(IndexSet(integer: newSectionIndex), with: .automatic)
        } else if segueInitiatedByAccessoryDetails == true {
            guard let indexPath = selectedIndexPath else { return }
            
            dataModel[indexPath.section].name = addViewController.textFiled.text ?? ""
            dataModel[indexPath.section].rating = addViewController.rating ?? 0
            tableView.reloadRows(at: [indexPath], with: .automatic)
            StorageManager.shared.saveToFile(dataModel: dataModel)

        }
        segueInitiatedByAccessoryDetails = false
    }
    
}

extension TableViewController: CustomCellDelegate {
    // Реализуем метод делегата для обновления модели данных
    func starImageDidChange(imageName: String, forSection section: Int) {
        // Получаем объект Cafe, соответствующий секции
        var selectedCafe = dataModel[section]
        
        // Обновляем свойство rating объекта Cafe на основе имени изображения звезды
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
        
        // Обновляем модель данных в массиве dataModel
        dataModel[section] = selectedCafe
    }
    
}

