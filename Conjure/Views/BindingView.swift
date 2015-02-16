

import UIKit

class BindingView: UIView {
  
  @IBOutlet weak var subview: UIView!

  
  init(frame: CGRect = CGRectZero, nib: String) {
    super.init(frame: frame)
    var subviewArray = NSBundle.mainBundle().loadNibNamed(nib, owner:self, options:nil)
    self.subview = subviewArray[0] as? UIView
    
    self.addSubview(self.subview)
    self.setTranslatesAutoresizingMaskIntoConstraints(false)
    self.subview.setTranslatesAutoresizingMaskIntoConstraints(false)
    self.subview.setNeedsLayout()
    
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
