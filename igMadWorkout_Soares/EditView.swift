// ============================
import UIKit
import Foundation
// ============================
//classe pour la view EditView
class EditView: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    // ============================
    @IBOutlet weak var theTableView: UITableView!
    @IBOutlet weak var addExerciseField: UITextField!
    var exerciseAccount: UserDefaults = UserDefaults.standard
    var exerciseAccountability: [String : Int]!
    // ============================
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.exerciseAccountability = self.exerciseAccount.value(forKey: "exercises") as! [String : Int]
        self.addExerciseField.delegate = self;
    }
    // ============================
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    // ============================
    //bouton pour ajouter un exercice
    @IBAction func addExerciseButton(_ sender: UIButton)
    {
        if self.addExerciseField.text != ""
        {
            self.exerciseAccountability[self.addExerciseField.text!] = 0
            self.exerciseAccount.setValue(self.exerciseAccountability, forKey: "exercises")
            self.addExerciseField.text = ""
            self.theTableView.reloadData()
            self.mAlterts("Exercise Added!")
        }
    }
    //fonction pour le mise à jour de la tableView
    // ============================
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        self.theTableView.backgroundColor = UIColor.clear
        return self.exerciseAccountability.count
    }
    //-------------
    //fonction pour le ramplissage de la tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let intIndex = indexPath.row
        let index = self.exerciseAccountability.index(self.exerciseAccountability.startIndex, offsetBy: intIndex)
        
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"cell")
        cell.textLabel!.font = UIFont(name: "Caviar Dreams", size: 18.0)
        cell.textLabel!.text = self.exerciseAccountability.keys[index]
        tableView.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    //-------------
    //fonction pour le style de la tableView
    func tableView(_ tableView: UITableView, commitforRowAtEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            let intIndex = indexPath.row
            let index = self.exerciseAccountability.index(self.exerciseAccountability.startIndex, offsetBy: intIndex)
            self.exerciseAccountability[self.exerciseAccountability.keys[index]] = nil
            self.exerciseAccount.setValue(self.exerciseAccountability, forKey: "exercises")
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    //-------------
    //fonction pour le textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    //-------------
    //fonction pour les alertes de la page
    func mAlterts(_ theMessage: String)
    {
        let alertController = UIAlertController(title: "Message...", message:
            theMessage, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    //-------------
  
}
// ============================
