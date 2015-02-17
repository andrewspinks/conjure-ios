
import Alamofire
import BrightFutures

public class ConjureClient {
  private let baseUrl: String

  public init(baseUrl : String) {
    self.baseUrl = baseUrl
  }

  public func newSession() -> Future<Array<Question>> {
    let promise = Promise<Array<Question>>()
    
    Alamofire.request(.POST, "\(baseUrl)/session")
    .responseJSON {
      (request, response, json, error) in
      if let error = error {
        promise.failure(error)
      }

      // TODO: clean up with Swift 1.2
      if let jsonResult = json as? Dictionary<String, AnyObject> {
        if let session = jsonResult["session"] as? Dictionary<String, AnyObject> {
          if let questions = session["questions"] as? Array<Dictionary<String, AnyObject>> {
            promise.success(questions.map { question in
              Question(title: question["title"] as String,
                      kanji: question["kanji"] as String,
                      kana: question["kana"] as String,
                      definition: question["definition"] as String,
                      answer: question["answer"] as String,
                      alternatives: question["alternatives"] as Array<String> )
            })
          }
        }
      } else {
        promise.failure(NSError(domain: "Error parsing json \(json)", code: 0, userInfo: nil))
      }
    }

    return promise.future
  }

}