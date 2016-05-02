//
//  TaskListsViewController.swift
//  RealmTasks
//
//  Created by Hossam Ghareeb on 10/13/15.
//  Copyright © 2015 Hossam Ghareeb. All rights reserved.
//

import UIKit
import RealmSwift

class TaskListsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum IsCollegeOrTask {
        case TaskTrack
        case CollegeTrack
    }
    
//    var Track = IsCollegeOrTask.TaskTrack
    var Track = IsCollegeOrTask.CollegeTrack


    var lists : Results<TaskList>!
    var colleges: Results<CollegeList>!
    var people: Results<Person>!
    
    var isEditingMode = false
    
    var currentCreateAction:UIAlertAction!
    @IBOutlet weak var taskListsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        readTasksAndUpdateUI()
    }
    
    func readTasksAndUpdateUI(){
        
//        let uiRealm = try! Realm()
        do {
            let uiRealm = try Realm()
        
        switch Track {
        case .TaskTrack:
            lists = uiRealm.objects(TaskList)
        case .CollegeTrack:
            colleges = uiRealm.objects(CollegeList)
        }
        self.taskListsTableView.setEditing(false, animated: true)
        self.taskListsTableView.reloadData()

        } catch let error as NSError {
            print("This is the darn path permissions error \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - User Actions -
    
    
    func InitializePersonForList(newCollegeList: CollegeList) {
        
        let uiRealm = try! Realm()

        try! uiRealm.write {
            let person = uiRealm.create(Person.self)
            person.name = "College List Name"
            person.email = "email@domain.com"
            person.myLists.append(newCollegeList)
            person.SAT_Math = 700
            person.SAT_Reading = 600
            person.SAT_Writing = 500
            uiRealm.add(person)
        }
    }
    
    func InitializeNewCollegeList(newCollegeList: CollegeList) {
        
        let uiRealm = try! Realm()
        
        let allColleges = uiRealm.objects(College)
        
        try! uiRealm.write() {
            for ruColleges in allColleges {
                newCollegeList.collegeList.append(ruColleges)
            }   
        }
    }
    
    
    
    
    @IBAction func didSelectSortCriteria(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            
            switch Track {
            case .TaskTrack:
                // A-Z
                self.lists = self.lists.sorted("name")
            case .CollegeTrack:
                // A-Z
                self.colleges = self.colleges.sorted("name")
            }
            
        }
        else{
            switch Track {
            case .TaskTrack:
                // date
                self.lists = self.lists.sorted("createdAt", ascending:false)
            case .CollegeTrack:
                // date
                self.colleges = self.colleges.sorted("createdAt", ascending:false)
            }
        }
        self.taskListsTableView.reloadData()
    }
    
    @IBAction func didClickOnEditButton(sender: UIBarButtonItem) {
        isEditingMode = !isEditingMode
        self.taskListsTableView.setEditing(isEditingMode, animated: true)
    }
    
    @IBAction func didClickOnAddButton(sender: UIBarButtonItem) {

        switch Track {
        case .TaskTrack:
            displayAlertToAddTaskList(nil)
        case .CollegeTrack:
            displayAlertToAddCollegeList(nil)
        }
    }
    
    //Enable the create action of the alert only if textfield text is not empty
    func listNameFieldDidChange(textField:UITextField){
        self.currentCreateAction.enabled = textField.text?.characters.count > 0
    }
    

    func displayAlertToAddCollegeList(updatedCollege:CollegeList!) {
        //create college function here...
        var title = "New Colleges List"
        var doneTitle = "Create"
        if updatedCollege != nil{
            title = "Update Colleges List"
            doneTitle = "Update"
        }
        
        let uiRealm = try! Realm()
        
        let alertController = UIAlertController(title: title, message: "Write the name of your colleges list.", preferredStyle: UIAlertControllerStyle.Alert)
        let createAction = UIAlertAction(title: doneTitle, style: UIAlertActionStyle.Default) { (action) -> Void in
            
            let collegeListName = alertController.textFields?.first?.text
            
            if updatedCollege != nil{
                // update mode
                try! uiRealm.write(){
                    updatedCollege.name = collegeListName!
                    self.readTasksAndUpdateUI()
                }
            }
            else{
                
                let newCollegeList = CollegeList()
                newCollegeList.name = collegeListName!
                
                try! uiRealm.write(){
                    
                    uiRealm.add(newCollegeList)
                    self.readTasksAndUpdateUI()
                }
                
                self.InitializeNewCollegeList(newCollegeList)
                self.InitializePersonForList(newCollegeList)
            }
            
            
            
            print(collegeListName)
        }
        
        alertController.addAction(createAction)
        createAction.enabled = false
        self.currentCreateAction = createAction
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "College List Name"
            textField.addTarget(self, action: "listNameFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
            if updatedCollege != nil{
                textField.text = updatedCollege.name
            }
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func displayAlertToAddTaskList(updatedList:TaskList!){
        
        var title = "New Tasks List"
        var doneTitle = "Create"
        if updatedList != nil{
            title = "Update Tasks List"
            doneTitle = "Update"
        }
        
        let uiRealm = try! Realm()
        
        let alertController = UIAlertController(title: title, message: "Write the name of your tasks list.", preferredStyle: UIAlertControllerStyle.Alert)
        let createAction = UIAlertAction(title: doneTitle, style: UIAlertActionStyle.Default) { (action) -> Void in
            
            let listName = alertController.textFields?.first?.text
            
            if updatedList != nil{
                // update mode
                try! uiRealm.write(){
                    updatedList.name = listName!
                    self.readTasksAndUpdateUI()
                }
            }
            else{
                
                let newTaskList = TaskList()
                newTaskList.name = listName!
                
                try! uiRealm.write(){
                    
                    uiRealm.add(newTaskList)
                    self.readTasksAndUpdateUI()
                }
            }
            
            
            
            print(listName)
        }
        
        alertController.addAction(createAction)
        createAction.enabled = false
        self.currentCreateAction = createAction
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Task List Name"
            textField.addTarget(self, action: "listNameFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
            if updatedList != nil{
                textField.text = updatedList.name
            }
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDataSource -
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch Track {
        case .TaskTrack:
            if let listsTasks = lists{
                return listsTasks.count
        }
        case .CollegeTrack:
            if let listsColleges = colleges{
                return listsColleges.count
            }
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("listCell")
        
        switch Track {
        case .TaskTrack:
            let list = lists[indexPath.row]
            
            cell?.textLabel?.text = list.name
            cell?.detailTextLabel?.text = "\(list.tasks.count) Tasks"
        case .CollegeTrack:
            let college = colleges[indexPath.row]
            
            cell?.textLabel?.text = college.name
            cell?.detailTextLabel?.text = "\(college.collegeList.count) Colleges"
        }

        return cell!
    }

    // Handle the 'swipe row' actions here...
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Delete") { (deleteAction, indexPath) -> Void in
            
            //Deletion will go here
            let uiRealm = try! Realm()
            
            switch self.Track {
            case .TaskTrack:
                let listToBeDeleted = self.lists[indexPath.row]
                try! uiRealm.write(){
                    uiRealm.delete(listToBeDeleted)
                    self.readTasksAndUpdateUI()
                }
            case .CollegeTrack:
                let collegeToBeDeleted = self.colleges[indexPath.row]
                try! uiRealm.write(){
                    uiRealm.delete(collegeToBeDeleted)
                    self.readTasksAndUpdateUI()
                }
            }
        }
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Edit") { (editAction, indexPath) -> Void in
        
            switch self.Track {
            case .TaskTrack:
                // Editing will go here
                let listToBeUpdated = self.lists[indexPath.row]
                self.displayAlertToAddTaskList(listToBeUpdated)
            case .CollegeTrack:
                // Editing will go here
                let collegeToBeUpdated = self.colleges[indexPath.row]
                self.displayAlertToAddCollegeList(collegeToBeUpdated)
            }
        }
        return [deleteAction, editAction]
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch Track {
        case .TaskTrack:
            self.performSegueWithIdentifier("openTasks", sender: self.lists[indexPath.row])
        case .CollegeTrack:
            self.performSegueWithIdentifier("openTasks", sender: self.colleges[indexPath.row])
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let tasksViewController = segue.destinationViewController as! TasksViewController

        switch Track {
        case .TaskTrack:
            tasksViewController.selectedList = sender as! TaskList
        case .CollegeTrack:
            tasksViewController.selectedCollegeList = sender as! CollegeList
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
