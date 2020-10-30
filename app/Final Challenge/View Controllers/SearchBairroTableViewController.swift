//
//  SearchBairroTableViewController.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 30/10/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class SearchBairroTableViewController: UITableViewController {
    
    var bairrosDictionary = [String: [String]]()
    var bairrosSectionTitles = [String]()
    var bairros = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bairros = HardConstants.BairroArray.bairrosArray
        
        for bairro in bairros {
            let bairroKey = String(bairro.prefix(1))
            if var bairroValues = bairrosDictionary[bairroKey] {
                bairroValues.append(bairro)
                bairrosDictionary[bairroKey] = bairroValues
            } else {
                bairrosDictionary[bairroKey] = [bairro]
            }
        }
        
        bairrosSectionTitles = [String](bairrosDictionary.keys)
        bairrosSectionTitles = bairrosSectionTitles.sorted(by: {$0 < $1})
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return bairrosSectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let bairroKey = bairrosSectionTitles[section]
           if let bairroValues = bairrosDictionary[bairroKey] {
               return bairroValues.count
           }
               
           return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HardConstants.TableView.bairroCell, for: indexPath)
              
            let bairroKey = bairrosSectionTitles[indexPath.section]
            if let bairroValues = bairrosDictionary[bairroKey] {
                cell.textLabel?.text = bairroValues[indexPath.row]
            }

            return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return bairrosSectionTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
       return bairrosSectionTitles
   }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
   
