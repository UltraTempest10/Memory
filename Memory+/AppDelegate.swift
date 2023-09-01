//
//  AppDelegate.swift
//  Memory+
//
//  Created by UltraTempest on 2023/6/10.
//

import UIKit
import SwiftUI
import Parse
//import StreamChat
//import StreamChatSwiftUI

//extension ChatClient {
//    static var shared: ChatClient!
//}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var window: UIWindow?

//    // This is the `StreamChat` reference we need to add
//    var streamChat: StreamChat?
//
//    // This is the `chatClient`, with config we need to add
//    var chatClient: ChatClient = {
//        //For the tutorial we use a hard coded api key and application group identifier
//        var config = ChatClientConfig(apiKey: .init("rm6za35v3vn8"))
//        config.applicationGroupIdentifier = "group.io.getstream.iOS.ChatDemoAppSwiftUI"
//
//        // The resulting config is passed into a new `ChatClient` instance.
//        let client = ChatClient(config: config)
//        return client
//    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let parseConfig = ParseClientConfiguration {
            $0.applicationId = "SpDBPyZ5jmn5WjiiDVoS93LU9JIC8BkxK5nZmjUb"
            $0.clientKey = "wr8cuWx7v4XnUAtaPhxFcQJBu8Qs0crCDcQA5W9F"
            $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: parseConfig)
        
//        streamChat = StreamChat(chatClient: chatClient)
//
//        // Calling the `connectUser` functions
//        connectUser()
        
        //Load data from database.
        loadProfileData()
        loadMusicData()
        
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Use a UIHostingController as window root view controller.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: contentView)
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
    
//    // The `connectUser` function we need to add.
//    private func connectUser() {
//        // This is a hardcoded token valid on Stream's tutorial environment.
//        let token = try! Token(rawValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiWFRQIn0.k89QfCw2uBVC6FEwvxuuDM4YGEYNrcpAp9DdVr5utPU")
//
//        // Call `connectUser` on our SDK to get started.
//        chatClient.connectUser(
//            userInfo: .init(id: "XTP",
//                            name: "cheng",
//                            imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/2/20/LukeTLJ.jpg")!),
//            token: token
//        ) { error in
//            if let error = error {
//                // Some very basic error handling only logging the error.
//                log.error("connecting the user failed \(error)")
//                return
//            }
//        }
//    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }


}

