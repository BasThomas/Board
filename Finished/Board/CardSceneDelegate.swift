import UIKit

class CardSceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        return scene.userActivity
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let userActivity = connectionOptions.userActivities.first ?? session.stateRestorationActivity else { return }
        if !configure(window: window, with: userActivity) {
            print("Failed to restore from \(userActivity)")
        }
    }

    func configure(window: UIWindow?, with activity: NSUserActivity) -> Bool {
        guard activity.title == Card.userActivityTitle else { return false }
        guard
            let content = activity.userInfo?["content"] as? String else { fatalError("Could not get valid user info from activity") }

        let controller = UIStoryboard(name: "Card", bundle: .main)
            .instantiateViewController(identifier: CardViewController.identifier) as! CardViewController
        controller.card = Card(content: content)

        window?.rootViewController = controller
        return true
    }
}
