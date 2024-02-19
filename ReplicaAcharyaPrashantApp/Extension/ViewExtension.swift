//
//  ViewExtension.swift
//  ReplicaAcharyaPrashantApp
//
//  Created by Apple on 19/02/24.
//

import Foundation
import SwiftUI

extension View {
    func showAlert(title: String, message: String, isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil) -> some View {
        self.alert(isPresented: isPresented) {
            Alert(
                title: Text(title),
                message: Text(message),
                dismissButton: .default(Text("OK"), action: {
                    onDismiss?() // Call the onDismiss closure if provided
                })
            )
        }
    }
}
