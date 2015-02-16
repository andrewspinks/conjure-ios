

import UIKit

@objc(CorrectionView)
class CorrectionView: BindingView {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var wrongAnswerLabel: UILabel!
  @IBOutlet weak var answersLabel: UILabel!
  weak var delegate :Answereable?

  init(delegate: Answereable) {
    super.init(nib: "CorrectionView")
    self.delegate = delegate
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  internal func show(question: Question, answer: String) {
    self.titleLabel.text = question.title
    var attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(19.0)]
    var kanjiString = NSMutableAttributedString(string:"\(question.kanji) ", attributes:attrs)
    var descriptionString = NSMutableAttributedString(string:"(\(question.kana)) \n\n \(question.definition)")
    kanjiString.appendAttributedString(descriptionString)
    
    self.descriptionTextView.attributedText = kanjiString
    self.wrongAnswerLabel.text = "\"\(answer)\""
    self.answersLabel.text = question.answer
  }
  
  @IBAction func next(source: UIButton) -> Void {
    if let delegate = delegate {
      delegate.nextQuestion()
    }
  }
}
