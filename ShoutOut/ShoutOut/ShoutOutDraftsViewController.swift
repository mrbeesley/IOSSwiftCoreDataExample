//
//  ViewController.swift
//  ShoutOut

import UIKit
import CoreData

class ShoutOutDraftsViewController: UIViewController,
									UITableViewDataSource,
									UITableViewDelegate,
                                    ManagedObjectContextDependentType {

    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    var managedObjectContext: NSManagedObjectContext!
    var fetchedResultsController: NSFetchedResultsController<ShoutOut>!
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
        configureFetchedResultsController()
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let alertController = UIAlertController(title: "Loading ShoutOuts Failed",
                                                    message: "There was  problem loading the list of shoutouts. Please try again!",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
	}
    
    func configureFetchedResultsController() {
        let shoutOutFetchRequest = NSFetchRequest<ShoutOut>(entityName: ShoutOut.entityName)
        let lastNameSortDescriptor = NSSortDescriptor(key: #keyPath(ShoutOut.toEmployee.lastName), ascending: true)
        let firstNameSortDescriptor = NSSortDescriptor(key: #keyPath(ShoutOut.toEmployee.firstName), ascending: true)
        shoutOutFetchRequest.sortDescriptors = [lastNameSortDescriptor, firstNameSortDescriptor]
        
        self.fetchedResultsController = NSFetchedResultsController<ShoutOut>(fetchRequest: shoutOutFetchRequest,
                                                                             managedObjectContext: self.managedObjectContext,
                                                                             sectionNameKeyPath: nil,
                                                                             cacheName: nil)
    }
	
	// MARK: TableView Data Source methods
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return nil
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = self.fetchedResultsController.sections {
            return sections[section].numberOfObjects
        }
        
        return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "subtitleCell", for: indexPath)
		
        
        let shoutOut = self.fetchedResultsController.object(at: indexPath)
        
		cell.textLabel?.text = "\(shoutOut.toEmployee.firstName) \(shoutOut.toEmployee.lastName)"
		cell.detailTextLabel?.text = shoutOut.shoutCategory
		
		return cell
	}
	
	// MARK: TableView Delegate methods
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
        switch segue.identifier! {
        case "shoutOutDetails":
            let destinationVC = segue.destination as! ShoutOutDetailsViewController
            destinationVC.managedObjectContext = self.managedObjectContext
            
            // Grab the selected index path from the table view and get the corresponding object from the fetch controller
            let selectedIndexPath = self.tableView.indexPathForSelectedRow!
            let selectedShoutOut = self.fetchedResultsController.object(at: selectedIndexPath)
            
            // pass the selected object to destination view controller as the shoutout property
            destinationVC.shoutOut = selectedShoutOut
        case "addShoutOut":
            // this is a little different because it is wrapped in a navigation controller so you have to grab the vc from the navigation controllers list of view controllers
            let navigationController = segue.destination as! UINavigationController
            let destinationVC = navigationController.viewControllers[0] as! ShoutOutEditorViewController
            destinationVC.managedObjectContext = self.managedObjectContext
        default:
            break
        }
	}
}
