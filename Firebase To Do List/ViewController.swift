//
//  ViewController.swift
//  Firebase To Do List
//
//  Created by IMCS2 on 7/31/19.
//  Copyright © 2019 patelashish797. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UITableViewController {
    var ref: DatabaseReference!
    var keyArray:[String] = []
    var gotItems = [String] ( )
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gotItems.count   }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell", for: indexPath)
        cell.textLabel?.text = gotItems[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let valueArray = keyArray[indexPath.row]
        if editingStyle == .delete {
            ref = Database.database().reference().child("Student").child(valueArray)
            ref.removeValue()
            tableView.reloadData()
            self.gotItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    override func  tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromFirebase()
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    func fetchDataFromFirebase(){
        ref = Database.database().reference().child("Student")
        ref.observe(.value) {(snapshot: DataSnapshot) in
            self.gotItems.removeAll()
            for nameValue in snapshot.children{
                let snapshotContent = nameValue as? DataSnapshot
                self.keyArray.append(snapshotContent!.key)
                let namedata = snapshotContent?.value as? NSDictionary
                self.gotItems.append(namedata?["name"] as! String)
                self.tableView.reloadData()
            }
            print(self.keyArray)
        }
    }
}

