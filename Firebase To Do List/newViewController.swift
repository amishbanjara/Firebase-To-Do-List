//
//  newViewController.swift
//  Firebase To Do List
//
//  Created by IMCS2 on 8/1/19.
//  Copyright © 2019 patelashish797. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
//var listArray = [String] ()
class newViewController: UIViewController {
var ref: DatabaseReference!
    @IBOutlet weak var myTextField: UITextField!
    @IBAction func submitButtonTapped(_ sender: Any) {
       
        ref = Database.database().reference().child("Student")
        ref.childByAutoId().child("name").setValue(myTextField.text)
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
