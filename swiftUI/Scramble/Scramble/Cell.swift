//
//  Cell.swift
//  Scramble
//
//  Created by Mustafa Khalil on 12/19/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import SwiftUI

struct Cell: View {
    var name: String
    var count: Int
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
            Text(name)
        }
    }
    
    var imageName: String {
        return "\(count).circle"
    }
}
