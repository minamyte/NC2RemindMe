//
//  ViewController.swift
//  NC2RemindMe
//
//  Created by anandito baramayasi on 11/03/20.
//  Copyright © 2020 anandito baramayasi. All rights reserved.
//


//TO-DO
//ALARM
//SOUND
//HI-FI PROTOTYPE







import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var InputTime: UITextField!
    
    @IBOutlet weak var InputTask: UITextField!
    //ATTRIBUTES
    
    
    var Currtime = ""
    
    var picker = UIDatePicker()
    
    var ReminderClock: [String] = []
    var ReminderTask: [String] = []
    var ReminderRemaining: [String] = []
    
    var TimeInput = ""
    var TaskInput = ""
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        tableView.delegate=self
        tableView.dataSource=self
   
        
        super.viewDidLoad()
        
        createpicker()
        createpickerForTasks()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func RemindMe(_ sender: Any) {
        insertInput()
    }
    
    func insertInput(){
        ReminderClock.append(InputTime.text!)
        ReminderTask.append(InputTask.text!)
        
        let indexPath = IndexPath(row: ReminderClock.count-1, section: 0)
        
     //   tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
     //   tableView.endUpdates()
        
        tableView.reloadData()
        view.endEditing(true)
        
    }
    
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReminderClock.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1 , reuseIdentifier: "CellGenerator")
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "RemindCell") as! CellGenerator
        
        cell.ReminderClockCell.text = ReminderClock[indexPath.row]
        cell.ReminderTaskCell.text = ReminderTask[indexPath.row]
        
        
        return cell
      }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            ReminderClock.remove(at: indexPath.row)
            ReminderTask.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    
    @objc func getCurrClock(){
        
          _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {timer in
              let dat=DateFormatter()
                           dat.dateFormat = "HH:mm"
                           let str = dat.string(from: Date())
            self.Currtime=str
            print(str)
          } )
    
}
    
    
    @objc func createpicker(){
           let toolbar=UIToolbar()
           toolbar.sizeToFit()
        
           
           let done=UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePress))
           toolbar.setItems([done], animated: false)
           
           InputTime.inputAccessoryView=toolbar
           InputTime.inputView=picker
           
           picker.datePickerMode = .time
           
    }
    
    @objc func createpickerForTasks(){
           let toolbar=UIToolbar()
           toolbar.sizeToFit()
        
           
           let done=UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(DonePressTasks))
           toolbar.setItems([done], animated: false)
           
           InputTask.inputAccessoryView=toolbar
           
    }

    @objc func DonePressTasks(){
        self.view.endEditing(true)
    }
    
    @objc func donePress(){
           let format=DateFormatter()
           format.dateFormat="HH:mm"
           let timeString=format.string(from: picker.date)
           
           InputTime.text="\(timeString)"
        
           self.view.endEditing(true)
           

       }
    
    
    
    

        @objc func ReminderChecker(){
            
            let formater=DateFormatter()
            for obj in ReminderClock{
                let str = obj
                let AlarmTime = formater.date(from: str )
                formater.dateFormat="HH:mm"
                let myStringdat = formater.string(from: AlarmTime!)
                let isEqual = (myStringdat == Currtime)
                if (isEqual == true){
                    //alarm pop up
                    showAlert3()
                }
            }
            
              
        
       
        }
    
    
    func showAlert3() {
        let alert = UIAlertController(title: "Message", message: "Alarm time", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}
