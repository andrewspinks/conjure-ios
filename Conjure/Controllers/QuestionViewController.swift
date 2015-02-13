
import UIKit

@objc(QuestionViewController)
class QuestionViewController: UIViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("close"))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  func close() -> Void {
    self.dismissViewControllerAnimated(true, completion:nil)
  }
}
