
import UIKit

@objc(QuestionViewController)
class QuestionViewController: UIViewController {

  @IBOutlet weak var actionView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("close"))
    
    var answerView = QuestionAnswerView(frame: actionView.frame)
    self.actionView.addSubview(answerView)
    
    actionView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[answerView]|",
      options:.AlignAllLeft,
      metrics:nil,
      views:["answerView": answerView]))
    actionView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[answerView]|",
      options:.AlignAllLeft,
      metrics:nil,
      views:["answerView": answerView]))
    self.actionView.layoutIfNeeded()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func close() -> Void {
    self.dismissViewControllerAnimated(true, completion:nil)
  }
}
