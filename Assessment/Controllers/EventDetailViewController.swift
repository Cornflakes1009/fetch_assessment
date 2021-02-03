//
//  EventDetailViewController.swift
//  Assessment
//
//  Created by HaroldDavidson on 1/28/21.
//

import UIKit

class EventDetailViewController: UIViewController {

    var eventsManager = EventsManager()
    var short_title = ""
    var display_location = ""
    var datetime_local = ""
    var image = ""
    var id = 0
    
    // MARK: - Outlets
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var headLineLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        setupBackButton()
        
        if favorites.contains(id) {
            setupLikeButton(with: "heart.fill")
        } else {
            setupLikeButton(with: "heart")
        }
        
        headLineLabel.text = short_title
        dateLabel.text = datetime_local
        locationLabel.text = display_location
        
        eventsManager.setImage(url: image, imageView: eventImageView)
    }

    func setupBackButton() {
        let backButtonLargeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .semibold, scale: .medium)
        let backButtonLargeBoldDoc = UIImage(systemName: "chevron.left", withConfiguration: backButtonLargeConfig)
        backButton.setImage(backButtonLargeBoldDoc, for: .normal)    }
    
    func setupLikeButton(with image: String) {
        let heartLargeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .light, scale: .medium)
        let heartLargeBoldDoc = UIImage(systemName: image, withConfiguration: heartLargeConfig)
        likeButton.setImage(heartLargeBoldDoc, for: .normal)
    }
    
    // MARK: - Button Actions
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        if favorites.contains(id) {
            setupLikeButton(with: "heart")
            if favorites.count <= 1 {
                favorites.removeAll()
            } else {
                print(favorites.count)
                let index = favorites.firstIndex(of: id)!
                favorites.remove(at: index)
            }
            
            defaults.setValue(favorites, forKey: "favorites")
        } else {
            setupLikeButton(with: "heart.fill")
            favorites.append(id)
            defaults.setValue(favorites, forKey: "favorites")
        }
    }
    
}
