//
//  ChatViewController.swift
//  Qhat
//
//  Created by Alisher Aidarkhan on 12/24/19.
//  Copyright © 2019 Alisher Aidarkhan. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    
    var messages:[Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self;
        tableView.register(UINib(nibName: K.Cell.nibName, bundle: nil), forCellReuseIdentifier: K.Cell.identifier)
        
        title = K.appName
        navigationItem.hidesBackButton = true
        
        self.getDataFromDB()
    }
    
    
    @IBAction func sendClicked(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            self.messageTextField.text = ""
            db.collection(K.FStore.collectionName)
                .addDocument(data: [
                    K.FStore.senderField: messageSender,
                    K.FStore.bodyField: messageBody,
                    K.FStore.dateField: Date().timeIntervalSince1970,
                ]) { (error) in
                    if let e = error {
                        print(e)
                    }
                    else {
                        print("Saved succesfully")
                    }
            }
        }
    }
    
    func getDataFromDB(){
        db
            .collection(K.FStore.collectionName).order(by: K.FStore.dateField)
            .addSnapshotListener() { (querySnapshot, err) in
            self.messages = []
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data();
                    if let sender = data[K.FStore.senderField] as? String, let message = data[K.FStore.bodyField] as? String {
                        self.messages.append(Message(sender: sender, body: message))
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                        }
                    }
                    else {
                        print("LOL")
                    }
                }
            }
        }
    }
    
    
    @IBAction func exitClicked(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
}

//MARK: - UITableViewDataSource extension

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Cell.identifier, for: indexPath) as! MessageCell
        
        if messages[indexPath.row].sender == Auth.auth().currentUser?.email {
            cell.label.text = messages[indexPath.row].body
            cell.leftAvatar.isHidden = true
            cell.rightAvatar.isHidden = false
            cell.bubble.backgroundColor = UIColor(named: K.BrandColors.redLight)
            cell.label.textColor = UIColor(named: K.BrandColors.redDark)
            
        }
        else {
            cell.label.text = messages[indexPath.row].body
            cell.rightAvatar.isHidden = true
            cell.leftAvatar.isHidden = false
            cell.bubble.backgroundColor = UIColor(named: K.BrandColors.blueLight)
            cell.label.textColor = UIColor(named: K.BrandColors.blueDark)
        }
        return cell
    }
    
    
}
