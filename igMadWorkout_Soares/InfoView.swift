// ============================
import UIKit
// ============================
//classe pour la view InfoView
class InfoView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // ============================
    @IBOutlet weak var infoDateLabel: UILabel!
    @IBOutlet weak var theTableView: UITableView!
    @IBOutlet weak var reorderButton: UIButton!
    // ============================
    var theDatabase: [String : [[String : String]]]!
    var theWorkout: [String]!
    // ============================
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.theDatabase = Shared.sharedInstance.getDatabase("db")
        self.infoDateLabel.text = self.getDates()[Shared.sharedInstance.theRow]
        self.theWorkout = self.fillUpWorkoutArray(self.infoDateLabel.text!)
    }
    // ============================
    //bouton pour changer d'ordre les valeurs de la table
    @IBAction func reorder(_ sender: UIButton) {
        if !self.theTableView.isEditing
        {
            self.theTableView.isEditing = true
            self.reorderButton.setTitle("DONE", for: UIControlState())
        }
        else
        {
            self.theTableView.isEditing = false
            self.reorderButton.setTitle("EDIT", for: UIControlState())
        }
    }
    //fonction que faire le ramplissage d'un array d'exercices
    // ============================
    func fillUpWorkoutArray(_ theDate: String) -> [String]
    {
        var arrToReturn: [String] = []
        
        for (a, b) in self.theDatabase
        {
            if a == theDate
            {
                for c in b
                {
                    for (d, e) in c
                    {
                        arrToReturn.append("[\(e)] : \(d)")
                    }
                }
            }
        }
        
        return arrToReturn
    }
    //fonction pour prendre les dates
    // ============================
    func getDates() -> [String]
    {
        var tempArray = [""]
        
        for (a, _) in  self.theDatabase
        {
            tempArray.append(a)
        }
        
        tempArray.remove(at: 0)
        
        return tempArray
    }
    //fonction constructeur de didReceiveMemoryWarning()
    // ============================
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    //fonction pour l'initialisation de la tableView
    // ============================
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.theTableView.backgroundColor = UIColor.clear
        return self.theWorkout.count
    }
    // ============================
    //fonction pour ajouter le style de la tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"cell")
        cell.textLabel!.font = UIFont(name: "Caviar Dreams", size: 14.0)
        cell.textLabel!.text = self.theWorkout[indexPath.row]
        tableView.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    // ============================
    //fonction pour metre les données dans la tableView
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            self.theWorkout.remove(at: indexPath.row)
            self.deleteFromDatabase(self.infoDateLabel.text!, indexToDelete: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    // ============================
    //fonction pour effacer une exercice dans la base des données
    func deleteFromDatabase(_ theDate: String, indexToDelete: Int)
    {
        for (a, b) in self.theDatabase
        {
            if a == theDate
            {
                for _ in b
                {
                    self.theDatabase[theDate]?.remove(at: indexToDelete)
                    Shared.sharedInstance.saveDatabase(self.theDatabase)
                    return
                }
            }
        }
    }
    // ============================
    //fontion pour changer les rangées de la tableView
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    // ============================
    //fontion pour changer les rangées de la tableView
    @objc(tableView:moveRowAtIndexPath:toIndexPath:) func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath)
    {
        let itemToMove = self.theDatabase[self.infoDateLabel.text!]?[fromIndexPath.row]
        self.theDatabase[self.infoDateLabel.text!]?.remove(at: fromIndexPath.row)
        self.theDatabase[self.infoDateLabel.text!]?.insert(itemToMove!, at: toIndexPath.row)
        Shared.sharedInstance.saveDatabase(self.theDatabase)
    }
    // ============================
}





















