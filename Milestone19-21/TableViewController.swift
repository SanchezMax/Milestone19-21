//
//  TableViewController.swift
//  Milestone19-21
//
//  Created by Максим Зыкин on 16.11.2023.
//

import UIKit

class TableViewController: UITableViewController {
    var notes: [Note] {
        get {
            let defaults = UserDefaults.standard
            
            if let savedData = defaults.object(forKey: "notes") as? Data {
                let jsonDecoder = JSONDecoder()
                
                do {
                    return try jsonDecoder.decode([Note].self, from: savedData)
                } catch {
                    print("Failed to load notes.")
                }
            }
            
            return []
        }
        set {
            let jsonEncoder = JSONEncoder()
            do {
                let dataToSave = try jsonEncoder.encode(newValue)
                let defaults = UserDefaults.standard
                defaults.setValue(dataToSave, forKey: "notes")
            } catch {
                print("Failed to save notes.")
            }
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let add = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addNewNote))
        toolbarItems = [spacer, add]
        navigationController?.isToolbarHidden = false
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
    
    @objc func addNewNote() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NoteDetail") as? NoteViewController {
            vc.title = "New note"
            vc.saveCompletion = saveNote
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func saveNote(_ title: String, _ note: String, _ index: Int?) {
        if let index {
            notes[index] = Note(title: title, note: note)
        } else {
            notes.append(Note(title: title, note: note))
        }
    }
    
    func deleteNote(_ index: Int) {
        notes.remove(at: index)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].title
        cell.detailTextLabel?.text = notes[indexPath.row].note
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NoteDetail") as? NoteViewController {
            vc.title = notes[indexPath.row].title
            vc.text = notes[indexPath.row].note
            vc.index = indexPath.row
            vc.saveCompletion = saveNote
            vc.deleteCompletion = deleteNote
            navigationController?.pushViewController(vc, animated: true)
        }
    }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            notes.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */


    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
