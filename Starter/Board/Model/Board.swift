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
                    .init(content: "Make raisin bread"),
                    .init(content: "Make raisin bread"),
                    .init(content: "Make raisin bread"),
                    .init(content: "Make raisin bread"),
                    .init(content: "Make raisin bread"),
                    .init(content: "Make raisin bread"),
                    .init(content: "Make raisin bread"),
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
