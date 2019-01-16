import UIKit
import SQLite


class RestaurantsManager: NSObject {
    
    static let sharedManager = RestaurantsManager()
    
    var database: Connection!
    let restaurantTable = Table("Restaurant")
    
    private override init() {}
    
    func loadData() -> [Restaurant] {
        // Connection au table
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("letseat").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
        //recuperer les restau
        do {
            var restaurants: [Restaurant] = []
            let restaurant = try self.database.prepare(self.restaurantTable)
            for r in restaurant {
                let newRestaurant = Restaurant()
                newRestaurant.restaurantId = r[Expression<Int>("restaurantId")]
                newRestaurant.restaurantName = r[Expression<String>("restaurantName")]
                newRestaurant.restaurantImage = r[Expression<String>("restaurantImage")]
                newRestaurant.restaurantSpecialty = r[Expression<String>("restaurantSpecialty")]
               
                restaurants.append(newRestaurant)
            }
            return restaurants
        } catch {
            print(error)
            return [Restaurant]()
        }
    }
       
    private func constructRestaurantsFromArray(array: NSArray) -> [Restaurant] {
        var resultItems = [Restaurant]()
        
        for object in array {
            let obj = object as! NSDictionary
            let restaurantId = obj["restaurantId"] as! Int
            let restaurantName = obj["restaurantName"] as! String
            let restaurantImage = obj["restaurantImage"] as! String
            let restaurantSpecialty = obj["restaurantSpecialty"] as! String
            
            
            let loadedRestaurant = Restaurant(restaurantId: restaurantId, restaurantName: restaurantName, restaurantImage: restaurantImage, restaurantSpecialty: restaurantSpecialty)
            resultItems.append(loadedRestaurant)
        }
        return resultItems
    }
}
