//
//  Utilities.swift
//  masraftakip
//
//  Created by mustafa bayer on 9/21/16.
//  Copyright © 2016 mustafa bayer. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    
    class func getPath(fileName: String) -> String {
    
        let documentUrl = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileUrl = documentUrl.URLByAppendingPathComponent(fileName)
        
        return fileUrl.path!
    }
    
    class func copyFile(fileName: NSString) {
        
        let dbPath: String = getPath(fileName as String)
        
        let fileManager = NSFileManager.defaultManager()
        
        if !fileManager.fileExistsAtPath(dbPath) {
            
            let documentsURL = NSBundle.mainBundle().resourceURL
            
            let fromPath = documentsURL!.URLByAppendingPathComponent(fileName as String)
            
            var error : NSError?
            do {
                try fileManager.copyItemAtPath(fromPath.path!, toPath: dbPath)
            }
            catch let error1 as NSError {
                error = error1
            }
            let alert: UIAlertView = UIAlertView()
            if(error != nil) {
                alert.title = "Dosya kopyalanırken hata!"
                alert.message = error?.localizedDescription
            }
            else {
                alert.title = "Dosya kopyalandı."
                alert.title = dbPath
            }
            alert.delegate = nil
            alert.addButtonWithTitle("Ok")
            alert.show()
        
        }
    
    
    }

}
