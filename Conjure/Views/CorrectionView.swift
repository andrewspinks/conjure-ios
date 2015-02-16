

import UIKit

@objc(CorrectionView)
class CorrectionView: UIView {
  
  @IBOutlet weak var subview: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionTextView: UITextView!
  @IBOutlet weak var wrongAnswerLabel: UILabel!
  @IBOutlet weak var answersLabel: UILabel!
  weak var delegate :Answereable?

  init(frame: CGRect, delegate: Answereable) {
    super.init(frame: frame)
    var subviewArray = NSBundle.mainBundle().loadNibNamed("CorrectionView", owner:self, options:nil)
    subview = subviewArray[0] as? UIView
    
    self.addSubview(self.subview)
    self.setTranslatesAutoresizingMaskIntoConstraints(false)
    self.subview.setTranslatesAutoresizingMaskIntoConstraints(false)
    self.subview.setNeedsLayout()
    
    self.delegate = delegate
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
