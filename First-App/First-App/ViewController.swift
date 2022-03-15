//
//  ViewController.swift
//  First-App
//
//  Created by Yevhenii Shypitsyn on 3/13/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK : - Initializations
    
    @IBOutlet weak var notesTableView: UITableView!
    var notesArray = [Note]()
    
    
    // MARK : - Segue Data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as!AddNoteViewController
        // passes the note and tells the view controller to update instead of add
        if segue.identifier == "updateNoteSegue" {
            vc.note = notesArray[notesTableView.indexPathForSelectedRow!.row]
            vc.update = true
        }
    }
    
    
    
    
    
    
    // MARK : - LifeCycle Hooks
    
    override func viewWillAppear(_ animated: Bool) {
        // update the notes array
        APIFunctions.functions.fetchNotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //update the notes array
        APIFunctions.functions.fetchNotes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchNotes()
        
        notesTableView.delegate = self
        notesTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    // MARK: - TableView Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! NotePrototypeCell
        
        //customizes cell to set date, note and title
        cell.title.text = notesArray[indexPath.row].title
        cell.note.text = notesArray[indexPath.row].note
        cell.date.text = notesArray[indexPath.row].date
        
        //cell.textLabel?.text = notesArray[indexPath.row].title
        return cell
    }
    
    
}



// MARK: - Custom Delegates

protocol DataDelegate {
    func updateArray(newArray: String)
}

extension ViewController: DataDelegate {
    func updateArray(newArray: String) {
        
        do {
            notesArray = try JSONDecoder().decode([Note].self, from: newArray.data(using: .utf8)!)
            print(notesArray)
            
        } catch {
            print("Failed to decode JSON!")
            
        }
        self.notesTableView?.reloadData()
        
    }
}
