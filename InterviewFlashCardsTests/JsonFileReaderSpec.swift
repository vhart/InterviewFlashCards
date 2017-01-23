import Quick
import Nimble
@testable import InterviewFlashCards

class JsonFileReaderSpec: QuickSpec {
    override func spec() {
        describe("JsonFileReaderSpec") {
            let fileReader = JsonFileReader()
            let sections: [RequestType] = [.iOS, .algorithms, .dataStructures]

            context("each json file is read") {
                it("returns a non empty set of json blobs") {
                    for section in sections {
                        fileReader.getData(for: section, completion: { data in
                            expect(data).toNot(beEmpty())
                        })
                    }
                }
            }
        }
    }
}
