import UIKit

class ColumnController {
    func makeAddColumnTableViewController(
        completion: @escaping (Column) -> Void
    ) -> UINavigationController {
        let controller = UIStoryboard(
            name: "Main",
            bundle: .main
        ).instantiateViewController(
            identifier: AddColumnTableViewController.identifier
        ) { coder in
            AddColumnTableViewController(
                coder: coder,
                completion: completion
            )
        }

        let navigationController = UINavigationController(
            rootViewController: controller
        )
        controller.navigationItem.rightBarButtonItem = .init(
            title: "Add Column",
            style: .done,
            target: controller,
            action: #selector(AddColumnTableViewController.add)
        )
        return navigationController
    }
}
