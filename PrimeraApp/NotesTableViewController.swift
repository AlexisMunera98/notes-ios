//
//  NotesTableViewController.swift
//  PrimeraApp
//
//  Created by s209e011 on 20/02/20.
//  Copyright © 2020 udem. All rights reserved.
//

import UIKit
import CoreData

class NotesTableViewController: UITableViewController, NotesDelegate {
    
    
    func onNoteAdded(note: String) {
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context!)
        let newNote = NSManagedObject(entity: entity!, insertInto: context)
        if let noteEntity = newNote as? Note{
            noteEntity.title = note
        }
        
        commit()

        retreiveNotes()
        tableView.reloadData()
    }
    
    func commit(){
        do {
            try context!.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func onNoteUpdated(noteId: NSManagedObjectID, noteText: String) {
        do {
        if let noteToUpdate = try context?.existingObject(with: noteId) as? Note{
            noteToUpdate.setValue(noteText, forKey: "title")
            }
            commit()
        }catch{
            print("Error updating")
        }
        retreiveNotes()
        tableView.reloadData()
    }

    var context:NSManagedObjectContext?
    var notes = [Note]()
    
    override func viewDidLoad() {
        //retreiveNotes()
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        context = appDelegate.persistentContainer.viewContext
        
        // retreiveNotes()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.leftBarButtonItem = editButtonItem
        retreiveNotes()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "note_cell", for: indexPath)

        cell.textLabel?.text = notes[indexPath.row].title
        cell.tag = indexPath.row
        return cell
    }
    
    func retreiveNotes(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context!.fetch(request)
            notes.removeAll()
            for data in result as! [Note] {
                notes.append(data)
            }
        } catch {
            print("Failed")
        }
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            context?.delete(notes[indexPath.row])
            notes.remove(at: indexPath.row)
            commit()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let editNoteViewController = segue.destination as? EditNoteViewController{
            
            editNoteViewController.delegate = self
            
            if let selectedCell = sender as? UITableViewCell{
                editNoteViewController.note = notes[selectedCell.tag]
                //editNoteViewController.note = selectedCell.textLabel?.text
        
            }
            
        }
    }
    

}
