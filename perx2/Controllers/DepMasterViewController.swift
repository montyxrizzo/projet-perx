///**
// * Copyright (c) 2017 Razeware LLC
// *
// * Permission is hereby granted, free of charge, to any person obtaining a copy
// * of this software and associated documentation files (the "Software"), to deal
// * in the Software without restriction, including without limitation the rights
// * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// * copies of the Software, and to permit persons to whom the Software is
// * furnished to do so, subject to the following conditions:
// *
// * The above copyright notice and this permission notice shall be included in
// * all copies or substantial portions of the Software.
// *
// * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// * THE SOFTWARE.
// */
//
//import UIKit
//import Alamofire
//import AlamofireImage
//import ElongationPreview
//
////class MasterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
////  let URL_GET_DATA = "https://simplifiedcoding.net/demos/marvel/"
//
//  // MARK: - Properties
//  @IBOutlet var tableView: UITableView!
//  @IBOutlet var searchFooter: SearchFooter!
//  var detailViewController: DetailViewController? = nil
//  var companies = [Company]()
////  var brands = [Brand]()
//  var filteredcompanies = [Company]()
//    var filteredCompanies = [Company]()
//
////  var filteredBrands = [Brands]()
//  let searchController = UISearchController(searchResultsController: nil)
//  
//  // MARK: - View Setup
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    
//    // Setup the Search Controller
//    searchController.searchResultsUpdater = self
//    searchController.obscuresBackgroundDuringPresentation = false
//    searchController.searchBar.placeholder = "Search Brands"
//    navigationItem.searchController = searchController
//    definesPresentationContext = true
//    
////    //fetching data from web api
////    Alamofire.request(URL_GET_DATA).responseJSON { response in
////
////        //getting json
////        if let json = response.result.value {
////
////            //converting json to NSArray
////            let companiesArray : NSArray  = json as! NSArray
////
////            //traversing through all elements of the array
////            for i in 0..<companiesArray.count{
////
////                //adding hero values to the hero list
////                self.companies.append(Company(
////                    name: (companiesArray[i] as AnyObject).value(forKey: "name") as? String,
////                    category: (companiesArray[i] as AnyObject).value(forKey: "category") as? String,
////                    imageurl: ((companiesArray[i] as AnyObject).value(forKey: "imageurl") as? String)!
////                ))
////
////            }
////
////            //displaying data in tableview
////            self.tableView.reloadData()
////        }
////
////    }
////
//    // Setup the Search Controller
//    searchController.searchResultsUpdater = self
//    searchController.obscuresBackgroundDuringPresentation = false
//    searchController.searchBar.placeholder = "Search Brands"
//    navigationItem.searchController = searchController
//    definesPresentationContext = true
//    
//    // Setup the Scope Bar
//    searchController.searchBar.scopeButtonTitles = ["All", "Retail", "Dining", "Other"]
//    searchController.searchBar.delegate = self
//    
//    // Setup the search footer
//    tableView.tableFooterView = searchFooter
//    
//    companies = [
//        Company( name:"Apple",category:"Retail",imageurl:"asdfasd"),
//      Company( name:"Walgreens",category:"Retail",imageurl:"asdfasd"),
//      Company(name:"Sephora",category:"Retail", imageurl:"asdfasd"),
//      Company(name:"Di Bruno Bros.",category:"Dining", imageurl:"asdfasd"),
//      Company( name:"Target",category:"Retail",imageurl:"asdfasd"),
//      Company( name:"7-Eleven",category:"Other",imageurl:"asdfasd")
//    ]
//    
//    
////    brands = [
////        Brand(category:"Retail", name:"Apple", locations: ["1273 Walnut st", "1222 Chestnut St."]),
////        Brand(category:"Retail", name:"Walgreens",locations: ["1273 Walnut st", "1222 Chestnut St."]),
////        Brand(category:"Retail", name:"Sephora",locations: ["1273 Walnut st", "1222 Chestnut St."]),
////        Brand(category:"Dining", name:"Di Bruno Bros.",locations: ["1273 Walnut st", "1222 Chestnut St."]),
////        Brand(category:"Retail", name:"Target",locations: ["1273 Walnut st", "1222 Chestnut St."]),
////        Brand(category:"Other", name:"7-Eleven",locations: ["1273 Walnut st", "1222 Chestnut St."])
////    ]
//   
//    if let splitViewController = splitViewController {
//        let controllers = splitViewController.viewControllers
//        detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
//    }
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        if splitViewController!.isCollapsed {
//            if let selectionIndexPath = tableView.indexPathForSelectedRow {
//                tableView.deselectRow(at: selectionIndexPath, animated: animated)
//            }
//        }
//        super.viewWillAppear(animated)
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    
//  // MARK: - Table View
//  func numberOfSections(in tableView: UITableView) -> Int {
//    return 1
//  }
//  
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    if isFiltering() {
//      searchFooter.setIsFilteringToShow(filteredItemCount: filteredCompanies.count, of: companies.count)
//      return filteredCompanies.count
//    }
//    
//    searchFooter.setNotFiltering()
//    return companies.count
//  }
//  
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "companycell", for: indexPath) as! CompanyTableViewCell
//    let company: Company
//
//    Alamofire.request("https://httpbin.org/image/png").responseImage { response in
//    
//        
//        if let image = response.result.value {
//              cell.companyImageView.image = image
//          
//            
//        }
//    }
//    
//    if isFiltering() {
//      company = filteredCompanies[indexPath.row]
//
//    } else {
//      company=companies[indexPath.row]
//    }
//    cell.textLabel!.text = company.name
//    cell.detailTextLabel!.text = company.category
//    return cell
//  }
//  
//  // MARK: - Segues
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == "showDetail" {
//      if let indexPath = tableView.indexPathForSelectedRow {
//        let company: Company
//        if isFiltering() {
//          company = filteredcompanies[indexPath.row]
//        } else {
//          company = companies[indexPath.row]
//        }
//        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
//        controller.detailCompany = company
//        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
//        controller.navigationItem.leftItemsSupplementBackButton = true
//      }
//    }
//  }
//  
//  // MARK: - Private instance methods
//  
//  func filterContentForSearchText(_ searchText: String, scope: String = "All") {
//    filteredcompanies = companies.filter({( company : Company) -> Bool in
//      let doesCategoryMatch = (scope == "All") || (company.category == scope)
//      
//      if searchBarIsEmpty() {
//        return doesCategoryMatch
//      } else {
//        return doesCategoryMatch && company.name!.lowercased().contains(searchText.lowercased())
//      }
//    })
//    tableView.reloadData()
//  }
//  
//  func searchBarIsEmpty() -> Bool {
//    return searchController.searchBar.text?.isEmpty ?? true
//  }
//  
//  func isFiltering() -> Bool {
//    let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
//    return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
//  }
//}
//
//extension MasterViewController: UISearchBarDelegate {
//  // MARK: - UISearchBar Delegate
//  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//    filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
//  }
//}
//
//extension MasterViewController: UISearchResultsUpdating {
//  // MARK: - UISearchResultsUpdating Delegate
//  func updateSearchResults(for searchController: UISearchController) {
//    let searchBar = searchController.searchBar
//    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
//    filterContentForSearchText(searchController.searchBar.text!, scope: scope)
//  }
//}
