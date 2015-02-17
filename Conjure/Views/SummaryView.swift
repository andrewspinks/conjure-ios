
import UIKit

@objc(SummaryView)
class SummaryView: BindingView {
  @IBOutlet weak var numberAnsweredLabel: UILabel!
  @IBOutlet weak var numberCorrectLabel: UILabel!
  
  init() {
    super.init(nib: "SummaryView")
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  @IBAction func showErrors(source: UIButton) -> Void {
    
  }
}
