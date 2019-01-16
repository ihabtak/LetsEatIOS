//
//  HomeViewController.swift
//  Letseat
//
//  Created by MAC on 26/12/2018.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import FirebaseAuth
import SQLite

class HomeViewController: UIViewController {

    var database: Connection!
    var istrueResto = false
    
    
    
    let RestaurantTable = Table("Restaurant")
    
    @IBOutlet weak var textuser: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true 
        textuser?.text = "Welcome "+(Auth.auth().currentUser?.email)!
        // Do any additional setup after loading the view.
        // Connection au table
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("letseat").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            print(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
        
        //Creation de la table Restaurant
        
        let createTable = self.RestaurantTable.create(ifNotExists: true)  { (table) in
            table.column(Expression<Int>("restaurantId"), primaryKey: true)
            table.column(Expression<String>("restaurantName"))
            table.column(Expression<String>("restaurantImage"))
            table.column(Expression<String>("restaurantSpecialty"))
           
        }
        
        
        do {
            try self.database.run(createTable)
            self.istrueResto = try self.database.scalar(self.RestaurantTable.exists)
            print("Created Restaurant")
            
        } catch {
            print(error)
        }
        if(!self.istrueResto){
            //Insertion des éléments Restaurant
            let insertRestaurant = self.RestaurantTable.insert(Expression<Int>("restaurantId") <- 0, Expression<String>("restaurantName") <- "Restaurant 1", Expression<String>("restaurantImage") <- "shop",Expression<String>("restaurantSpecialty") <- "Speciality")
            
            do {
                try self.database.run(insertRestaurant)
                print("INSERTED Restaurant")
            } catch {
                print(error)
            }
            
            let insertRestaurant2 = self.RestaurantTable.insert(Expression<Int>("restaurantId") <- 1, Expression<String>("restaurantName") <- "Restaurant 2", Expression<String>("restaurantImage") <- "shop",Expression<String>("restaurantSpecialty") <- "Speciality")
            
            do {
                try self.database.run(insertRestaurant2)
                print("INSERTED Restaurant")
            } catch {
                print(error)
            }
            
            let insertRestaurant3 = self.RestaurantTable.insert(Expression<Int>("restaurantId") <- 2, Expression<String>("restaurantName") <- "Restaurant 3", Expression<String>("restaurantImage") <- "shop",Expression<String>("restaurantSpecialty") <- "Speciality")
            
            do {
                try self.database.run(insertRestaurant3)
                print("INSERTED Restaurant")
            } catch {
                print(error)
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func HomeLogoutAction(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
    
    @IBAction func myMapbtn(_ sender: UIButton) {
        performSegue(withIdentifier: "homeToMap", sender: self)
    }
    @IBAction func btnAdd(_ sender: UIButton) {
        performSegue(withIdentifier: "homeToNewRes", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RestaurantsEditViewController {
            
            destination.fromHome = true
            
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
