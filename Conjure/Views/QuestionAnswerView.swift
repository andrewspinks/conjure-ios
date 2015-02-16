

import UIKit

@objc(QuestionAnswerView)
class QuestionAnswerView: BindingView, UITextFieldDelegate {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var answerTextField: UITextField!
  weak var delegate: Answereable?
  
  init(delegate: Answereable) {
    super.init(nib: "QuestionAnswerView")
    self.delegate = delegate
    self.answerTextField.becomeFirstResponder()
    self.answerTextField.delegate = self
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
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
