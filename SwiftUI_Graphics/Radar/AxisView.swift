//
//  AxisView.swift
//  SwiftUI_Graphics
//
//  Created by Leonardo Oliveira on 11/06/20.
//  Copyright © 2020 Luiza Fattori. All rights reserved.
//

import SwiftUI

struct AxisView: View {
    
    var color: Color
    var components: [AxisComponent]
    @State var center: CGPoint = .zero
    let axisRadius: Double = 150
    
    var degreeInterval: Double {
        return (Double.pi * 2) / Double(components.count)
    }
    
    init(color: Color = .random(), _ components: AxisComponent...) {
        self.components = components
        self.color = color
    }
    
    func findPoint(_ value: Double, in axis: AxisComponent) -> CGPoint? {
        if let index = components.firstIndex(of: axis) {
            
            let radius = (value / axis.scale.upperBound - axis.scale.lowerBound) * axisRadius
            let radians = (Double(index) + 1) * degreeInterval
            
            return center.findPointIn(radius: radius, radians: radians)
        }
        
        return nil
        
    }
    
    var body: some View {
        
        GeometryReader { geoProxy in
            
            ForEach(0 ..< self.components.count) { (index) in
                
                ZStack {
                    
                    LineView(color: self.color) { () -> [CGPoint] in
                        self.center = geoProxy.center()

                        let interval = self.degreeInterval * Double(index + 1)
                
                        let nextPoint = self.center.findPointIn(radius: self.axisRadius, radians: interval)
                        
                        return [self.center, nextPoint]
                    }

                    Text("\(self.components[index].subtitle)")
                        .modifier(SubtitleInGeoProxyModifier(geoProxy, radians: self.degreeInterval*Double(index+1)))
                }
            }
        }
    }
}

struct SubtitleInGeoProxyModifier: ViewModifier {
    var geoProxy: GeometryProxy
    var radians: Double
    init(_ geoProxy: GeometryProxy, radians: Double) {
        self.geoProxy = geoProxy
        self.radians = radians
    }
    func body(content: Content) -> some View{
        content.position(geoProxy.center().findPointIn(radius: 175, radians: self.radians))
    }
    
}

struct AxisView_Previews: PreviewProvider {
    static var previews: some View {
        AxisView(
            AxisComponent(subtitle: "A", scale: 0.0...10.0),
            AxisComponent(subtitle: "B", scale: 15.0...17.0),
            AxisComponent(subtitle: "C", scale: 0.5...60.7)
        )
    }
}
