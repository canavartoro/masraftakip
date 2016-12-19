//
//  RaporViewController.swift
//  masraftakip
//
//  Created by mustafa bayer on 11/24/16.
//  Copyright © 2016 mustafa bayer. All rights reserved.
//

import UIKit

class RaporViewController: UITableViewController {
    
    var detailViewController: DetayViewController? = nil
    
    var arrDataMasraf = [HareketData]()
    var filteredDataMasraf = [HareketData]()
    let searchController = UISearchController(searchResultsController: nil)
    
    func filterContentForSearchText(searchText: String, scope: String = "Tümü") {
        
        switch scope {
        case "Masraf":
            filteredDataMasraf = arrDataMasraf.filter{ data in
                return data.aciklama.lowercaseString.containsString(searchText.lowercaseString) && data.gc == -1
            }
        case "Ödeme":
            filteredDataMasraf = arrDataMasraf.filter{ data in
                return data.aciklama.lowercaseString.containsString(searchText.lowercaseString) && data.gc == 1
            }
        default:
            filteredDataMasraf = arrDataMasraf.filter{ data in
                return data.aciklama.lowercaseString.containsString(searchText.lowercaseString)
            }
        }
        
        
        tableView.reloadData()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrDataMasraf = MasrafDB.getInstance().getMasraflar("")
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = ["Masraf", "Ödeme", "Tümü"]
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        let rightButton = UIBarButtonItem(title: "Düzenle", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(RaporViewController.showEditing))
        self.navigationItem.rightBarButtonItem = rightButton
        
        //tableView.setEditing(true, animated: true)

    }
    
        
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.active && searchController.searchBar.text != "" {
            return filteredDataMasraf.count
        }
        
        return arrDataMasraf.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MasrafTableCellView
        
        let masraf : HareketData
        
        if searchController.active && searchController.searchBar.text != "" {
            masraf = filteredDataMasraf[indexPath.row]
        } else {
            masraf = arrDataMasraf[indexPath.row]
        }
        
        cell.lblMasraf.text = masraf.aciklama
        cell.lblMasraf.text = masraf.hesapkod
        cell.lblTarih.text = masraf.tarih
        
        if (masraf.gc == 1) {
            cell.lblTutar.textColor = UIColor.redColor()
        }
        else {
            cell.lblTutar.textColor = UIColor.greenColor()
        }
        
        cell.lblTutar.text = String(masraf.tutar)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var masraf : HareketData
        
        if searchController.active && searchController.searchBar.text != "" {
            masraf = filteredDataMasraf[indexPath.row]
        } else {
            masraf = arrDataMasraf[indexPath.row]
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController:DetayViewController = storyboard.instantiateViewControllerWithIdentifier("ConnectionCheckToMain") as! DetayViewController
        //viewController.passedValue = currentCell.textLabel.text
        
        //self.presentViewController(viewController, animated: true , completion: nil)
        
        viewController.detayData = masraf
        
        navigationController?.pushViewController(viewController, animated: true)
        
        //let vc : DetayViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ConnectionCheckToMain") as! DetayViewController;
        //self.presentViewController(vc, animated: true, completion: nil)
        

        //let appDetailController = DetayViewController()
        //navigationController?.pushViewController(appDetailController, animated: true)
        
        //self.navigationController?.popViewControllerAnimated(true)
        

        
        //performSegueWithIdentifier("unwintomenu", sender: self)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            var masraf : HareketData
            
            if searchController.active && searchController.searchBar.text != "" {
                masraf = filteredDataMasraf[indexPath.row]
            } else {
                masraf = arrDataMasraf[indexPath.row]
            }
            
            searchController.active = false
            
            MasrafDB.getInstance().deleteMasraf(masraf)
            arrDataMasraf = MasrafDB.getInstance().getMasraflar("")
            
            tableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "unwintomenu"{
            let DestViewController = segue.destinationViewController as! DetayViewController
            //let targetController = DestViewController.topViewController as! DetayViewController
            //targetController.data = "hello from ReceiveVC !"
        }}
    
    func editButtonPressed(){
        tableView.setEditing(!tableView.editing, animated: true)
        if tableView.editing == true{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Bitti", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(RaporViewController.editButtonPressed))
        }else{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Düzenle", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(RaporViewController.editButtonPressed))
        }
    }
    
    func showEditing(sender: UIBarButtonItem)
    {
        if(self.tableView.editing == true)
        {
            self.tableView.editing = false
            self.navigationItem.rightBarButtonItem?.title = "Düzenle"
        }
        else
        {
            self.tableView.editing = true
            self.navigationItem.rightBarButtonItem?.title = "Bitti"
        }
    }
    


}

extension RaporViewController : UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let scope = searchController.searchBar.selectedScopeButtonIndex
        var scopeName = ""
        if scope == 0 {
            scopeName = "Masraf"
        } else if scope == 1 {
            scopeName = "Ödeme"
        } else {
            scopeName = "Tümü"
        }
        
        filterContentForSearchText(searchController.searchBar.text!, scope: scopeName)
    }
    
}
