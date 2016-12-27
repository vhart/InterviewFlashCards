import Nocilla
import Quick

class NocillaConfiguration: QuickConfiguration {
    override class func configure(_ configuration: Configuration) {
        beforeSuite {
            LSNocilla.sharedInstance().start()
        }
        afterSuite {
            LSNocilla.sharedInstance().stop()
        }
    }
}
