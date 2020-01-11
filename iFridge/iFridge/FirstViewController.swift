//
//  FirstViewController.swift
//  iFridge
//
//  Created by Patrick Kuang on 1/11/20.
//  Copyright © 2020 Patrick Kuang. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var groceryList = [String]()
    let manager = LocalNotificationManager()
    @IBOutlet weak var listInput: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var expDate: UITextField!
    
    let picker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        
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
        cell.textLabel?.text = groceryList[indexPath.row]

        return(cell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            self.groceryList.remove(at: indexPath.row)
            myTableView.reloadData()
        }

    }
    
    //plus button interface
    @IBAction func addItem(_ sender: Any)
    {
        print(picker.date)
        if (listInput.text != "")
        {
            self.groceryList.append(listInput.text!)
            listInput.text = ""
            myTableView.reloadData()
        }
        
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
