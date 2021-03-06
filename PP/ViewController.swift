//
//  ViewController.swift
//  PP
//
//  Created by Peter Marathas on 12/12/18.
//  Copyright © 2018 Pete&Pat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // hello Patrick
    // hello
    
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var taskLabel: UILabel!
    
    var storage = UserDefaults.standard
    var calendar = Calendar.current
    
    let the_list = [
        "Read a scientific article",
        "Make your bed",
        "Read a chapter of a book",
        "Meditate for ten minutes",
        "Complete a crossword puzzle",
        "Watch a TED Talk",
        "Put old clothes aside to donate",
        "Reach out to a friend you haven't spoken to in a while",
        "Call a family member"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // change these 2
        let useDailyTask = false // true will lock it for the day
        let indexFromTheList = Int.random(in: 0..<the_list.count) // use specific index
        
        if useDailyTask, let task = getStoredTask() {
            taskLabel.text = task.task
            if task.didComplete {
                self.checkTheBox()
            }
        } else {
            let newTask = the_list[indexFromTheList]
            taskLabel.text = newTask
            storage.set(newTask, forKey: "last-task")
            storage.set(Date(), forKey: "last-date")
        }
        checkBox.layer.borderWidth = 1.0
        checkBox.layer.borderColor = UIColor.black.cgColor
        checkBox.layer.cornerRadius = 4
        checkBox.clipsToBounds = true
    }
    
    struct Task {
        let task: String
        let didComplete: Bool
    }
    
    private func getStoredTask() -> Task? {
        if let lastDate = storage.value(forKey: "last-date") as? Date, let lastTask = storage.string(forKey: "last-task"), calendar.isDateInToday(lastDate) {
            let didComplete = storage.bool(forKey: "did-complete")
            return Task(task: lastTask, didComplete: didComplete)
        } else { return nil }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 2) {
            self.checkBox.isHidden = false
            self.taskLabel.isHidden = false
        }
    }

    @IBAction func checkTheBox() {
        checkBox.setImage(#imageLiteral(resourceName: "icons8-checkmark-16.png"), for: .normal)
        storage.setValue(true, forKey: "did-complete")
    }
    
    
}

