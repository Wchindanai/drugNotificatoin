//
//  seeDrug.swift
//  testmysql
//
//  Created by DE DPU on 5/17/2560 BE.
//  Copyright © 2560 karmolrut. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class seeDrug: UITableViewController {

    @IBOutlet var myTableViwe: UITableView!
    
    
    
    var ref: FIRDatabaseReference!
    
    var valueList = [[String:AnyObject]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        fetchFirebaseData()
      

    }
    
    func fetchFirebaseData() {
        ref?.child("user").observe(.childAdded, with:
            {(snapshot) in
                if let item = snapshot.value as? [String : AnyObject] {
                    print(item)
                    
                    
                    self.valueList.append(item)
                    print(self.valueList)
                    self.myTableViwe.reloadData()
                }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return valueList.count
      
    }
    
    
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let name = valueList[indexPath.row]["nameDrug"] as! String
        let detail = valueList[indexPath.row]["detailDrug"] as! String
        let sum = valueList[indexPath.row]["sumDrug"] as! String
        let cellText: String = ("Name: \(name) Detail: \(detail) Amount: \(sum)")
        cell.textLabel?.text = cellText
        return cell
    }
    
    

   
}
