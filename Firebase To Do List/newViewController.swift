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
class newViewController: UIViewController {
var ref: DatabaseReference!
    @IBOutlet weak var myTextField: UITextField!
    @IBAction func submitButtonTapped(_ sender: Any) {
        ref = Database.database().reference().child("Student")
        ref.childByAutoId().child("name").setValue(myTextField.text)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
