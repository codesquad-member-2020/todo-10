//
//  response.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/08.
//  Copyright © 2020 Jason. All rights reserved.
//

enum StubJsonData {
    static let successLoginResponseStub = """
    {
        "status": "SUCCESS",
        "content": "로그인 성공"
    }
    """
    
    static let successColumnsResponseStub = """
    {
        "status": "SUCCESS",
        "content": [
            {
                "id": 1,
                "title": "해야할 일",
                "createDateTime": "2020-04-15 03:12:00",
                "updateDateTime": "2020-04-15 03:12:00",
                "cards": [
                    {
                        "id": 1,
                        "title": "README.md 추가",
                        "content": "구현 API 내용 작성",
                        "createDateTime": "2020-04-15 03:12:32",
                        "updateDateTime": "2020-04-15 03:13:00",
                        "author": "nigayo"
                    }
                ]
            },
            {
                "id": 2,
                "title": "하고 있는 일",
                "createDateTime": "2020-04-15 03:12:00",
                "updateDateTime": "2020-04-15 03:12:00",
                "cards": []
            },
            {
                "id": 3,
                "title": "완료된 일",
                "createDateTime": "2020-04-15 03:12:00",
                "updateDateTime": "2020-04-15 03:12:00",
                "cards": []
            }
        ]
    }
    """.data(using: .utf8)
    
    static let successCreateResponseStub = """
    {
        "status": "SUCCESS",
        "content": {
            "log_id": 2,
            "card_count": 2,
            "card": {
                "id": 2,
                "title": "회고",
                "content": "회고하자",
                "createDateTime": "2020-04-15 03:12:32",
                "updateDateTime": "2020-04-15 03:12:32",
                "author": "nigayo"
            }
        }
    }
    """.data(using: .utf8)
    
    static let successEditingResponseStub = """
    {
        "status": "SUCCESS",
        "content": {
            "log_id": 2,
            "card_count": 1,
            "card": {
                "id": 1,
                "title": "README.md 추가 안함",
                "content": "구현 API 내용 작성 안함",
                "createDateTime": "2020-04-15 03:12:32",
                "updateDateTime": "2020-04-15 03:13:00",
                "author": "nigayo"
            }
        }
    }
    """.data(using: .utf8)
    
    static let successDeleteResponseStub = """
    {
        "status": "SUCCESS",
        "content": {
            "log_id": 4,
            "card_count": 1
        }
    }
    """.data(using: .utf8)
    
    static let successMoveSameColumnsResponseStub = """
    {
        "status": "SUCCESS",
        "content": {
            "log_id": 7,
            "card_count_to_section": null,
            "card_count_from_section": 3
        }
    }
    """.data(using: .utf8)
    
    static let successMoveDifferentColumnsResponseStub = """
    {
        "status": "SUCCESS",
        "content": {
            "log_id": 5,
            "card_count_to_section": 1,
            "card_count_from_section": 3
        }
    }
    """.data(using: .utf8)
    
    static let successLogsResponseStub = """
    {
        "status": "SUCCESS",
        "content": [
            {
                "id": 1,
                "user": "nigayo",
                "action": "ADDED",
                "target": "CARD",
                "title": null,
                "content": "과자 사기",
                "source": null,
                "destination": "해야할 일",
                "createDateTime": "2020-04-15 16:15:11"
            },
            {
                "id": 2,
                "user": "nigayo",
                "action": "REMOVED",
                "target": "CARD",
                "title": null,
                "content": "나는 다 할 수 있다, 다 할 것이다",
                "source": "해야할 일",
                "destination": null,
                "createDateTime": "2020-04-15 16:15:20"
            },
            {
                "id": 3,
                "user": "nigayo",
                "action": "UPDATED",
                "target": "CARD",
                "title": "공부하기",
                "content": "음료 사기",
                "source": null,
                "destination": null,
                "createDateTime": "2020-04-15 16:15:41"
            },
            {
                "id": 4,
                "user": "nigayo",
                "action": "MOVED",
                "target": "CARD",
                "title": null,
                "content": "hellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohello",
                "source": "하고있는 일",
                "destination": "해야할 일",
                "createDateTime": "2020-04-15 16:30:20"
            },
            {
                "id": 5,
                "user": "nigayo",
                "action": "MOVED",
                "target": "CARD",
                "title": null,
                "content": "음료 사기",
                "source": "해야 할 일",
                "destination": null,
                "createDateTime": "2020-04-15 16:40:11"
            }
        ]
    }
    """.data(using: .utf8)
    
    static let successLogResponseStub = """
    {
        "status": "SUCCESS",
        "content": {
            "id": 1,
            "user": "nigayo",
            "action": "ADDED",
            "target": "CARD",
            "title": null,
            "content": "자바 공부",
            "source": null,
            "destination": "하고 있는 일",
            "createDateTime": "2020-04-15 20:35:13"
        }
    }
    """.data(using: .utf8)
    
    static let successLoginResponse = """
    {
       "status": "SUCCESS",
       "content": ""
    }
    """.data(using: .utf8)
}
