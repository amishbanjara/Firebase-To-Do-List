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
    var keyArray:[String] = []
    var gotItems = [String] ( )
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gotItems.count   }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell", for: indexPath)
        //print(gotItems)
        cell.textLabel?.text = gotItems[indexPath.row]
        return cell
    }
    //For Deleting cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            getAllKeys()
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when, execute: {
                self.ref?.child("Student").child(self.keyArray[indexPath.row]).removeValue()
                self.gotItems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                self.keyArray = []
            })
        }
    }
    override func  tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func getAllKeys(){
        ref?.child("Student").observeSingleEvent(of: .value, with: {(DataSnapshot) in
            for child in DataSnapshot.children{
                let snap = child as! DataSnapshot
                let key = snap.key
                print(key)
                self.keyArray.append(key)
            }
        })
    }
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromFirebase()
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    func fetchDataFromFirebase(){
        ref = Database.database().reference().child("Student")
        //ref.child("Name")
        ref.observe(.value) {(snapshot: DataSnapshot) in
            for nameValue in snapshot.children{
                let snapshotContent = nameValue as? DataSnapshot
                let namedata = snapshotContent?.value as? NSDictionary
                self.gotItems.append(namedata?["name"] as! String)
                //  print(self.gotItems)
            }
            self.tableView.reloadData()
        }
    }
    
}

