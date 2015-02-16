
import UIKit

protocol Answereable: class {
  func check(answer: String)
  func nextQuestion()
}

@objc(QuestionViewController)
class QuestionViewController: UIViewController, Answereable {
  @IBOutlet weak var actionView: UIView!
  @IBOutlet weak var progressBar: UIProgressView!
  var currentView: UIView?
  var constrains: [AnyObject] = []
  var questions: [Question] = []

  var questionIndex: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("close"))

    questions += [ Question(title: "'te' form", kanji: "手伝います", kana: "てつだいます", definition: "To help with", answer: "手伝って", alternatives: ["てつだって"]),
                   Question(title: "'ta' form", kanji: "手伝います", kana: "てつだいます", definition: "To help with", answer: "手伝った", alternatives: ["てつだった"]),
                   Question(title: "'nai' form", kanji: "手伝います", kana: "てつだいます", definition: "To help with", answer: "手伝わない", alternatives: ["てつだわない"]),
                   Question(title: "'plain' form", kanji: "手伝います", kana: "てつだいます", definition: "To help with", answer: "手伝う", alternatives: ["てつだう"]) ]

    self.switchView(newQuestion())
    self.actionView.layoutIfNeeded()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func check(answer: String) {
    var validAnswers = [question().answer] + question().alternatives
    if contains(validAnswers, answer) {
      self.nextQuestion()
    } else {
      var view = CorrectionView(frame: actionView.frame, delegate: self)
      view.show(question(), answer: answer)
      self.switchView(view)
    }
  }
  
  func nextQuestion() {
    self.questionIndex++
    self.progressBar.setProgress(Float(self.questionIndex) / Float(self.questions.count), animated: true)
    self.switchView(newQuestion())
  }

  func close() -> Void {
    self.dismissViewControllerAnimated(true, completion:nil)
  }

  private func newQuestion() -> UIView {
    var questionView = QuestionAnswerView(frame: actionView.frame, delegate: self)
    questionView.show(question())
    return questionView
  }
  
  private func question() -> Question {
    return questions[questionIndex]
  }
  
  private func switchView(newView: UIView) {
    self.actionView.removeConstraints(self.constrains)
    self.constrains = []
    
    if let currentView = self.currentView {
      currentView.removeFromSuperview()
    }
    newView.alpha = 0.0
    self.actionView.addSubview(newView)

    self.constrains += NSLayoutConstraint.constraintsWithVisualFormat("H:|[newView]|",
      options:.AlignAllLeft,
      metrics:nil,
      views:["newView": newView])
    self.constrains += NSLayoutConstraint.constraintsWithVisualFormat("V:|[newView]|",
        options:.AlignAllLeft,
        metrics:nil,
        views:["newView": newView])

    self.actionView.addConstraints(self.constrains)
    self.actionView.layoutIfNeeded()
    self.currentView = newView
    
    UIView.animateKeyframesWithDuration(0.35, delay: 0, options: UIViewKeyframeAnimationOptions.CalculationModeCubic, animations: { () -> Void in
      newView.alpha = 1.0
    }) { (finished) -> Void in

    }
  }
}
