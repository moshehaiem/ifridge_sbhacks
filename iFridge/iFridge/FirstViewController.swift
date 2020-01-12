//
//  FirstViewController.swift
//  iFridge
//
//  Created by Patrick Kuang on 1/11/20.
//  Copyright © 2020 Patrick Kuang. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var groceryList = [FoodItem]()
//    let manager = LocalNotificationManager()
    @IBOutlet weak var listInput: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var expDate: UITextField!
    
    let picker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        let currentDate = Date()
//        print(currentDate)

        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.textColor = UIColor.red
        
        listInput.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //table interface
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (groceryList.count)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
    
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let date = formatter.string(from: groceryList[indexPath.row].expDate)
//        let diffInDays = Calendar.current.dateComponents([.day], from: Date, to: groceryList[indexPath.row].expDate)
//        prinit(diffInDays)
        cell.textLabel?.text = groceryList[indexPath.row].foodName + "  " + date
        let today = Date()
        let modifiedDate = Calendar.current.date(byAdding: .day, value: 7, to: today)!
        if (groceryList[indexPath.row].expDate < modifiedDate ){
            cell.textLabel?.textColor = UIColor.orange
        }
        let modifiedDate2 = Calendar.current.date(byAdding: .day, value: 14, to: today)!
        if (groceryList[indexPath.row].expDate >= modifiedDate2 ){
            cell.textLabel?.textColor = UIColor.green
        }
        if (groceryList[indexPath.row].expDate < today ){
            cell.textLabel?.textColor = UIColor.red
        }
        
 

        return(cell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
//            let temp = groceryList[indexPath.row]
//            manager.deleteNotification(temp: temp.foodName)
            self.groceryList.remove(at: indexPath.row)
            myTableView.reloadData()
//            manager.listScheduledNotifications()
        }

    }
    
    //plus button interface
    @IBAction func addItem(_ sender: Any)
    {
        if (listInput.text != "")
        {
            let varName = FoodItem(foodName: listInput.text!, expDate: picker.date )
            //let expirDate = picker.date
            //let tempDate = Calendar.current.dateComponents([.year, .month, .day], from: expirDate)
//            let tempDate = DateComponents(calendar: Calendar.current, year: 2020, month: 1, day: 11, hour: 21, minute: 26)Í
//            manager.addNotification(food: listInput.text!, date: tempDate)
//            manager.schedule()
//            manager.listScheduledNotifications()
            self.groceryList.append(varName)
            self.groceryList.sort{ (item1, item2) -> Bool in
                return item1.expDate.compare(item2.expDate) == ComparisonResult.orderedAscending
            }
            listInput.text = ""
            expDate.text = ""
            myTableView.reloadData()
        }
        //manager.addNotification(listInput.text, )
    }
    
    func createDatePicker(){
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        expDate.inputAccessoryView = toolbar
        expDate.inputView = picker
        
        //format picker for date
       self.picker.minimumDate = Date()
        picker.datePickerMode = .date
        
    }
    
    @objc func donePressed(){
        //formate date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: picker.date)
        
        expDate.text = "\(dateString)"
        self.view.endEditing(true)
    }

}


//when return key is pressed it will dismiss the keyboard
extension FirstViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
