

import UIKit

class QuestionAnswerView: UIView {
  
  var subview : UIView?

  override init(frame: CGRect) {
    super.init(frame: frame)
    var subviewArray = NSBundle.mainBundle().loadNibNamed("QuestionAnswerView", owner:self, options:nil)
    subview = subviewArray[0] as? UIView
    self.setTranslatesAutoresizingMaskIntoConstraints(false)
    if let subview = subview {
      subview.setTranslatesAutoresizingMaskIntoConstraints(false)
      self.addSubview(subview)
    }
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func updateConstraints() {
    super.updateConstraints()
    
    if let subview = subview {
      self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[subview]|",
        options:.AlignAllLeft,
        metrics:nil,
        views:["subview": subview]))
      self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[subview]|",
        options:.AlignAllLeft,
        metrics:nil,
        views:["subview": subview]))
    }
  }
}
