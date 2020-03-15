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

    

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = messageTextField.text ?? ""
        chatMessage.saveInBackground { (success, error) in
           if success {
              print("The message was saved!")
            self.messageTextField.text = nil
           } else if let error = error {
              print("Problem saving message: \(error.localizedDescription)")
           }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        
        let query = PFQuery(className: "Message")
        query.whereKey("text")
        query.limit = 20

        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [Post]?, error: Error?) in
            if let posts = posts {
                // do something with the array of object returned by the call
            } else {
                print(error?.localizedDescription)
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
