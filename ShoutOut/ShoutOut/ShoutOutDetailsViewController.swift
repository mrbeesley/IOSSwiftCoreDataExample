//
//  ShoutOutDetailsViewController.swift
//  ShoutOut

import UIKit
import CoreData

class ShoutOutDetailsViewController: UIViewController, ManagedObjectContextDependentType {

    //MARK: Properties
    var shoutOut: ShoutOut!
    var managedObjectContext: NSManagedObjectContext!
    
	@IBOutlet weak var shoutCategoryLabel: UILabel!
	@IBOutlet weak var messageTextView: UITextView!
	@IBOutlet weak var fromLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUIValues()
    }
    
    //MARK: UI Helper functions
    func setUIValues() {
        self.shoutCategoryLabel.text = self.shoutOut.shoutCategory
        self.messageTextView.text = self.shoutOut.message
        self.fromLabel.text = self.shoutOut.from
    }
	
	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
        // inject the managed object context into the destination controller
        // also this is wrapped in a navigation controller so you have to grab the vc from the navigation controller
        let navigationController = segue.destination as! UINavigationController
        let destinationVC = navigationController.viewControllers[0] as! ShoutOutEditorViewController
        destinationVC.managedObjectContext = self.managedObjectContext
        destinationVC.shoutOut = self.shoutOut
	}
    
    
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Delete ShoutOut",
                                                message: "Are you sure you want to delete this ShoutOut?",
                                                preferredStyle: .actionSheet)
        
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
            (_) -> Void in
            
            // Here is where the code to delete a shoutout goes
            self.managedObjectContext.delete(self.shoutOut)
            
            do {
                try self.managedObjectContext.save()
            } catch {
                self.managedObjectContext.rollback()
                print("Something went wrong while deleting the shoutout: \(error)")
            }
            
            
            let _ = self.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
