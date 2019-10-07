import UIKit

class BoardCollectionViewController: UICollectionViewController {

    private let columnController = ColumnController()

    var columns: [Column] = Board.example

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addColumn(_ sender: UIBarButtonItem) {
        let addColumn = columnController.makeAddColumnTableViewController { [weak self] column in
            self?.columns.append(column)
            self?.collectionView.reloadData()
        }

        present(addColumn, animated: true)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        columns.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        columns[section].cards.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reuseIdentifier, for: indexPath) as! CardCollectionViewCell
        cell.card = columns[indexPath.section].cards[indexPath.row]

        return cell
    }
}
