//
//  DeviceCell.swift
//  iVerifyTakeHome
//
//  Created by Seun Olalekan on 2023-10-17.
//

import SwiftUI

struct DeviceCell: View {
    let device: Device
    var body: some View {

        HStack{
            Text("User Name: \(device.name)")
            Text("Device Name: \(device.device)")
            Text("Last Scan Date: \(device.formattedDate)")
        }
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity,alignment: .leading)
        .frame(height: 30)

    }
}

struct DeviceCell_Previews: PreviewProvider {
    static var previews: some View {
        DeviceCell(device: Device(name: "", code: "", latestInsecureScanDate: "", device: ""))
    }
}
