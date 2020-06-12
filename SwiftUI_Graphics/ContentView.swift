//
//  ContentView.swift
//  SwiftUI_Graphics
//
//  Created by Luiza Fattori on 10/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GraphView(color: .gray,
                  [
                    AxisComponent(subtitle: "Mundiais", max: 3.5),
                    AxisComponent(subtitle: "Libertadores", max: 3.5),
                    AxisComponent(subtitle: "BR-B", max: 2.5),
                    AxisComponent(subtitle: "Outro", max: 2.5)
            ],
                  [
                    GraphElement(subtitle: "São Paulo", values: [3, 3, 0], color: .red),
                    GraphElement(subtitle: "Palmeiras", values: [0, 1, 2], color: .green),
                    GraphElement(subtitle: "Corithians", values: [2, 1, 1], color: .gray),
        ])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView().previewLayout(.fixed(width: 568, height: 500))
        }

    }
}
