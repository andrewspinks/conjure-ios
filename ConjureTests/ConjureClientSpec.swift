import Quick
import Nimble
import PactConsumerSwift
import Conjure

class ConjureClientSpec: QuickSpec {
  override func spec() {
    var conjureProvider: MockService?
    var conjureClient: ConjureClient?

    describe("tests fulfilling all expected interactions") {
      beforeEach {
        conjureProvider = MockService(provider: "Conjure Provider", consumer: "iOS App", done: { result in
          expect(result).to(equal(PactVerificationResult.Passed))
        })
        conjureClient = ConjureClient(baseUrl: conjureProvider!.baseUrl)
      }

      it("it returns list of questions") {
        var questions : Array<Conjure.Question> = []

        conjureProvider!.given("Only 待つ exists as a question")
                      .uponReceiving("a request for a session")
                      .withRequest(PactHTTPMethod.Post, path: "/session")
                      .willRespondWith(200,
                        headers: ["Content-Type": "application/json"],
                        body: ["session": [ "questions" : [
                                [ "id" : "1", "title": "'te' form", "kanji": "待ちいます", "kana": "まちいます", "definition": "To help with", "answer": "待って", "alternatives": ["まって"]
                                ]
                        ]]])

        //Run the tests
        conjureProvider!.run { (testComplete) -> Void in
          conjureClient!.newSession().onSuccess { response in
            questions = response
            expect(questions[0].kanji).to(equal("待ちいます"))
            expect(questions[0].answer).to(equal("待って"))
            testComplete()
          }
          return
        }

        expect(questions.count).toEventually(equal(1))
      }
    }
  }
}
