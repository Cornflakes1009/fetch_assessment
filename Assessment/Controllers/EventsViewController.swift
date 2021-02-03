//
//  EventsViewController.swift
//  Assessment
//
//  Created by HaroldDavidson on 1/28/21.
//

import UIKit

class EventsViewController: UIViewController {

    var eventsManager = EventsManager()
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var tableViewTopAnchor: NSLayoutConstraint!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchTextField.leftView?.tintColor = .white
        tableView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

}

// MARK: - Search Bar Extension
extension EventsViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableViewTopAnchor.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        tableView.isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        eventsManager.fetchEvents(for: searchText)
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        if let text = searchBar.text {
//            eventsManager.fetchEvents(for: text)
//
//            tableView.reloadData()
//        }
        
        
    }
    
    // dismissing keyboard when scrolling list
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    // dismissing keyboard when search has been tapped
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - Table View Extension
extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EventsTableViewCell

        eventsManager.setImage(url: events[indexPath.row].performers[0].image, imageView: cell.cellImage)
        
        cell.favoritesImage.image = UIImage(named: "heart")
        cell.cellHeadlineLabel?.text = events[indexPath.row].short_title
        cell.cellLocationLabel?.text = events[indexPath.row].venue.display_location
        cell.cellDateLabel?.text = events[indexPath.row].datetime_local
        
        if favorites.contains(events[indexPath.row].id) {
            cell.favoritesImage.image = UIImage(named: "heart.fill")
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // determining which segue was triggered
        switch segue.identifier {
        case "detailSegue"?:
            // figuring out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                
                // passing values to detail view
                let eventDetailViewController = segue.destination as! EventDetailViewController
                eventDetailViewController.short_title = events[row].short_title
                eventDetailViewController.id = events[row].id
                eventDetailViewController.display_location = events[row].venue.display_location
                eventDetailViewController.datetime_local = events[row].datetime_local
                eventDetailViewController.image = events[row].performers[0].image
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
        
        
    }
}

// MARK: - Custom Cell
class EventsTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var favoritesImage: UIImageView!
    @IBOutlet weak var cellHeadlineLabel: UILabel!
    @IBOutlet weak var cellLocationLabel: UILabel!
    @IBOutlet weak var cellDateLabel: UILabel!
}
