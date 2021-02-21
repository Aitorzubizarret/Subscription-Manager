//
//  RoundCorners.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 31/10/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

///
/// For custom round corners.
///
struct RoundedCorners: Shape {
    
    var upperLeft: CGFloat = 0.0
    var upperRight: CGFloat = 0.0
    var lowerLeft: CGFloat = 0.0
    var lowerRigth: CGFloat = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width: CGFloat = rect.size.width
        let height : CGFloat = rect.size.height
        
        let upperLeft = min(min(self.upperLeft, height / 2), width / 2)
        let upperRight = min(min(self.upperRight, height / 2), width / 2)
        let lowerLeft = min(min(self.lowerLeft, height / 2), width / 2)
        let lowerRigth = min(min(self.lowerRigth, height / 2), width / 2)
        
        path.move(to: CGPoint(x: width / 2.0, y: 0))
        path.addLine(to: CGPoint(x: width - upperRight, y: 0))
        path.addArc(center: CGPoint(x: width - upperRight, y: upperRight), radius: upperRight,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)

        path.addLine(to: CGPoint(x: width, y: height - lowerRigth))
        path.addArc(center: CGPoint(x: width - lowerRigth, y: height - lowerRigth), radius: lowerRigth,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

        path.addLine(to: CGPoint(x: lowerLeft, y: height))
        path.addArc(center: CGPoint(x: lowerLeft, y: height - lowerLeft), radius: lowerLeft,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

        path.addLine(to: CGPoint(x: 0, y: upperLeft))
        path.addArc(center: CGPoint(x: upperLeft, y: upperLeft), radius: upperLeft,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

        return path
    }
}
