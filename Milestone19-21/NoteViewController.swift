//
//  NoteViewController.swift
//  Milestone19-21
//
//  Created by Максим Зыкин on 16.11.2023.
//

import UIKit

class NoteViewController: UIViewController {
    @IBOutlet var noteTextField: UITextView!
    var text: String?
    var index: Int?
    
    var saveCompletion: ((_ title: String, _ note: String, _ index: Int?) -> Void)?
    var deleteCompletion: ((_ index: Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveNote))
        navigationItem.rightBarButtonItems = [done, index != nil ? delete : spacer]
        noteTextField.text = text
        // Do any additional setup after loading the view.
    }
    
    @objc func deleteNote() {
        deleteCompletion?(index!)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveNote() {
        let ac = UIAlertController(title: "Save note", message: nil, preferredStyle: .alert)
        ac.addTextField()
        if title != "New note" {
            ac.textFields?.first?.text = title
        } else {
            ac.textFields?.first?.placeholder = "Name the note"
        }
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [self] _ in
            saveCompletion?(ac.textFields?.first?.text ?? "Undefined", noteTextField.text, index)
            navigationController?.popViewController(animated: true)
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
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
