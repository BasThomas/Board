import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier: String { "card" }

    
    @IBOutlet weak var contentLabel: UILabel!
    
    var card: Card! {
        didSet {
            contentLabel.text = card.content
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        contentLabel.text = nil
    }
}
