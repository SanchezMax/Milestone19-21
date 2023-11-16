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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTextField.text = text
        // Do any additional setup after loading the view.
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
