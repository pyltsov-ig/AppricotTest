//
//  DetailViewController.swift
//  AppricotTest
//
//  Created by Igor Pyltsov on 26.04.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabes: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var characterData:Result!
    var avatar:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = characterData.name
        speciesLabel.text = characterData.species
        genderLabes.text = characterData.gender
        statusLabel.text = characterData.status
        locationLabel.text = characterData.location?.name
        guard let episodesCount = characterData.episode?.count else {return}
        episodesLabel.text = String(episodesCount) + "  episodes"
        
        let imageUrl = URL(string: self.characterData.image ?? "")
        do {
            let data = try Data(contentsOf: imageUrl!)
            let image = UIImage(data: data)
            avatarImageView.image = image
            avatarImageView.layer.cornerRadius = 240/2
        } catch {
            print(error)
        }

        
        
       
    }
    
    
    


}
