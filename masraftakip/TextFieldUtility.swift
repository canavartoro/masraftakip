//
//  TextFieldUtility.swift
//  masraftakip
//
//  Created by mustafa bayer on 11/24/16.
//  Copyright © 2016 mustafa bayer. All rights reserved.
//

import UIKit

class TextFieldUtility: NSObject, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    var arrData: NSMutableArray!
    var index = 0
    var txtFirst: UITextField!
    var txtLast: UITextField!
    private var forDatePicker = 0
    
    private let pickerView:UIDatePicker = UIDatePicker()
    
    func createPickerDate(view: UIViewController, forDate: Bool) {
        
        if (forDate) {
            forDatePicker = 0
            pickerView.datePickerMode = UIDatePickerMode.Date
        }
        else {
            forDatePicker = 1
            pickerView.datePickerMode = UIDatePickerMode.Time
        }
        
        
        let toolBarTarih = UIToolbar()
        toolBarTarih.barStyle = .Default
        toolBarTarih.translucent = true
        toolBarTarih.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBarTarih.sizeToFit()
        
        // Adding Button ToolBar
        let doneTarihButton = UIBarButtonItem(title: "Tamam", style: .Plain, target: self, action: #selector(TextFieldUtility.doneDateClick))
        let cancelTarihButton = UIBarButtonItem(title: "İptal", style: .Plain, target: self, action: #selector(TextFieldUtility.cancelDateClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        toolBarTarih.setItems([cancelTarihButton, spaceButton, doneTarihButton], animated: false)
        toolBarTarih.userInteractionEnabled = true
        txtFirst.inputAccessoryView = toolBarTarih
        txtFirst.inputView = pickerView
        
        pickerView.addTarget(self, action: #selector(TextFieldUtility.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func createPickerForTextField(view: UIViewController) {
        
        let picker: UIPickerView
        picker = UIPickerView(frame: CGRectMake(0, 200, view.view.frame.width, 300))
        picker.backgroundColor = .whiteColor()
        
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        //toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Seç", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(TextFieldUtility.done))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "İptal", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(TextFieldUtility.close))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        txtFirst.inputView = picker
        txtFirst.inputAccessoryView = toolBar
        
    }
    
    func txtListenReturnKey() {
        txtFirst.returnKeyType = UIReturnKeyType.Done
        txtFirst.delegate = self
    }
    
    func txtListenReturnKeyForNumber() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.Default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Tamam", style: UIBarButtonItemStyle.Done, target: self, action: #selector(TextFieldUtility.doneButtonAction))
        
        doneToolbar.setItems([flexSpace, done], animated: false)
        doneToolbar.sizeToFit()
        
        txtFirst.inputAccessoryView = doneToolbar
    }
    
    func doneButtonAction() {
        txtFirst.resignFirstResponder()
        if (txtLast != nil) {
            txtLast.becomeFirstResponder()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField === txtFirst) {
            txtFirst.resignFirstResponder()
            if (txtLast != nil) {
                txtLast.becomeFirstResponder()
            }
        } else {
            // etc
        }
        
        return true
    }
    
    func doneDateClick() {
        let dateFormatter = NSDateFormatter()
        
        if (forDatePicker == 0) {
            dateFormatter.dateStyle = .ShortStyle
            dateFormatter.dateFormat = "DD/MM/YYYY"
            dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        }
        else {
            
            dateFormatter.dateFormat = "HH:mm:ss"
            dateFormatter.locale = NSLocale(localeIdentifier:"en_US")
        }
        
        txtFirst.text = dateFormatter.stringFromDate(pickerView.date)
        
        txtFirst.resignFirstResponder()
        if (txtLast != nil) {
            txtLast.becomeFirstResponder()
        }
    }
    
    func cancelDateClick() {
        txtFirst.resignFirstResponder()
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (arrData[row] as! DataObje).aciklama
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        index = row
    }
    
    func done() {
        txtFirst.text = (arrData[index] as! DataObje).kod
        txtFirst.resignFirstResponder()
        if (txtLast != nil) {
            txtLast.becomeFirstResponder()
        }
    }
    
    func close() {
        txtFirst.resignFirstResponder()
        
    }
    
}
