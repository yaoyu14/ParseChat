//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Yao Yu on 3/13/20.
//  Copyright © 2020 Yao Yu. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var messages: [PFObject]?
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
        chatTableView.separatorStyle = .none
        // Auto size row height based on cell autolayout constraints
        chatTableView.rowHeight = UITableView.automaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        chatTableView.estimatedRowHeight = 50
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = messageTextField.text ?? ""
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground { (success, error) in
           if success {
              print("The message was saved!")
            self.messageTextField.text = nil
           } else if let error = error {
              print("Problem saving message: \(error.localizedDescription)")
           }
        }
    }
    
    @objc func onTimer() {
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        query.limit = 20
        query.includeKey("user")
              // fetch data asynchronously
              query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) -> Void in

                  if let error = error {
                      // Log details of the failure
                      print(error.localizedDescription)
                  } else {
                    self.messages = []
                    if let objects = objects {
                        self.messages = objects
                    }

                    self.chatTableView.reloadData()
                }
              }
                
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        
        if let messages = self.messages {
            let message = messages[indexPath.row]
            print(message)
            cell.messageListLabel.text = message["text"] as? String
            if let user = message["user"] as? PFUser {
               // User found! update username label with username
               cell.userLabel.text = user.username
            } else {
               // No user found, set default username
               cell.userLabel.text = "🤖"
            }
        }
        

        
        return cell
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
