//
//  TicketsAPI.swift
//  tayler
//
//  Created by 서은수 on 2022/08/21.
//

import Foundation
import Alamofire

// Response의 형태.
struct TicketModel : Decodable {
    var host: String?
    var paperName: String?
    var owner: String?
    var price: String?
    var Paper: [PaperResult]
    var pagination: paginationResult
}

struct PaperResult : Decodable {
    var creator: String?
    var id: String?
    var host: String?
    var paperName: String?
    var owner: String?
    var price: String?
}

struct paginationResult : Decodable {
    var next_key: String?
    var total: String?
}

// 티켓 Papers API 연동
class TicketsAPI {
    public static func requestPapers(_ viewController: HomeViewController) {
        let url = "http://10.200.89.28:1317/paper/paper/papers"
        AF.request(url, method: .get,
                   parameters: nil, headers: nil)
        .validate()
        .responseDecodable(of: TicketModel.self) { response in
            switch response.result {
            case .success(let result):
                print("NETWORK: Papers 불러오기 성공")
                for i in 0...5 {
                    viewController.contentsArray[i].id = result.Paper[i].id
                    viewController.contentsArray[i].title = result.Paper[i].paperName
                }
            case .failure(let error):
                print("DEBUG:", error.localizedDescription)
            }
        }
    }
}
