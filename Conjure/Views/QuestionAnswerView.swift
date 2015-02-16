

import UIKit

@objc(QuestionAnswerView)
class QuestionAnswerView: UIView, UITextFieldDelegate {
  
  @IBOutlet weak var subview: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var answerTextField: UITextField!
  weak var delegate: Answereable?

  init(frame: CGRect, delegate: Answereable) {
    super.init(frame: frame)
    var subviewArray = NSBundle.mainBundle().loadNibNamed("QuestionAnswerView", owner:self, options:nil)
    subview = subviewArray[0] as? UIView
 
    self.addSubview(self.subview)
    self.setTranslatesAutoresizingMaskIntoConstraints(false)
    self.subview.setTranslatesAutoresizingMaskIntoConstraints(false)
    self.subview.setNeedsLayout()
    
    self.delegate = delegate
    self.answerTextField.becomeFirstResponder()
    self.answerTextField.delegate = self
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

  internal func show(question: Question) {
    self.titleLabel.text = question.title
    var attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(19.0)]
    var kanjiString = NSMutableAttributedString(string:"\(question.kanji) ", attributes:attrs)
    var descriptionString = NSMutableAttributedString(string:"(\(question.kana)) \n\n \(question.definition)")
    kanjiString.appendAttributedString(descriptionString)
    self.descriptionTextView.attributedText = kanjiString
  }
 
  @IBAction func check(source: UIButton) -> Void {
    if let dele = self.delegate {
      dele.check(answerTextField.text)
    }
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool{
    if textField == self.answerTextField {
      if let dele = self.delegate {
        dele.check(answerTextField.text)
      }
      return false
    }
    return true
  }
}
