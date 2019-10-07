import UIKit

class BoardCollectionViewController: UICollectionViewController {

    private let columnController = ColumnController()

    var columns: [Column] = Board.example

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addColumn(_ sender: UIBarButtonItem) {
        let addColumn = columnController.makeAddColumnTableViewController { column in

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
