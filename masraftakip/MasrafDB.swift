//
//  MasrafDB.swift
//  masraftakip
//
//  Created by mustafa bayer on 9/21/16.
//  Copyright © 2016 mustafa bayer. All rights reserved.
//

import UIKit

let sharedInstance = MasrafDB()

class MasrafDB: NSObject {
    
    var database: FMDatabase? = nil
    
    class func getInstance() -> MasrafDB {
        
        if (sharedInstance.database == nil) {
            sharedInstance.database = FMDatabase(path: Utilities.getPath("masraf.sqlite"))
        }
        return sharedInstance
    }
    
    func deleteMasraf(masraf: HareketData) {
        
        sharedInstance.database!.open()
        
        do {
            try sharedInstance.database!.executeUpdate("delete from hareket where hareketid = ?", withArgumentsInArray: [masraf.hareketid])
        }
        catch let error as NSError {
            
            print("failed: \(error.localizedDescription)")
            
            let alertView = UIAlertView(title: "Alert", message: "\(error)", delegate: nil, cancelButtonTitle: "Ok", otherButtonTitles: "No")
            
            // Configure Alert View
            alertView.tag = 1
            
            // Show Alert View
            alertView.show()
        }
    }
    
    func saveMasraf(masraf: HareketData) {
        
        sharedInstance.database!.open()
        
        do {
        try sharedInstance.database!.executeUpdate("insert into hareket (hareketkod, tutar, gc, tarih, hesapkod, aciklama) values (?,?,?,?,?,?)", withArgumentsInArray: [masraf.hareketkod, masraf.tutar, masraf.gc, masraf.tarih, masraf.hesapkod, masraf.aciklama])
        }
        catch let error as NSError {
            
            print("failed: \(error.localizedDescription)")
            
            let alertView = UIAlertView(title: "Alert", message: "\(error)", delegate: nil, cancelButtonTitle: "Ok", otherButtonTitles: "No")
            
            // Configure Alert View
            alertView.tag = 1
            
            // Show Alert View
            alertView.show()
        }
    }
    
    func getMasraflar(str:String) -> [HareketData] {
        sharedInstance.database!.open()
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM hareket WHERE hareketkod LIKE '%\(str)' OR aciklama LIKE '%\(str)'", withArgumentsInArray:nil)
        
        var arrDataMasraf = [HareketData]()
        
        if (resultSet != nil) {
            while resultSet.next() {
                
                let hareketInfo: HareketData = HareketData()
                hareketInfo.hareketid = Int(resultSet.intForColumn("hareketid"))
                hareketInfo.hareketkod = resultSet.stringForColumn("hareketkod")
                hareketInfo.tutar = resultSet.doubleForColumn("tutar")
                hareketInfo.gc = Int(resultSet.intForColumn("gc"))
                hareketInfo.tarih = resultSet.stringForColumn("tarih")
                hareketInfo.hesapkod = resultSet.stringForColumn("hesapkod")
                hareketInfo.aciklama = resultSet.stringForColumn("aciklama")
                arrDataMasraf.append(hareketInfo)
            
            }
            
        }
        sharedInstance.database!.close()
        return arrDataMasraf
    }
    
    func getOdemeTurleri() -> NSMutableArray {
        sharedInstance.database!.open()
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM odemetur ", withArgumentsInArray:nil)
        let arrDataOdeme: NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                
                let odemeInfo: OdemeTurData = OdemeTurData()
                odemeInfo.kod = resultSet.stringForColumn("kod")
                odemeInfo.aciklama = resultSet.stringForColumn("aciklama")
                arrDataOdeme.addObject(odemeInfo)
                
            }
            
        }
        sharedInstance.database!.close()
        return arrDataOdeme
        
    }
    
    func getMasrafTurleri() -> NSMutableArray {
        sharedInstance.database!.open()
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM masraftur ", withArgumentsInArray:nil)
        let arrDataMasraf: NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                
                let masrafInfo: MasrafTurData = MasrafTurData()
                masrafInfo.kod = resultSet.stringForColumn("kod")
                masrafInfo.aciklama = resultSet.stringForColumn("aciklama")
                arrDataMasraf.addObject(masrafInfo)
                
            }
            
        }
        sharedInstance.database!.close()
        return arrDataMasraf
        
    }
    
    func getHesapTurleri() -> NSMutableArray {
        sharedInstance.database!.open()
        
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM hesaptur ", withArgumentsInArray:nil)
        let arrDataHesap: NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                
                let hesapInfo: HesapTurData = HesapTurData()
                hesapInfo.kod = resultSet.stringForColumn("kod")
                hesapInfo.aciklama = resultSet.stringForColumn("aciklama")
                arrDataHesap.addObject(hesapInfo)
                
            }
            
        }
        sharedInstance.database!.close()
        return arrDataHesap
    }
    
    func saveTurData(data: DataObje, tableName: String) {
        
        sharedInstance.database!.open()
        
        do {
            try sharedInstance.database!.executeUpdate("insert into \(tableName) (kod, aciklama) values (?,?)", withArgumentsInArray: [data.kod, data.aciklama])
        }
        catch let error as NSError {
            
            print("failed: \(error.localizedDescription)")
            
            let alertView = UIAlertView(title: "Alert", message: "\(error)", delegate: nil, cancelButtonTitle: "Ok", otherButtonTitles: "No")
            
            // Configure Alert View
            alertView.tag = 1
            
            // Show Alert View
            alertView.show()
        }
    }

}
