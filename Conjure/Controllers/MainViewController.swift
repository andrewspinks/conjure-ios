
import UIKit

@objc(MainViewController)
class MainViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func launchQuestions(source: UIButton) -> Void {
    var questionViewController = QuestionViewController();
    var navController = UINavigationController(rootViewController: questionViewController)
    navController.modalTransitionStyle = questionViewController.modalTransitionStyle
    
    self.presentViewController(navController, animated:true, completion: nil)
  }
  
}
