import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var contentLabel: UILabel!

    static let identifier = "cardViewController"

    var card: Card?
    var application: UIApplication = .shared

    override func viewDidLoad() {
        super.viewDidLoad()
        contentLabel.text = card?.content
    }

    @IBAction func close(_ sender: Any) {
        guard let session = view.window?.windowScene?.session else { fatalError("No session found for this view controller") }
        let options = UIWindowSceneDestructionRequestOptions()
        options.windowDismissalAnimation = .decline
        application.requestSceneSessionDestruction(session, options: nil)
    }
}
