//
//  OdemeViewController.swift
//  masraftakip
//
//  Created by mustafa bayer on 9/21/16.
//  Copyright © 2016 mustafa bayer. All rights reserved.
//

import UIKit

class OdemeViewController: UIViewController {
    
    @IBOutlet weak var editHesapTur: UITextField!

    @IBOutlet weak var editOdemeTutar: UITextField!
    
    @IBOutlet weak var editOdemeTarih: UITextField!
    
    @IBOutlet weak var editOdemeSaat: UITextField!
    
    @IBOutlet weak var editOdemeAcikleme: UITextField!
    
    let pickerHesap: TextFieldUtility = TextFieldUtility()
    let txtOdemeUtil: TextFieldUtility = TextFieldUtility()
    let txtAciklamaUtil: TextFieldUtility = TextFieldUtility()
    let txtDateUtil: TextFieldUtility = TextFieldUtility()
    let txtTimeUtil: TextFieldUtility = TextFieldUtility()
    
    @IBAction func save_click(sender: AnyObject) {
        if (editOdemeTutar.text!.isEmpty) {
            AlertUtil.showAlert("Masraf tutarı boş!", strTitle: "Dikkat", view: self)
            return
        }
        
        if (editOdemeTarih.text!.isEmpty) {
            AlertUtil.showAlert("Masraf tarihi boş!", strTitle: "Dikkat", view: self)
            return
        }
        
        if (editHesapTur.text!.isEmpty) {
            AlertUtil.showAlert("Hesap türü boş!", strTitle: "Dikkat", view: self)
            return
        }
        
        let masraf = HareketData()
        
        masraf.hareketkod = "ODEME"
        masraf.aciklama = editOdemeAcikleme.text!
        masraf.gc = 1
        masraf.tutar = Double(editOdemeTutar.text!)!
        masraf.hesapkod = editHesapTur.text!
        masraf.tarih = editOdemeTarih.text!
        MasrafDB.getInstance().saveMasraf(masraf)
        
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    
    
    @IBAction func addhesap_click(sender: AnyObject) {
        
        let alertUtil: AlertUtil = AlertUtil()
        let alertView: UIAlertController = alertUtil.createAlert("Yeni Hesap Türü", strMessage: "Hesap Türü Girin", strHint: "Hesap türü")
        alertView.addAction(UIAlertAction(title: "Done", style: .Default, handler:{ (UIAlertAction) in
            print("Item : \(alertUtil.tField.text)")
            
            let data: HesapTurData = HesapTurData()
            data.kod = (alertUtil.tField.text?.uppercaseString)!
            data.aciklama = "\((alertUtil.tField.text?.uppercaseString)!) HESAP"
            MasrafDB.getInstance().saveTurData(data, tableName: "hesaptur")
            
        }))
        self.presentViewController(alertView, animated: true, completion: {})
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerHesap.arrData = MasrafDB.getInstance().getHesapTurleri()
        pickerHesap.txtFirst = editHesapTur
        pickerHesap.txtLast = editOdemeTutar
        pickerHesap.createPickerForTextField(self)
        
        txtOdemeUtil.txtFirst = editOdemeTutar
        txtOdemeUtil.txtLast = editOdemeTarih
        txtOdemeUtil.txtListenReturnKeyForNumber()
        
        txtAciklamaUtil.txtFirst = editOdemeAcikleme
        txtAciklamaUtil.txtListenReturnKey()
        
        txtDateUtil.txtFirst = editOdemeTarih
        txtDateUtil.txtLast = editOdemeSaat
        txtDateUtil.createPickerDate(self, forDate: true)
        
        txtTimeUtil.txtFirst = editOdemeSaat
        txtTimeUtil.txtLast = editOdemeAcikleme
        txtTimeUtil.createPickerDate(self, forDate: false)
       

    }
    
    
}
