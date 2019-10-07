import UIKit

class AddColumnTableViewController: UITableViewController {

    static let identifier = "addColumnTableViewController"

    private let completion: (Column) -> Void

    init?(coder: NSCoder, completion: @escaping (Column) -> Void) {
        self.completion = completion
        super.init(coder: coder)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
