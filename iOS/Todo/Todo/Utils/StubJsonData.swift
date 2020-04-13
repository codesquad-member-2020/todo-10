//
//  response.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/08.
//  Copyright © 2020 Jason. All rights reserved.
//

enum StubJsonData {
    static let successColumnsResponseStub = """
    {
      "status" : "SUCCESS",
      "content" : {
        "logs" : [

        ],
        "sections" : [
          {
            "id" : 0,
            "title" : "해야 할 일",
            "cards" : [
              {
                "id" : 2,
                "title" : "",
                "content" : "Taek : add card test #0, section #0",
                "createdDateTime" : "2020-04-09 07:33:44",
                "updatedDateTime" : "2020-04-09 07:33:44"
              },
              {
                "id" : 8,
                "title" : null,
                "content" : "테스트",
                "createdDateTime" : "2020-04-09 07:54:30",
                "updatedDateTime" : "2020-04-09 07:54:30"
              }
            ],
            "createdDateTime" : "2020-04-09 07:32:52",
            "updatedDateTime" : "2020-04-09 07:54:30"
          },
          {
            "id" : 1,
            "title" : "하고 있는 일",
            "cards" : [
              {
                "id" : 3,
                "title" : "",
                "content" : "Taek : add card test #0, section #1",
                "createdDateTime" : "2020-04-09 07:33:44",
                "updatedDateTime" : "2020-04-09 07:33:44"
              },
              {
                "id" : 6,
                "title" : "",
                "content" : "Taek : add card test #1, section #1",
                "createdDateTime" : "2020-04-09 07:33:44",
                "updatedDateTime" : "2020-04-09 07:33:44"
              }
            ],
            "createdDateTime" : "2020-04-09 07:32:52",
            "updatedDateTime" : "2020-04-09 07:33:44"
          },
          {
            "id" : 2,
            "title" : "완료한 일",
            "cards" : [
              {
                "id" : 4,
                "title" : "",
                "content" : "Taek : add card test #0, section #2",
                "createdDateTime" : "2020-04-09 07:33:44",
                "updatedDateTime" : "2020-04-09 07:33:44"
              },
              {
                "id" : 5,
                "title" : "",
                "content" : "Taek : add card test #1, section #2",
                "createdDateTime" : "2020-04-09 07:33:44",
                "updatedDateTime" : "2020-04-09 07:33:44"
              }
            ],
            "createdDateTime" : "2020-04-09 07:32:52",
            "updatedDateTime" : "2020-04-09 07:33:44"
          }
        ]
      }
    }
    """.data(using: .utf8)
    
    static let successDeleteResponseStub = """
    {
        "status" : "SUCCESS",
        "content" : "Card is Successfully Deleted"
    }
    """.data(using: .utf8)
    
    static let successCreateResponseStub = """
    {
        "status": "SUCCESS",
        "content": {
        "id": \(Int.max),
            "title": "성공 생성 응답 스텁",
            "content": "성공 생성 응답 스텁",
            "createdDateTime": "2020-04-07 15:25:23",
            "updatedDateTime": "2020-04-07 15:25:23"
        }
    }
    """.data(using: .utf8)
    
    static let successEditingResponseStub = """
    {
        "status": "SUCCESS",
        "content": "Card Updated"
    }
    """.data(using: .utf8)
}
