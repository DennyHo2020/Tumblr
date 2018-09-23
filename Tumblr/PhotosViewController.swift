//
//  PhotosViewController.swift
//  Tumblr
//
//  Created by Denny Ho on 9/12/18.
//  Copyright © 2018 Denny Ho. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        photoTableView.dataSource = self
        photoTableView.rowHeight = 250
        retrieveTumblrAPIData()
    }
    var posts: [[String: Any]] = []
    @IBOutlet weak var photoTableView: UITableView!
    
    func retrieveTumblrAPIData() {
        // Network request snippet
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                let alertView = UIAlertView(title: "Networking Error", message: "The internet connection appears to be offline", delegate: self as? UIAlertViewDelegate, cancelButtonTitle: "OK")
                alertView.show()
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(dataDictionary)
                // Get the dictionary from the response key
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                // Store the returned array of dictionaries in our posts property
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                self.photoTableView.reloadData()

            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // How many cells should I return?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    // What should be in my cells?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        // Configure YourCustomCell using the outlets that you've defined.
        let post = posts[indexPath.row]
        if let photos = post["photos"] as? [[String: Any]] {
        
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let imageURL = URL(string: urlString)
             cell.PostImage.af_setImage(withURL: imageURL!)
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var photoViewController = segue.destination as! PhotoDetailsViewController
        let cell = sender as! UITableViewCell
        let indexPath = photoTableView.indexPath(for: cell)!
        let post = posts[indexPath.row]
        if let photos = post["photos"] as? [[String: Any]] {
            
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let imageURL = URL(string: urlString)
            photoViewController.imageURL = imageURL
        }
        

    }
    
}
