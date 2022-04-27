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
    
    var characterList = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterTableView.delegate = self
        characterTableView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCharacterList {
            self.characterTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        guard let unwrCharacterRow = characterTableView.indexPathForSelectedRow?.row,
              let unwrIndexPathRow = characterTableView.indexPathForSelectedRow else {return}
        
        
        guard let destVC = segue.destination as? DetailViewController else {return}
        destVC.characterData = characterList[unwrCharacterRow]
        
//        guard let cell = characterTableView.dequeueReusableCell(withIdentifier: "CharCell", for: unwrCharacterRow) as? CharacterTableViewCell else {return}
        
        guard let cell = characterTableView.cellForRow(at: unwrIndexPathRow) else {return}
        //destVC.avatar = cell.avatarImageView.image
    
        
        
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
        //cell.avatarImageView.image = UIImage(named: "1")
        let imageUrl = URL(string: self.characterList[indexPath.row].image ?? "")
        do {
            let data = try Data(contentsOf: imageUrl!)
            let image = UIImage(data: data)
            cell.avatarImageView.image = image
        } catch {
            print(error)
        }
        //let avatar =
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
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let unwrData = data else {return}
            let jsonString = String(data: unwrData, encoding: .utf8)
            //print(jsonString)
            do {
                let character = try JSONDecoder().decode(Character.self,from: unwrData)
                guard let unwrCharracterList = character.results else {return}
                self.characterList = unwrCharracterList
               
//                for item in charList {
//                    self.characterList.append(item)
//                }
//                print(self.characterList.count)
//                for item in self.characterList {
//                    print(item.name)
//                }
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

