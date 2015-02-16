
import UIKit

@objc(SummaryView)
class SummaryView: BindingView {
  
  init() {
    super.init(nib: "SummaryView")
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}
