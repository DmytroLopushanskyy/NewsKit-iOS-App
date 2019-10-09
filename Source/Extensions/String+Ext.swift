//
//  String+Ext.swift
//  NewsKit-iOS-App
//
//  Created by Дмитро Лопушанський on 10/7/19.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit

extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
