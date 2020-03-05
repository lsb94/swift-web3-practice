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
        let request: NSFetchRequest<Wallet> = Wallet.fetchRequest()
        let sortByOrder = NSSortDescriptor(key: "order", ascending: true)
        request.sortDescriptors = [sortByOrder]
        
        do {
            walletList = try mainContext.fetch(request)
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
