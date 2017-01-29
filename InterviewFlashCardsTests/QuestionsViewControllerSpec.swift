import Quick
import Nimble
import UIKit
@testable import InterviewFlashCards

struct DataGeneratorMock: DataGenerator {
    let dataMock: [JSON]
        = [["question": "How many potatoes fit in your shoe", "answer": "Five potaTOES, lol"],
           ["question": "Pizza or Salad", "answer": "Pizza"],
           ["question": "Monster Trucks", "answer": "That's not a question"]]

    func getData(for requestType: RequestType, completion: @escaping ([JSON]) -> Void) {
        completion(dataMock)
    }
}

class QuestionsViewControllerSpec: QuickSpec {
    override func spec() {
        describe("QuestionsViewController") {
            var questionVC: QuestionsViewController?
            beforeEach {
                questionVC = nil
                questionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuestionsViewController") as? QuestionsViewController
                questionVC!.set(sectionType: .iOSTechnical)
                questionVC!.dataGenerator = DataGeneratorMock()
            }

            context("viewDidLoad:") {
                it("has three flashcards") {
                    let _ = questionVC!.view
                    expect(questionVC!.flashCards.count) == 3
                }
                it("loads the first question") {
                    let _ = questionVC!.view
                    expect(questionVC!.questionLabel.text) == "How many potatoes fit in your shoe"
                }
            }

            context("Next button") {
                context("tapped once") {
                    it("switches to the next question") {
                        let _ = questionVC!.view
                        expect(questionVC!.questionLabel.text) == "How many potatoes fit in your shoe"

                        questionVC!.nextButton.sendActions(for: .touchUpInside)
                        expect(questionVC!.questionLabel.text) == "Pizza or Salad"
                    }
                }

                context("tapped as many times as there are questions") {
                    it("returns to the first question") {
                        let _ = questionVC!.view
                        let tapsToReturn = questionVC!.flashCards.count
                        expect(questionVC!.questionLabel.text) == "How many potatoes fit in your shoe"

                        for _ in 0 ..< tapsToReturn - 1 {
                            questionVC!.nextButton.sendActions(for: .touchUpInside)
                        }

                        expect(questionVC!.questionLabel.text) == "Monster Trucks"

                        questionVC!.nextButton.sendActions(for: .touchUpInside)

                        expect(questionVC!.questionLabel.text) == "How many potatoes fit in your shoe"
                    }
                }
            }

            context("Previous button") {
                context("tap next then tap previous") {
                    it("switches to the next question and then goes back") {
                        let _ = questionVC!.view
                        expect(questionVC!.questionLabel.text) == "How many potatoes fit in your shoe"

                        questionVC!.nextButton.sendActions(for: .touchUpInside)
                        expect(questionVC!.questionLabel.text) == "Pizza or Salad"

                        questionVC!.prevButton.sendActions(for: .touchUpInside)
                        expect(questionVC!.questionLabel.text) == "How many potatoes fit in your shoe"
                    }
                }

                context("tapped while on the first question") {
                    it("moves to the very last question") {
                        let _ = questionVC!.view
                        expect(questionVC!.questionLabel.text) == "How many potatoes fit in your shoe"

                        questionVC!.prevButton.sendActions(for: .touchUpInside)

                        expect(questionVC!.questionLabel.text) == "Monster Trucks"
                    }
                }
            }
        }
    }
}
