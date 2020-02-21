//
//  EditNoteViewController.swift
//  PrimeraApp
//
//  Created by s209e011 on 20/02/20.
//  Copyright © 2020 udem. All rights reserved.
//

import UIKit

class EditNoteViewController: UIViewController {
    
    var note: String?

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = note
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelEdition(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
