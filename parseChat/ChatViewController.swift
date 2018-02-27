//
//  ChatViewController.swift
//  parseChat
//
//  Created by Jiayi Wang on 2/22/18.
//  Copyright © 2018 Jiayi Wang. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var chatMessageField: UITextField!
    
    
    var chatMessages: [PFObject]? = []
    @IBAction func Message(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }

    @objc func onTimer() {
        // Add code to be run periodically
        let query = PFQuery(className: "Message")
        query.includeKey("user")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                self.chatMessages = posts
                self.tableView.reloadData()
            } else {
                print("Problem refreshing message: \(error!.localizedDescription)")
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let chatMessage = chatMessages {
            return chatMessage.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let messages = chatMessages?[indexPath.row]
       
        if let msgString = messages?["text"] as? String {
            cell.message.text = msgString
        }
        
        if let user = messages?["user"] as? PFUser {
            print("The user is: \(user)")
            cell.username.text = user.username
        } else {
            // No user found, set default username
            cell.username.text = "🤖"
        }
        
        cell.message.text = chatMessageField.text
        return cell
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
        // Auto size row height based on cell autolayout constraints
        tableView.rowHeight = UITableViewAutomaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        tableView.estimatedRowHeight = 50
        // Do any additional setup after loading the view.
         Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)
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
