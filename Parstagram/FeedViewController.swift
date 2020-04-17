//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Kedar Abhyankar on 4/16/20.
//  Copyright © 2020 Kedar Abhyankar. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var posts =  [PFObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = main.instantiateViewController(withIdentifier: "LoginViewController")
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = loginVC
        print("logged out!")
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Posts")
        query.includeKeys(["author","comments", "comments.author"])
        query.limit = 20
        
        query.findObjectsInBackground{ (posts, error) in
            if posts != nil {
                print("success in polling ")
                self.posts = posts!
                self.tableView.reloadData()
            } else {
                print("error in polling")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let post = posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        return comments.count + 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject] ?? [])
        
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell")
             as! PostTableViewCell
            
            let post = posts[indexPath.row]
            let user = post["author"] as! PFUser
            cell.userNameLabel.text = user.username
            cell.captionLabel.text = (post["caption"] as! String)
            
            let imageFile = post["image"] as! PFFileObject
            
            let url = URL(string: imageFile.url!)!
            cell.photoView.af.setImage(withURL: url)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell")
             as! CommentTableViewCell
            let comment = comments[indexPath.row - 1]
            cell.commentData.text = comment["text"] as? String
            let user = comment["author"] as! PFUser
            cell.commentUsername.text = user.username
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let comment = PFObject(className: "comments")
        comment["text"] = "This is a random comment!"
        comment["post"] = post
        comment["author"] = PFUser.current()
        post.add(comment, forKey: "comments")
        post.saveInBackground{
            (success, error) in
            if success {
                print("Comment added successfully")
            } else {
                print("Error posting comment")
            }
        }
        tableView.reloadData()
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
