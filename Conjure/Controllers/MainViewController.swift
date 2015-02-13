
import UIKit

@objc(MainViewController)
class MainViewController: UIViewController {
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func launchQuestions(source: UIButton) -> Void {
    var questionViewController = QuestionViewController();
    var navController = UINavigationController(rootViewController: questionViewController)
    navController.modalTransitionStyle = questionViewController.modalTransitionStyle
    
    self.presentViewController(navController, animated:true, completion: nil)
  }
  
}
