//
//  NotesDelegate.swift
//  PrimeraApp
//
//  Created by s209e011 on 24/02/20.
//  Copyright © 2020 udem. All rights reserved.
//

import Foundation
import CoreData

protocol NotesDelegate {
    func onNoteAdded(note: String)
    func onNoteUpdated(noteId:NSManagedObjectID,noteText: String)
}
