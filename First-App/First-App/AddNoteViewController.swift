//
//  AddNoteViewController.swift
//  First-App
//
//  Created by Yevhenii Shypitsyn on 3/14/22.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    var note: Note?
    var update = false
    
    // MARK - UI Buttons
    @IBAction func deleteClick(_ sender: Any) {
        print("deleted")
        APIFunctions.functions.deleteNote(id: note!._id)
        //returns the screen back to the main screen
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveClick(_ sender: Any) {
        // creates a date string that we can pass in to the database
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =
            "yyyy-MM-dd"
        
        let date = dateFormatter.string(from: Date())
        
        //if the user is updating, update the note rather than saving
        if update == true {
            APIFunctions.functions.updateNote(date: date, title: TitleTextField.text!, note: bodyTextView.text, id: note!._id)
            self.navigationController?.popViewController(animated: true)
        } else if TitleTextField.text != "" && bodyTextView.text != "" {
            APIFunctions.functions.AddNote(date: date, title: TitleTextField.text!, note: bodyTextView.text)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - LifeCycle Hooks
    override func viewWillAppear(_ animated: Bool) {
        //disables the delete button if the user is adding a note (can't delete something that doesnt exist)
        if update == false {
            self.deleteButton.isEnabled = false
            self.deleteButton.title = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //prepopulates the text field if the user is updating a note
        if update == true{
            TitleTextField.text = note!.title
            bodyTextView.text = note!.note
        }
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
