import UIKit

class BoardCollectionViewController: UICollectionViewController {

    private let columnController = ColumnController()

    var columns: [Column] = Board.example

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dragDelegate = self
    }
    
    @IBAction func addColumn(_ sender: UIBarButtonItem) {
        let addColumn = columnController.makeAddColumnTableViewController { [weak self] column in
            self?.columns.append(column)
            self?.collectionView.reloadData()
        }

        present(addColumn, animated: true)
    }
    
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */

    // MARK: UICollectionViewDataSource

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

extension BoardCollectionViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let selectedCard = columns[indexPath.section].cards[indexPath.row]

        let userActivity = selectedCard.userActivity
        let itemProvider = NSItemProvider(object: userActivity)
        
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = selectedCard

        return [dragItem]
    }
}
