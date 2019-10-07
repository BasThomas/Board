import UIKit

class AddColumnTableViewController: UITableViewController {

    static let identifier = "addColumnTableViewController"

    @IBOutlet weak var columnTextField: UITextField!
    @IBOutlet weak var cardsTextField: UITextField!
    private let completion: (Column) -> Void

    init?(coder: NSCoder, completion: @escaping (Column) -> Void) {
        self.completion = completion
        super.init(coder: coder)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func add() {
        guard let columnText = columnTextField.text, columnText.isEmpty == false else { fatalError("Must not add an empty column") }
        guard let cardText = cardsTextField.text, cardText.isEmpty == false else { fatalError("Must not add a column without cards") }
        let cards = cardText.components(separatedBy: ",").map(Card.init)

        let column = Column(cards: cards)
        completion(column)

        dismiss(animated: true)
    }
}
