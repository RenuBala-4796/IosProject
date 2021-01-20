//
//  ViewController.swift
//  CityRecordIos
//
//  Created by english on 2020-12-01.
//  Copyright © 2020 Renu Bala. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // connect with text fields
    
    @IBOutlet weak var cityText: UITextField!
    
    @IBOutlet weak var provinceText: UITextField!
  
    @IBOutlet weak var countryText: UITextField!
    
    @IBOutlet weak var searchText: UITextField!
    
    @IBOutlet weak var resultText: UILabel!
    
    //AppDeligate to call UIAppliction and functions
    
     var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //Save button
    
    @IBAction func saveBtn(_ sender: Any) {
        
        //getting values from text fields
        
        let cityName = self.cityText!.text
        let provinceName = self.provinceText!.text
        let countryName = self.countryText!.text
        
        //validate input values
        
        if(cityName?.isEmpty)!{
            self.cityText.layer.borderColor = UIColor.red.cgColor
            return
        }else{
            self.cityText.layer.borderColor = UIColor.black.cgColor
        }
        
        if(provinceName?.isEmpty)!{
            self.provinceText.layer.borderColor = UIColor.red.cgColor
            return
        }else{
            self.provinceText.layer.borderColor = UIColor.black.cgColor
        }
        
        if(countryName?.isEmpty)!{
            self.countryText.layer.borderColor = UIColor.red.cgColor
            return
        }else{
            self.countryText.layer.borderColor = UIColor.black.cgColor
        }
        
        // Adding new city to database(Entity: CityDetails)
        
        let newCity = NSEntityDescription.insertNewObject(forEntityName: "CityDetails", into: context)
                newCity.setValue(self.cityText!.text, forKey: "cityName")
                newCity.setValue(self.provinceText!.text, forKey: "provinceName")
                newCity.setValue(self.countryText!.text, forKey: "countryName")
                
                do {
                    try context.save()
                    self.cityText!.text = ""
                    self.provinceText!.text = ""
                    self.countryText!.text = ""
        
                } catch {
                    print(error)
                }
                
        
    }
    
    // Search button to get details about the province and country of specific city

    @IBAction func searchBtn(_ sender: Any) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CityDetails")
                let searchString = self.searchText?.text
                // ways to make search sensitive
                //request.predicate = NSPredicate(format: "cityName CONTAINS[cd] %@", searchString!) // contains case insensitive
                //request.predicate = NSPredicate(format: "cityName CONTAINS %@", searchString!) // contains case sensitive
                //request.predicate = NSPredicate(format: "cityName LIKE[cd] %@", searchString!) // like case insensitive
                //request.predicate = NSPredicate(format: "cityName ==[cd] %@", searchString!)  // equal case insensitive
        
                request.predicate = NSPredicate(format: "cityName == %@", searchString!)  // equal case sensitive
        
        //output in the tableview Cell
                
                var outputStr = ""
                do {
                   let result = try context.fetch(request)
                    if result.count > 0 {
                        for online in result {
                            let oneCity = (online as AnyObject).value(forKey: "cityName") as! String
                            let oneProvince = (online as AnyObject).value(forKey: "provinceName") as! String
                            let oneCountry = (online as AnyObject).value(forKey: "countryName") as! String
        
                            outputStr += oneCity + " | " + oneProvince + " | " + oneCountry + "\n"
                        }
                    } else {
                        outputStr = "City not found"
                    }
                self.resultText?.text = outputStr
                } catch {
                    print(error)
                }
    }
}

