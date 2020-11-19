//
//  SearchBairroTableViewController.swift
//  Final Challenge
//
//  Created by Luiz Henrique Monteiro de Carvalho on 30/10/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import UIKit

class SearchBairroTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewBairro: UITableView!
    var bairrosDictionary = [String: [String]]()
    var bairrosSectionTitles = [String]()
    var bairros = [String]()
    var filteredBairros = [String]()
    
    var valuesBairrosTest = [String]()
    

    var bairroSelected = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        searchBar.delegate = self
        
        tableViewBairro.delegate = self
        tableViewBairro.dataSource = self
        
        bairros = HardConstants.BairroArray.bairrosArray
        filteredBairros = bairros
        
        for bairro in filteredBairros {
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

    func numberOfSections(in tableView: UITableView) -> Int {
        if searchBar.text == "" {
            return bairrosSectionTitles.count
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchBar.text == "" {
            let bairroKey = bairrosSectionTitles[section]
               if let bairroValues = bairrosDictionary[bairroKey] {
                   return bairroValues.count
               }
        } else {
            return filteredBairros.count
        }
        
        return 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HardConstants.TableView.bairroCell, for: indexPath)
              
        
        if searchBar.text == "" {
            let bairroKey = bairrosSectionTitles[indexPath.section]
            if let bairroValues = bairrosDictionary[bairroKey] {
                cell.textLabel?.text = bairroValues[indexPath.row]
            }
        } else {
             cell.textLabel?.text = filteredBairros[indexPath.row]
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchBar.text == "" {
            return bairrosSectionTitles[section]
        } else {
            return ""
        }
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
       return bairrosSectionTitles
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        bairroSelected = cell.textLabel?.text ?? ""
        performSegue(withIdentifier: "unwindToSearchViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToSearchViewController" {
            let destinationController =  segue.destination as! SearchViewController
            destinationController.bairroSelected = bairroSelected
        }
    }
    
    //SEARCH BAR
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredBairros = []
        
        if searchText == "" {
            filteredBairros = bairros
        } else {
            for bairroSearch in bairros {
                if bairroSearch.lowercased().contains(searchText.lowercased()) {
                    filteredBairros.append(bairroSearch)
                }
            }
        }
        
        self.tableViewBairro.reloadData()
    }

    //unwindToSearchViewController
    
}
   
