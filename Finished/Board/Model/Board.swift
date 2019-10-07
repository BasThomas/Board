import Foundation

enum Board {
    static var example: [Column] {
        [
            .init(
                cards: [
                    .init(content: "Do the laundry"),
                    .init(content: "Go cycling"),
                    .init(content: "Go to a bakery"),
                    .init(content: "Support iPadOS features"),
                    .init(content: "Make raisin bread"),
                    .init(content: "Read a book"),
                    .init(content: "Contribute to open source"),
                    .init(content: "Fix that one bug (you know which one)"),
                    .init(content: "Looking into PencilKit"),
                    .init(content: "Synchronize all our data"),
                    .init(content: "Plan the next conference visit"),
                    .init(content: "Throw a party!"),
                ]
            ),
            .init(
                cards: [
                    .init(content: "Book the hotel"),
                    .init(content: "Book the plane ticket for FrenchKit"),
                    .init(content: "Support iOS 13 and Dark Mode"),
                ]
            )
        ]
    }
}
