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
        
    }
}
