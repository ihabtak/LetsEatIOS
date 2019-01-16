//
//  RestaurantsDetailsViewController.swift
//  Letseat
//
//  Created by MAC on 26/12/2018.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
class DishTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dishImagen: UIImageView!
    @IBOutlet weak var dishName: UILabel!
    @IBOutlet weak var dishPrice: UILabel!
    @IBOutlet weak var dishTypeName: UILabel!
    @IBOutlet weak var DishTypeImage: UIImageView!
    
    
    
    
}
class RestaurantsDetailsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var restaurantNameText: UILabel!
    @IBOutlet weak var restaurantSpecialityText: UILabel!
    @IBOutlet weak var restaurantQualityImageD: UIImageView!
    @IBOutlet weak var restaurantImageText: UIImageView!
    
    @IBOutlet weak var restaurantTimeImageD: UIImageView!
    
    @IBOutlet weak var restaurantMoneyImageD: UIImageView!
    
   
    
    var restos: [Restaurant] = []
    var passedValue: Int = 0
    var dishes = [Dish(dishId:1,dishName:"dish1",dishImage:UIImage(named:"imagedish")!,dishPrice:12.00,dishType:"Type1"),Dish(dishId:2,dishName:"dish2",dishImage:UIImage(named:"imagedish")!,dishPrice:12.00,dishType:"Type2"),Dish(dishId:3,dishName:"dish3",dishImage:UIImage(named:"imagedish")!,dishPrice:12.00,dishType:"Type3")]
    /*var restos = [Restaurant(restaurantId:1,restaurantName:"Res1",restaurantImage:"shop",restaurantSpecialty:"Spec1"),Restaurant(restaurantId:2,restaurantName:"Rest2",restaurantImage:"shop",restaurantSpecialty:"Spec2"),Restaurant(restaurantId:3,restaurantName:"Res3",restaurantImage:"shop",restaurantSpecialty:"Spec3")]*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restos = RestaurantsManager.sharedManager.loadData()
        tableView.dataSource = self
        self.title="Restaurant Details"       
      
            }
    override func viewWillAppear(_ animated: Bool) {
        restaurantNameText.text = restos[passedValue].restaurantName
        restaurantSpecialityText.text = restos[passedValue].restaurantSpecialty
        restaurantQualityImageD.image = UIImage(named: "dish")
        restaurantImageText.image = UIImage(named: restos[passedValue].restaurantImage)
        
        restaurantTimeImageD.image = UIImage(named: "waiter")
        
        restaurantMoneyImageD.image = UIImage(named: "money")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dishCell", for: indexPath) as! DishTableViewCell
        let dish = dishes[indexPath.row]
        cell.dishImagen?.image = dish.dishImage
        cell.dishName?.text = dish.dishName
        cell.dishPrice?.text = String(dish.dishPrice)+"$"
        cell.dishTypeName?.text = dish.dishType
        cell.DishTypeImage?.image = UIImage(named: dish.dishType)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    @IBAction func btn_Edit(_ sender: UIButton) {
        performSegue(withIdentifier: "detailToEdit", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desti = segue.destination as? RestaurantsEditViewController{
            desti.passedValue = passedValue
            desti.fromList = true
        }
        if let desti = segue.destination as? RestaurantsReviewsViewController{
            desti.passedValue = passedValue
        }
        
    }
    @IBAction func btnRev(_ sender: UIButton) {
        performSegue(withIdentifier: "detailToReviews", sender: self)
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
