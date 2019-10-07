import Foundation

struct Card: Hashable {
    let content: String

    static let userActivityType = "nl.basbroek.card"
    static let userActivityTitle = "showCardDetail"
    var userActivity: NSUserActivity {
        let userActivity = NSUserActivity(activityType: Card.userActivityType)
        userActivity.title = Card.userActivityTitle
        userActivity.userInfo = [
            "content": content
        ]
        return userActivity
    }
}
