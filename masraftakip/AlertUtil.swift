//
//  AlertUtil.swift
//  masraftakip
//
//  Created by mustafa bayer on 11/23/16.
//  Copyright © 2016 mustafa bayer. All rights reserved.
//

import UIKit

class AlertUtil: NSObject {
    
    func createAlert(strTitle:String, strMessage:String, strHint:String) -> UIAlertController {
        
        self.hint = strHint
        
        let alert = UIAlertController(title: strTitle, message: strMessage, preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addAction(UIAlertAction(title: "İptal", style: .Cancel, handler:handleCancel))
        if ( action != nil ) {
            alert.addAction(action)
        }
        return alert
    }
    
    var tField: UITextField!
    var action:UIAlertAction!
    private var hint: String!
    
    func configurationTextField(textField: UITextField!)
    {
        print("generating the TextField")
        textField.placeholder = self.hint
        tField = textField
    }
    
    func handleCancel(alertView: UIAlertAction!)
    {
        print("User click Cancel button")
        
    }
    
    class func showAlert(str: String, strTitle:String, view:UIViewController) {
        
        let alert = UIAlertController(title: "Dikkat", message: str, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.Default, handler: nil))
        view.presentViewController(alert, animated: true, completion: nil)
    }

}
