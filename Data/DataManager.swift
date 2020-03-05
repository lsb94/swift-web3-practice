//
//  DataManager.swift
//  AppLaunchTest
//
//  Created by dave lee on 2020/03/05.
//  Copyright © 2020 dave lee. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    static let shared = DataManager()
    private init() {
        
    }
    
    var mainContext : NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var walletList = [Wallet]()
    
    func fetchWallet() {
        let requestWallet: NSFetchRequest<Wallet> = Wallet.fetchRequest()
        let sortByOrder = NSSortDescriptor(key: "order", ascending: true)
        requestWallet.sortDescriptors = [sortByOrder]
        
        do {
            walletList = try mainContext.fetch(requestWallet)
        }catch {
            print(error)
        }
    }
    
    func addNewWallet (_ addressEIP: String) {
        let newMemo = Wallet(context: mainContext)
        newMemo.address = addressEIP
        newMemo.order = String(walletList.count + 1)
        saveContext()
    }
    
    var tokenList = [Token]()
    
    func fetchToken() {
        let requestToken: NSFetchRequest<Token> = Token.fetchRequest()
        let sortByBalance = NSSortDescriptor(key: "balance", ascending: false)
        requestToken.sortDescriptors = [sortByBalance]

        do {
            tokenList = try mainContext.fetch(requestToken)
        }catch {
            print(error)
        }
    }

    func addNewToken (addressEIP: String, symbol: String, decimal: Decimal, Balance: String) {
        let newToken = Token(context: mainContext)
        newToken.address = addressEIP
        newToken.symbol = symbol
        newToken.decimal = decimal as NSDecimalNumber
        newToken.balance = Balance
        saveContext()
    }

    
    lazy var persistentContainer: NSPersistentContainer = {
           let container = NSPersistentContainer(name: "AppLaunchTest")
           container.loadPersistentStores(completionHandler: { (storeDescription, error) in
               if let error = error as NSError? {
                   fatalError("Unresolved error \(error), \(error.userInfo)")
               }
           })
           return container
       }()
    
    
       // MARK: - Core Data Saving support

       func saveContext () {
           let context = persistentContainer.viewContext
           if context.hasChanges {
               do {
                   try context.save()
               } catch {
                   let nserror = error as NSError
                   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               }
           }
       }

}
