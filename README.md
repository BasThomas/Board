# Board

![board](https://user-images.githubusercontent.com/4190298/66703486-708d9800-ed13-11e9-8907-8e87c8179339.png)

A gave a classroom/workshop with this project at [FrenchKit](https://frenchkit.fr)
2019. Before starting it, I gave [this introduction](https://speakerdeck.com/basthomas/an-introduction-to-ipados-workshop-5b614f1f-aef8-4aaf-b724-fd7d6695acf1)
that introduces iPadOS multi-window support. This is also the topic of this
workshop.

### ... and now what?

Although it may be hard to follow this without doing an in-person workshop,
below you will find the steps we went through, including some words of advice
and my thoughts, so you can take on this project yourself. If you do, let me
know how it goes!

Of course, you're supposed to start with the [`Starter`](/Starter/) project
and go from there!

## Adding support for multiple windows

We'll need to tell our application that we want to support multiple windows.
To do so, go to the `Info.plist` and add the required configuration.

<details>
<summary>Step 1</summary>

```plist
<key>UIApplicationSceneManifest</key>
<dict>
    <key>UIApplicationSupportsMultipleScenes</key>
    <true/>
    <key>UISceneConfigurations</key>
    <dict>
        <key>UIWindowSceneSessionRoleApplication</key>
        <array>
            <dict>
                <key>UISceneConfigurationName</key>
                <string>Default Configuration</string>
                <key>UISceneDelegateClassName</key>
                <string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
                <key>UISceneStoryboardFile</key>
                <string>Main</string>
            </dict>
        </array>
    </dict>
</dict>
```
</details>

Now that we have the initial setup for the `Info.plist`, we need to create our
[`SceneDelegate`](https://developer.apple.com/documentation/uikit/uiscenedelegate) class.

<details>
<summary>Step 2</summary>

```swift
// SceneDelegate.swift
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
}
```
</details>

Now that we have that setup, we'll need to add a non-default scene
configuration. This will be showing our card, rather than our "default" app
scene.

<details>
<summary>Step 3</summary>

Add the following within the `UIWindowSceneSessionRoleApplication` array:

```plist
<dict>
    <key>UISceneConfigurationName</key>
    <string>Card Configuration</string>
    <key>UISceneDelegateClassName</key>
    <string>$(PRODUCT_MODULE_NAME).CardSceneDelegate</string>
    <key>UISceneStoryboardFile</key>
    <string>Card</string>
</dict>
```
</details>

Great! Now, we'll use [`NSUserActivity`](https://developer.apple.com/documentation/foundation/nsuseractivity)
to be able to create our newly created configuration.

<details>
<summary>Step 4</summary>

```swift
// in Card.swift
static let userActivityType = "fr.frenchkit.card"
static let userActivityTitle = "showCardDetail"
var userActivity: NSUserActivity {
    let userActivity = NSUserActivity(activityType: Card.userActivityType)
    userActivity.title = Card.userActivityTitle
    userActivity.userInfo = [
        "content": content
    ]
    return userActivity
}
```
</details>

... and set up all the magic in a new `SceneDelegate`; namely our just created
`CardSceneDelegate`.

<details>
<summary>Step 5</summary>

```swift
// in CardSceneDelegate.swift
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
```
</details>

To make sure the app knows which user activities to listen to, we'll need to
make one more edit to the `Info.plist`.

<details>
<summary>Step 6</summary>

```plist
<key>NSUserActivityTypes</key>
<array>
    <string>fr.frenchkit.card</string>
</array>
```
</details>

Almost there, almost there. We'll add [drag and drop](https://developer.apple.com/ios/drag-and-drop/)
support, which works very nicely with the configurations we created, allowing
for an intuitive way to create the new session.

<details>
<summary>Step 7</summary>

```swift
// in BoardCollectionViewController
override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dragDelegate = self
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
```
</details>

And for the grand finale, we'll make sure our application handles which
configuration to connect to, and when.

<details>
<summary>Step 8</summary>

```swift
// in AppDelegate.swift
func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    let configurationName: String
    if options.userActivities.first?.activityType == Card.userActivityType {
        configurationName = "Card Configuration"
    } else {
        configurationName = "Default Configuration"
    }
    return .init(name: configurationName, sessionRole: connectingSceneSession.role)
}
```
</details>

Build and run. You can now drag a card and drop it at the screen edge to create
a new scene. 🎉

One more thing... the new scene has a close button, but it doesn't do anything.
Let's hook that up.

<details>
<summary>Step 9</summary>

```swift
// in CardViewController.swift
@IBAction func close(_ sender: Any) {
    guard let session = view.window?.windowScene?.session else { fatalError("No session found for this view controller") }
    let options = UIWindowSceneDestructionRequestOptions()
    options.windowDismissalAnimation = .default
    application.requestSceneSessionDestruction(session, options: options)
}
```
</details>

## Where to go from here?

Go wild! There's lots more to look into. Data syncing, supporting drag and drop
for the "Add Column" screen (and a configuration!), refreshing outdated
sessions, preventing duplicate sessions from being created... the list goes on.
