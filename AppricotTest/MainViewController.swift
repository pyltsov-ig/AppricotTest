//
//  MainViewController.swift
//  AppricotTest
//
//  Created by Igor Pyltsov on 26.04.2022.
//

import UIKit

typealias GetComplited = () -> ()

class MainViewController: UIViewController {

    @IBOutlet weak var characterTableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var pageCounterLabel: UILabel!
    
    var apiUrlString = "https://rickandmortyapi.com/api/character"
    var currentPage = 1
    
    var info = Info()
    var characterList = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterTableView.delegate = self
        characterTableView.dataSource = self
        
        getCharacterList {
            self.characterTableView.reloadData()
            self.updatePageStatus()
        }

        
        
    }
    
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        if let unwrInfoBack = info.prev {
            apiUrlString = unwrInfoBack
            currentPage -= 1
            
            getCharacterList {
                self.characterTableView.reloadData()
                self.updatePageStatus()
            }
        }
    }
    
    
    @IBAction func nextButtonAction(_ sender: Any) {
        if let unwrInfoNext = info.next {
            apiUrlString = unwrInfoNext
            currentPage += 1
            
            getCharacterList {
                self.characterTableView.reloadData()
                self.updatePageStatus()
            }
        }
        
    }
    
    func updatePageStatus() {
        pageCounterLabel.text = "Page "+String(currentPage)+" from "+String(info.pages ?? 0)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        guard let unwrCharacterRow = characterTableView.indexPathForSelectedRow?.row,
              let unwrIndexPathRow = characterTableView.indexPathForSelectedRow else {return}
        
        guard let destVC = segue.destination as? DetailViewController else {return}
        destVC.characterData = characterList[unwrCharacterRow]
        
        characterTableView.deselectRow(at: unwrIndexPathRow, animated: true)
    }
}


// TableView

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.characterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = characterTableView.dequeueReusableCell(withIdentifier: "CharCell", for: indexPath) as? CharacterTableViewCell else {return UITableViewCell()}
        
        cell.nameLabel.text = self.characterList[indexPath.row].name
        cell.speciesLabel.text = self.characterList[indexPath.row].species
        cell.genderLabel.text = self.characterList[indexPath.row].gender
        let imageUrl = URL(string: self.characterList[indexPath.row].image ?? "")
        do {
            let data = try Data(contentsOf: imageUrl!)
            let image = UIImage(data: data)
            cell.avatarImageView.image = image
        } catch {
            print(error)
        }

        cell.avatarImageView.layer.cornerRadius = 120/2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
    
    
}


//Networking

extension MainViewController {
    
    func getCharacterList(complition: @escaping GetComplited){
        
        guard let url = URL(string: apiUrlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let unwrData = data, let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode, error == nil else {return}
            do {
                let character = try JSONDecoder().decode(Character.self,from: unwrData)
                guard let unwrCharracterList = character.results else {return}
                self.characterList = unwrCharracterList
                guard let unwrInfo = character.info else {return}
                self.info = unwrInfo
        
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                complition()
            }
        }
        task.resume()
    }
}

