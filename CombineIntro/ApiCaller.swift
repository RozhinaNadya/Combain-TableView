//
//  ApiCaller.swift
//  CombineIntro
//
//  Created by Надежда on 2022-07-22.
//

import Foundation
import UIKit
import Combine

class ApiCaller {
    static let shered = ApiCaller()
    
    func fetchData() -> Future<[String], Error> {
        return Future { promix in
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                promix(.success(["Apple", "Google", "Microsoft", "Facebook"]))
            }
        }
    }
}
