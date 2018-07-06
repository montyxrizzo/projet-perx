/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class MasterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  // MARK: - Properties
  @IBOutlet var tableView: UITableView!
  @IBOutlet var searchFooter: SearchFooter!
  
  var detailViewController: DetailViewController? = nil
  var companies = [Company]()
  var filteredCompanies = [Company]()
  let searchController = UISearchController(searchResultsController: nil)
  
    
    
    
    
  // MARK: - View Setup
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup the Search Controller
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Companies"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    
    // Setup the Scope Bar
    searchController.searchBar.scopeButtonTitles = ["All", "Retail", "Dining", "Other"]
    searchController.searchBar.delegate = self
    
    // Setup the search footer
    tableView.tableFooterView = searchFooter
    
    companies = [
        Company( name:"Apple",category:"Retail", imageurl:"abc"),
        Company( name:"Walgreens",category:"Retail",imageurl: "asd"),
        Company(name:"Sephora",category:"Retail",imageurl: "asd"),
        Company(name:"Di Bruno Bros.",category:"Dining",imageurl:"asd"),
        Company( name:"Target",category:"Retail",imageurl:"asd"),
        Company( name:"7-Eleven",category:"Other",imageurl:"asd")
    ]
    

    
    if let splitViewController = splitViewController {
      let controllers = splitViewController.viewControllers
      detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if splitViewController!.isCollapsed {
      if let selectionIndexPath = tableView.indexPathForSelectedRow {
        tableView.deselectRow(at: selectionIndexPath, animated: animated)
      }
    }
    super.viewWillAppear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Table View
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering() {
      searchFooter.setIsFilteringToShow(filteredItemCount: filteredCompanies.count, of: companies.count)
      return filteredCompanies.count
    }
    
    searchFooter.setNotFiltering()
    return companies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let company: Company
    if isFiltering() {
      company = filteredCompanies[indexPath.row]
    } else {
      company = companies[indexPath.row]
    }
    cell.textLabel!.text = company.name
    cell.detailTextLabel!.text = company.category
    cell.imageView?.image = UIImage(named: company.name!)
    return cell
    }
  // MARK: - Segues
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let company: Company
        if isFiltering() {
          company = filteredCompanies[indexPath.row]
        } else {
          company = companies[indexPath.row]
        }
        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
        controller.detailCompany = company
        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        controller.navigationItem.leftItemsSupplementBackButton = true
      }
    }
  }
  
  // MARK: - Private instance methods
  
  func filterContentForSearchText(_ searchText: String, scope: String = "All") {
    filteredCompanies = companies.filter({( company : Company) -> Bool in
      let doesCategoryMatch = (scope == "All") || (company.category == scope)
      
      if searchBarIsEmpty() {
        return doesCategoryMatch
      } else {
        return doesCategoryMatch && company.name!.lowercased().contains(searchText.lowercased())
      }
    })
    tableView.reloadData()
  }
  
  func searchBarIsEmpty() -> Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func isFiltering() -> Bool {
    let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
  }
}

extension MasterViewController: UISearchBarDelegate {
  // MARK: - UISearchBar Delegate
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
  }
}

extension MasterViewController: UISearchResultsUpdating {
  // MARK: - UISearchResultsUpdating Delegate
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    filterContentForSearchText(searchController.searchBar.text!, scope: scope)
  }
}
