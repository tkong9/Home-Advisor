//
//  ViewController.swift
//  HomeAdvisor
//
//  Created by TAEWON KONG on 1/27/20.
//  Copyright © 2020 TAEWON KONG. All rights reserved.
//

import UIKit

class ProsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pros: [ProModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Pros"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DetailsViewCell", bundle: nil), forCellReuseIdentifier: "proCell")
        let jsonObject = readJSONFromFile(fileName: "pro_data")
        if let jsonObject = jsonObject {
            parseJason(jsonObject)
        }
        //sort pros alphabetically by name.
        pros.sort(by: {$0.companyName.localizedStandardCompare($1.companyName) == .orderedAscending})
    }

     // MARK: read JSON from local file
    func readJSONFromFile(fileName: String) -> Any? {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try JSONSerialization.jsonObject(with: data)
            } catch {
                // Handle error here
                print("Could not fetch JSON file.")
            }
        }
        return json
    }
    
    // MARK: parse JSON data & append Pro instance to pros
    func parseJason(_ proData: Any) {
        if let array = proData as? NSArray {
            for obj in array {
                if let dict = obj as? NSDictionary {
                    let entityId = dict.value(forKey: "entityId") as? String ?? "n/a"
                    let companyName = dict.value(forKey: "companyName") as? String ?? "n/a"
                    let ratingCount = Int(dict.value(forKey: "ratingCount") as? String ?? "0") ?? 0
                    let compositeRating = Double(dict.value(forKey: "compositeRating") as? String ?? "0.0") ?? 0.0
                    let companyOverview = dict.value(forKey: "companyOverview") as? String ?? "n/a"
                    let canadianSP = dict.value(forKey: "canadianSP") as? Bool ?? false
                    let spanishSpeaking = dict.value(forKey: "spanishSpeaking") as? Bool ?? false
                    let phoneNumber = dict.value(forKey: "phoneNumber") as? String ?? "n/a"
                    let latitude = dict.value(forKey: "latitude") as? Double ?? 0
                    let longitude = dict.value(forKey: "longitude") as? Double ?? 0
                    let servicesOffered = dict.value(forKey: "servicesOffered") as? String ?? "n/a"
                    let specialty = dict.value(forKey: "specialty") as? String ?? "n/a"
                    let primaryLocation = dict.value(forKey: "primaryLocation") as? String ?? "n/a"
                    let email = dict.value(forKey: "email") as? String ?? "n/a"

                    let proModel = ProModel(entityId: entityId, companyName: companyName, ratingCount: ratingCount, compositeRating: compositeRating, companyOverview: companyOverview, canadianSP: canadianSP, spanishSpeaking: spanishSpeaking, phoneNumber: phoneNumber, latitude: latitude, longitude: longitude, servicesOffered: servicesOffered, specialty: specialty, primaryLocation: primaryLocation, email: email)
                    pros.append(proModel)
                }
            }
        }
    }
}

// MARK: UITableView protocols
extension ProsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailCell = tableView.dequeueReusableCell(withIdentifier: "proCell", for: indexPath) as! DetailsViewCell
        detailCell.proName.text = pros[indexPath.row].companyName
        detailCell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        let compositeRating = pros[indexPath.row].compositeRating
        let ratingCount = pros[indexPath.row].ratingCount
        
        if ratingCount <= 0 {
            detailCell.ratingInfo.text = "References Available"
            detailCell.ratingInfo.textColor = UIColor.black
            return detailCell
        }

        detailCell.ratingInfo.text = "Ratings: \(compositeRating) | \(ratingCount) rating(s)"
        if compositeRating > 4 {
            detailCell.ratingInfo.textColor = UIColor.green
        } else if compositeRating > 3 {
            detailCell.ratingInfo.textColor = UIColor.orange
        } else {
            detailCell.ratingInfo.textColor = UIColor.red
        }
        return detailCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailsVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let detailsVC = segue.destination as! DetailsVC
            detailsVC.pro = pros[(tableView.indexPathForSelectedRow?.row)!]
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }
}
