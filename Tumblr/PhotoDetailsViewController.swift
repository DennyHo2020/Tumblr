//
//  PhotoDetailsViewController.swift
//  Tumblr
//
//  Created by Denny Ho on 9/19/18.
//  Copyright © 2018 Denny Ho. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    var imageURL:URL!
    
    @IBOutlet weak var detailsImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsImageView.af_setImage(withURL: imageURL)

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
