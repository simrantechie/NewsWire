//
//  NewsWireWidgetBundle.swift
//  NewsWireWidget
//
//  Created by Simranjeet Kaur on 12/04/24.
//

import WidgetKit
import SwiftUI

@main
struct NewsWireWidgetBundle: WidgetBundle {
    var body: some Widget {
        NewsWireWidgetExtension()
        NewsWireWidgetLiveActivity()
    }
}
