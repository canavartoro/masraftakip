//
//  DetayViewController.swift
//  masraftakip
//
//  Created by mustafa bayer on 11/28/16.
//  Copyright © 2016 mustafa bayer. All rights reserved.
//

import UIKit

class DetayViewController: UIViewController {

    var detayData: HareketData!
    
    @IBOutlet weak var lblTur: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (detayData != nil) {
            lblTur.text = detayData.aciklama
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
