import Quick
import Nimble
import PactConsumerSwift
import Conjure

class HelloClientSpec: QuickSpec {
  override func spec() {
    var helloProvider: MockService?
    var helloClient: HelloClient?
    
    describe("tests fulfilling all expected interactions") {
      beforeEach {
        helloProvider = MockService(provider: "Hello Provider", consumer: "Hello Consumer", done: { result in
          expect(result).to(equal(PactVerificationResult.Passed))
        })
        helloClient = HelloClient(baseUrl: helloProvider!.baseUrl)
      }
      
      it("it says Hello") {
        var hello = "not Goodbye"
        
        helloProvider!.uponReceiving("a request for hello")
          .withRequest(PactHTTPMethod.Get, path: "/sayHello")
          .willRespondWith(200, headers: ["Content-Type": "application/json"], body: ["reply": "Hello"])
        
        //Run the tests
        helloProvider!.run { (testComplete) -> Void in
          helloClient!.sayHello { (response) in
            hello = response
            testComplete()
          }
        }
        
        expect(hello).toEventually(contain("Hello"))
      }
    }
  }
}
