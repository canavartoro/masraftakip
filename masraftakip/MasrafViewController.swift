//
//  MasrafViewController.swift
//  masraftakip
//
//  Created by mustafa bayer on 9/21/16.
//  Copyright © 2016 mustafa bayer. All rights reserved.
//

import UIKit

class MasrafViewController: UIViewController {

    @IBOutlet weak var editMasrafTur: UITextField!
    
    @IBOutlet weak var editHesapTur: UITextField!
    
    @IBOutlet weak var editMasrafTutar: UITextField!
    
    @IBOutlet weak var editMasrafAciklama: UITextField!
    
    @IBOutlet weak var editMasrafTarih: UITextField!
    
    
    @IBOutlet weak var editMasrafSaat: UITextField!
    
    let pickerMasraf: TextFieldUtility = TextFieldUtility()
    let txtMasrafTutarUtil: TextFieldUtility = TextFieldUtility()
    let txtMasrafTarihUtil: TextFieldUtility = TextFieldUtility()
    let txtMasrafSaatUtil: TextFieldUtility = TextFieldUtility()
    let txtMasrafHesapTurUtil: TextFieldUtility = TextFieldUtility()
    let txtMasrafAciklamaUtil: TextFieldUtility = TextFieldUtility()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtMasrafHesapTurUtil.arrData = MasrafDB.getInstance().getHesapTurleri()
        txtMasrafHesapTurUtil.txtFirst = editHesapTur
        txtMasrafHesapTurUtil.txtLast = editMasrafAciklama
        txtMasrafHesapTurUtil.createPickerForTextField(self)
        
        pickerMasraf.arrData = MasrafDB.getInstance().getMasrafTurleri()
        pickerMasraf.txtFirst = editMasrafTur
        pickerMasraf.txtLast = editMasrafTutar
        pickerMasraf.createPickerForTextField(self)
        
        txtMasrafTutarUtil.txtFirst = editMasrafTutar
        txtMasrafTutarUtil.txtLast = editMasrafTarih
        txtMasrafTutarUtil.txtListenReturnKeyForNumber()
        
        txtMasrafTarihUtil.txtFirst = editMasrafTarih
        txtMasrafTarihUtil.txtLast = editMasrafSaat
        txtMasrafTarihUtil.createPickerDate(self, forDate: true)
        
        txtMasrafSaatUtil.txtFirst = editMasrafSaat
        txtMasrafSaatUtil.txtLast = editHesapTur
        txtMasrafSaatUtil.createPickerDate(self, forDate: false)
        
        txtMasrafAciklamaUtil.txtFirst = editMasrafAciklama
        txtMasrafAciklamaUtil.txtListenReturnKey()
        
        /*let array: NSMutableArray = MasrafDB.getInstance().getOdemeTurleri()
        print(array.count)*/
        
    }
    
    /*override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.toolbarHidden = false
        self.tabBarController?.tabBar.hidden = true
    }*/
    
    @IBAction func masrafTur_click(sender: AnyObject) {
        
        let alertUtil: AlertUtil = AlertUtil()
        let alertView: UIAlertController = alertUtil.createAlert("Yeni Masraf Türü", strMessage: "Masraf Türü Girin", strHint: "Masraf türü")
        alertView.addAction(UIAlertAction(title: "Done", style: .Default, handler:{ (UIAlertAction) in
            print("Item : \(alertUtil.tField.text)")
            
            let data: HesapTurData = HesapTurData()
            data.kod = (alertUtil.tField.text?.uppercaseString)!
            data.aciklama = "\((alertUtil.tField.text?.uppercaseString)!) MASRAF"
            MasrafDB.getInstance().saveTurData(data, tableName: "masraftur")
            
        }))
        self.presentViewController(alertView, animated: true, completion: {})
        
    }
    
    @IBAction func hesapTur_click(sender: AnyObject) {
        
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func saveonclick(sender: AnyObject) {
        
        if (editMasrafTutar.text!.isEmpty) {
            showAlert("Masraf tutarı boş!")
            return
        }
        
        if (editMasrafTarih.text!.isEmpty) {
            showAlert("Masraf tarihi boş!")
            return
        }
        
        if (editMasrafTur.text!.isEmpty) {
            showAlert("Masraf türü boş!")
            return
        }
        
        if (editHesapTur.text!.isEmpty) {
            showAlert("Hesap türü boş!")
            return
        }
        
        let masraf = HareketData()
        
        masraf.hareketkod = editMasrafTur.text!
        masraf.aciklama = editMasrafAciklama.text!
        masraf.gc = -1
        masraf.tutar = Double(editMasrafTutar.text!)!
        masraf.hesapkod = editHesapTur.text!
        masraf.tarih = editMasrafTarih.text!
        MasrafDB.getInstance().saveMasraf(masraf)
        
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    func showAlert(str: String) {
        
        let alert = UIAlertController(title: "Dikkat", message: str, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
}
