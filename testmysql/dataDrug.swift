//
//  dataDrug.swift
//  testmysql
//
//  Created by Jirawut on 5/15/2560 BE.
//  Copyright © 2560 karmolrut. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
class dataDrug: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var ref: FIRDatabaseReference!
    var imgDrug: String?
    var imgData: UIImage?
    var urlImage: String?
    
    @IBOutlet weak var nameDrug: UITextField!
    
    @IBOutlet weak var sumDrug: UITextField!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var detailDrug: UITextView!
    
    @IBAction func addPic(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePick = UIImagePickerController()
            imagePick.delegate = self
            imagePick.sourceType = UIImagePickerControllerSourceType.camera
            imagePick.allowsEditing = false
            self.present(imagePick, animated: true, completion: nil)
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as! UIImage! {
            imgView.image = image
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func uploadImgToStorage(){
//        Generate Unique Name
        let uuid = UUID().uuidString

        let storageRef = FIRStorage.storage().reference().child("imgDrug").child("\(uuid).jpg")
        
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"

        if let imageData = UIImageJPEGRepresentation(imgView.image!, 0.8)  {
            storageRef.put(imageData, metadata: metadata, completion: { (FIRStorageMetadata, error) in
                if error != nil {
                    print(error!)
                    return
                }
                else{
                    self.urlImage = FIRStorageMetadata!.downloadURL()!.absoluteString
                    self.uploadToDB()
                    debugPrint(self.urlImage!)
                }
            })
        }
    }
    
    func uploadToDB(){
    
        ref = FIRDatabase.database().reference().child("user")
        
        let key = ref.childByAutoId().key
        
        let artist = [
            "nameDrug": nameDrug.text! as String,
            "sumDrug": sumDrug.text! as String,
            "detailDrug": detailDrug.text! as String,
            "imgDrug": urlImage!
        ]
        
        ref.child(key).setValue(artist)
        
        let alertController = UIAlertController(title: "Complete", message: "Add Drug Complete", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func submit(_ sender: UIButton) {
      
        uploadImgToStorage()
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.nameDrug.delegate = self
        self.sumDrug.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
