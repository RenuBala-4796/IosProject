
 //  CityViewController.swift
 //  CityRecordIos
 //
 //  Created by english on 2020-12-01.
 //  Copyright © 2020 Renu Bala. All rights reserved.
 //

 import UIKit

 class CityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
     
 
 
 @IBOutlet weak var tableView: UITableView!
   var cityArray:[CityDetails] = []
   

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        self.fetchData()
        self.tableView.reloadData()
        
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)-> Int {
         return cityArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let oneRecord = cityArray[indexPath.row]
        cell.textLabel!.text = oneRecord.cityName! + " | "
                               + oneRecord.provinceName! + "| "
                                + oneRecord.countryName!
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if editingStyle == .delete {
            let city = cityArray[indexPath.row]
            context.delete(city)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                cityArray = try context.fetch(CityDetails.fetchRequest())
            } catch {
                print(error)
            }
        }
        tableView.reloadData()
    }
    
    
    func fetchData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            cityArray = try context.fetch(CityDetails.fetchRequest())
            
        } catch {
            print(error)
        }
}
}
