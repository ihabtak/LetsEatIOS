//
//  RestaurantsEditViewController.swift
//  Letseat
//
//  Created by MAC on 26/12/2018.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import SQLite

class dishViewCell: UITableViewCell {
    @IBOutlet weak var imgDish: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var imgType: UIImageView!
    
    
}
class RestaurantsEditViewController: UIViewController {

    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var imgResto: UIImageView!
    @IBOutlet weak var txtSpec: UITextField!
    @IBOutlet weak var txtName: UITextField!
    var database: Connection!
    var fromHome: Bool = false
    var fromList: Bool = false
    var passedValue: Int = 0
    var restos: [Restaurant] = []
    var dishes = [Dish(dishId:1,dishName:"dish1",dishImage:UIImage(named:"imagedish")!,dishPrice:12.00,dishType:"Type1"),Dish(dishId:2,dishName:"dish2",dishImage:UIImage(named:"imagedish")!,dishPrice:12.00,dishType:"Type2"),Dish(dishId:3,dishName:"dish3",dishImage:UIImage(named:"imagedish")!,dishPrice:12.00,dishType:"Type3")]
    /*var restos = [Restaurant(restaurantId:1,restaurantName:"Res1",restaurantImage:"shop",restaurantSpecialty:"Spec1"),Restaurant(restaurantId:2,restaurantName:"Rest2",restaurantImage:"shop",restaurantSpecialty:"Spec2"),Restaurant(restaurantId:3,restaurantName:"Res3",restaurantImage:"shop",restaurantSpecialty:"Spec3")]*/
    override func viewDidLoad() {
        super.viewDidLoad()
        restos = RestaurantsManager.sharedManager.loadData()
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("letseat").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
        self.title="Edit Restaurant" 

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        if(fromList){
            imgResto.image = UIImage(named: restos[passedValue].restaurantImage)
            txtSpec.text = restos[passedValue].restaurantSpecialty
            txtName.text = restos[passedValue].restaurantName
            print(dishes.count)
            
        }
        if(fromHome){
            dishes = []
            btnDelete.isEnabled = false
            
        }

        
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Begin dish fill")
        let cell = tableView.dequeueReusableCell(withIdentifier: "dishCellEdit", for: indexPath) as! dishViewCell
        
        let dish = dishes[indexPath.row]
        cell.imgDish?.image = dish.dishImage
        cell.lblName?.text = dish.dishName
        cell.lblPrice?.text = String(dish.dishPrice)+"$"
        cell.lblType?.text = dish.dishType
        cell.imgType?.image = UIImage(named: dish.dishType)
        print("End dish fill")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    @IBAction func btnApply(_ sender: UIButton) {
        if (txtSpec.text?.isEmpty)! || (txtName.text?.isEmpty)! {
            let alert = UIAlertController(title: "Error editing", message: "Please make sure you entered all the informations.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else
        {
            
            if(fromList){
                let sresto = Table("restaurant").filter(Expression<Int>("restaurantId") == restos[passedValue].restaurantId)
                let uresto = sresto.update(Expression<String>("restaurantName") <- txtName.text!, Expression<String>("restaurantSpecialty") <- txtSpec.text!)
                do {
                    try self.database.run(uresto)
                    print("resto update")
                } catch {
                    print(error)
                }
                
            }
            if(fromHome){
                let newrestaurant = Restaurant()
                let lastResto = restos.last
                newrestaurant.restaurantName = txtName.text!
                newrestaurant.restaurantSpecialty = txtSpec.text!
                newrestaurant.restaurantId = (lastResto?.restaurantId)! + 1
                
                let insertresto = Table("restaurant").insert(Expression<Int>("restaurantId") <-  newrestaurant.restaurantId, Expression<String>("restaurantName") <- newrestaurant.restaurantName, Expression<String>("restaurantImage") <- "shop", Expression<String>("restaurantSpecialty") <- newrestaurant.restaurantSpecialty)
                
                do {
                    try self.database.run(insertresto)
                    print("INSERTED New Resto")
                } catch {
                    print(error)
                }

            }
            
            
            
            
            self.performSegue(withIdentifier: "editToHome", sender: self)
            fromList = false
            fromHome = false
            btnDelete.isEnabled = true
            
        }
    }
    @IBAction func btnCancel(_ sender: UIButton) {
      fromList = false
        fromHome = false
        btnDelete.isEnabled = true
        self.performSegue(withIdentifier: "editToHome", sender: self)
        
    }
   
    @IBAction func btnDelete(_ sender: UIButton) {
        let sresto = Table("restaurant").filter(Expression<Int>("restaurantId") == restos[passedValue].restaurantId)
        do {
            try self.database.run(sresto.delete())
            print("resto deleted")
        } catch {
            print(error)
        }
        fromList = false
        fromHome = false
        self.performSegue(withIdentifier: "editToHome", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desti = segue.destination as? RestaurantsDetailsViewController{
           desti.passedValue = passedValue
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
