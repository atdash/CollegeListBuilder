//
//  TasksViewController.swift
//  RealmTasks
//
//  Created by Hossam Ghareeb on 10/19/15.
//  Copyright © 2015 Hossam Ghareeb. All rights reserved.
//

import UIKit
import RealmSwift


class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum IsCollegeOrTask {
        case TaskTrack
        case CollegeTrack
    }
    
//    var Track = IsCollegeOrTask.TaskTrack
    var Track = IsCollegeOrTask.CollegeTrack
    
    var selectedList : TaskList!
    var openTasks : Results<Task>!
    var completedTasks : Results<Task>!
    var currentCreateAction:UIAlertAction!
    
    var selectedCollegeList: CollegeList!
    var favColleges: Results<College>!
    var otherColleges: Results<College>!
    var favAddAction: UIAlertAction!
    
//    var collegeFields: CollegeFields!
//    var collegeModel: CollegeControl!
    
    var isEditingMode = false
    
    @IBOutlet weak var tasksTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch Track {
        case .TaskTrack:
            self.title = selectedList.name
        case .CollegeTrack:
            self.title = selectedCollegeList.name
        }

        readTasksAndUpateUI()

    }

    
    // MARK: - User Actions -
    
    @IBAction func didClickOnEditTasks(sender: AnyObject) {
        isEditingMode = !isEditingMode
        self.tasksTableView.setEditing(isEditingMode, animated: true)
    }
    @IBAction func didClickOnNewTask(sender: AnyObject) {
        switch Track {
        case .TaskTrack:
            self.displayAlertToAddTask(nil)
        case .CollegeTrack:
            self.displayAlertToAddCollege(nil)
        }
    }
    func readTasksAndUpateUI(){
        
        switch Track {
        case .TaskTrack:
            completedTasks = self.selectedList.tasks.filter("isCompleted = true")
            openTasks = self.selectedList.tasks.filter("isCompleted = false")
        case .CollegeTrack:
            otherColleges = self.selectedCollegeList.collegeList.filter("isFavorite = false")
            favColleges = self.selectedCollegeList.collegeList.filter("isFavorite = true")
        }

        self.tasksTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UITableViewDataSource -
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0{
            switch Track {
            case .TaskTrack:
                return openTasks.count
            case .CollegeTrack:
                return favColleges.count
            }
        }
        switch Track {
        case .TaskTrack:
            return completedTasks.count
        case .CollegeTrack:
            return otherColleges.count
        }
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0{
            switch Track {
            case .TaskTrack:
                return "OPEN TASKS"
            case .CollegeTrack:
                return "Favorite Colleges"
            }
        }
        switch Track {
        case .TaskTrack:
            return "COMPLETED TASKS"
        case .CollegeTrack:
            return "Other Colleges"
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        switch Track {
        case .TaskTrack:
            var task: Task!
            if indexPath.section == 0{
            task = openTasks[indexPath.row]
            }
            else{
                task = completedTasks[indexPath.row]
            }
        
            cell?.textLabel?.text = task.name
        
        case .CollegeTrack:
            var college: College!
            if indexPath.section == 0{
                college = favColleges[indexPath.row]
            }
            else{
                college = otherColleges[indexPath.row]
            }
            
            cell?.textLabel?.text = college.name
        }

        return cell!
    }
    
    
    func displayAlertToAddTask(updatedTask:Task!){

            let uiRealm = try! Realm()
        
            var title = "New Task"
            var doneTitle = "Create"
            if updatedTask != nil{
                title = "Update Task"
                doneTitle = "Update"
            }
        
                let alertController = UIAlertController(title: title, message: "Write the name of your task.", preferredStyle: UIAlertControllerStyle.Alert)
                let createAction = UIAlertAction(title: doneTitle, style: UIAlertActionStyle.Default) { (action) -> Void in
                    
                    let taskName = alertController.textFields?.first?.text
                    
                    if updatedTask != nil{
                        // update mode
                        try! uiRealm.write() {
                            
                            updatedTask.name = taskName!
                            self.readTasksAndUpateUI()
                        }
                    }
                    else{
                        
                        let newTask = Task()
                        newTask.name = taskName!
                        
                        try! uiRealm.write() {
                            
                            self.selectedList.tasks.append(newTask)
                            self.readTasksAndUpateUI()
                        }
                    }
                    
                    print(taskName)
                }
                
                alertController.addAction(createAction)
                createAction.enabled = false
                self.currentCreateAction = createAction
                
                alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
                
                alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
                    textField.placeholder = "Task Name"
                    textField.addTarget(self, action: "taskNameFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
                    if updatedTask != nil{
                        textField.text = updatedTask.name
                    }
                }
                
                self.presentViewController(alertController, animated: true, completion: nil)
        }
    
            
            
    func displayAlertToAddCollege(updatedCollege:College!){

            var title = "New College"
            var doneTitle = "Add"
            if updatedCollege != nil{
                title = "Update College"
                doneTitle = "Update"
            }
        
        let uiRealm = try! Realm()
        
        let alertController = UIAlertController(title: title, message: "Add the name of your College.", preferredStyle: UIAlertControllerStyle.Alert)
        let createAction = UIAlertAction(title: doneTitle, style: UIAlertActionStyle.Default) { (action) -> Void in
            
            let collegeName = alertController.textFields![0] 
//            let collegePK = alertController.textFields![1]
            
            if updatedCollege != nil{
                // update mode
                try! uiRealm.write() {
                    
                    updatedCollege.name = collegeName.text!
                    self.readTasksAndUpateUI()
                }
            }
            else{
                let newCollege = College()
                newCollege.name = collegeName.text!
                
                try! uiRealm.write() {
                    
                    self.selectedCollegeList.collegeList.append(newCollege)
                    self.readTasksAndUpateUI()
                }
            }

            print(collegeName)
        }
        
        alertController.addAction(createAction)
        createAction.enabled = false
        self.currentCreateAction = createAction
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "College Name"
            textField.addTarget(self, action: "taskNameFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
            if updatedCollege != nil{
                textField.text = updatedCollege.name
            }
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
        

    //Enable the create action of the alert only if textfield text is not empty
    func taskNameFieldDidChange(textField:UITextField){
        self.currentCreateAction.enabled = textField.text?.characters.count > 0
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let uiRealm = try! Realm()

        switch Track {
        case .TaskTrack:
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Delete") { (deleteAction, indexPath) -> Void in
            
            //Deletion will go here
            
            var taskToBeDeleted: Task!
            if indexPath.section == 0{
                taskToBeDeleted = self.openTasks[indexPath.row]
            }
            else{
                taskToBeDeleted = self.completedTasks[indexPath.row]
            }
            
            try! uiRealm.write() {
                uiRealm.delete(taskToBeDeleted)
                self.readTasksAndUpateUI()
            }
        }
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Edit") { (editAction, indexPath) -> Void in
            
            // Editing will go here
            var taskToBeUpdated: Task!
            if indexPath.section == 0{
                taskToBeUpdated = self.openTasks[indexPath.row]
            }
            else{
                taskToBeUpdated = self.completedTasks[indexPath.row]
            }
            
            self.displayAlertToAddTask(taskToBeUpdated)
            
        }
        
        let doneAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Done") { (doneAction, indexPath) -> Void in
            // Editing will go here
            var taskToBeUpdated: Task!
            if indexPath.section == 0{
                taskToBeUpdated = self.openTasks[indexPath.row]
            }
            else{
                taskToBeUpdated = self.completedTasks[indexPath.row]
            }
            try! uiRealm.write() {
                taskToBeUpdated.isCompleted = true
                self.readTasksAndUpateUI()
            }
            
        }
        return [deleteAction, editAction, doneAction]

        
        case .CollegeTrack:
            
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Delete") { (deleteAction, indexPath) -> Void in
                
            //Deletion will go here
            
            var CollegeToBeDeleted: College!
            if indexPath.section == 0{
                CollegeToBeDeleted = self.favColleges[indexPath.row]
            }
            else{
                CollegeToBeDeleted = self.otherColleges[indexPath.row]
            }
            
            try! uiRealm.write() {
                uiRealm.delete(CollegeToBeDeleted)
                self.readTasksAndUpateUI()
            }
        }
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Edit") { (editAction, indexPath) -> Void in
            
            // Editing will go here
            var collegeToBeUpdated: College!
            if indexPath.section == 0{
                collegeToBeUpdated = self.favColleges[indexPath.row]
            }
            else{
                collegeToBeUpdated = self.otherColleges[indexPath.row]
            }
            
            self.displayAlertToAddCollege(collegeToBeUpdated)
            
        }
        
        let doneAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Favorite") { (doneAction, indexPath) -> Void in
            // Editing will go here
            var collegeToBeUpdated: College!
            if indexPath.section == 0{
                collegeToBeUpdated = self.favColleges[indexPath.row]
            }
            else{
                collegeToBeUpdated = self.otherColleges[indexPath.row]
            }
            try! uiRealm.write() {
                let isNow = collegeToBeUpdated.isFavorite
                collegeToBeUpdated.isFavorite = !isNow
                self.readTasksAndUpateUI()
            }
            
        }
        
        return [deleteAction, editAction, doneAction]

        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
