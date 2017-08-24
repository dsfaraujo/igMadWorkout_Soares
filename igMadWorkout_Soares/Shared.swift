// ============================
import UIKit
// ============================
//classe pour sauvegarder dans la base de données les exercices dans l'application
class Shared: UIViewController
{
    // ============================
    var theDatabase: [String : [[String : String]]]!
    var savedUserDefault: UserDefaults = UserDefaults.standard
    static let sharedInstance = Shared()
    var theRow: Int!
    // ============================
    //fonction pour la verification de user defaults
    func checkForUserDefaultByName(_ theName: String, andUserDefaultObject: UserDefaults) -> Bool
    {
        let userDefaultObject = andUserDefaultObject.object(forKey: theName)
        
        if userDefaultObject == nil
        {
            return false
        }
        
        return true
    }
    //fonction pour sauvegarder ou loader le user defaults
    // ============================
    func  saveOrLoadUserDefaults(_ name: String)
    {
       //self.savedUserDefault.removeObjectForKey(name)
        
        if !self.checkForUserDefaultByName(name, andUserDefaultObject: self.savedUserDefault)
        {
            var tempArray = ["" : [["" : ""]]]
            tempArray[""] = nil
            
            self.saveUserDefaultByName(name, andUserDefaultObject: self.savedUserDefault, andSomeValue: tempArray)
        }
        else
        {
           self.theDatabase = self.savedUserDefault.value(forKey: name) as! [String : [[String : String]]]
        }
    }
    // ============================
    //fonction pour sauvegarder user defaults pour le nom de la clé
    func saveUserDefaultByName(_ theName: String, andUserDefaultObject: UserDefaults, andSomeValue: [String : [[String : String]]])
    {
        andUserDefaultObject.setValue(andSomeValue, forKey: theName)
    }
    // ============================
    //fonction pour prendre la base de données
    func getDatabase(_ name: String) -> [String : [[String : String]]]
    {
        return self.savedUserDefault.value(forKey: name) as! [String : [[String : String]]]
    }
    // ============================
    // focntion pour sauvegarder la base de données
    func saveDatabase(_ valueToSave: [String : [[String : String]]])
    {
        self.savedUserDefault.setValue(valueToSave, forKey: "db")
    }
    // ============================
}







