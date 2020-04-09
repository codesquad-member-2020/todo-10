//
//  response.swift
//  Todo
//
//  Created by kimdo2297 on 2020/04/08.
//  Copyright © 2020 Jason. All rights reserved.
//

enum StubJsonData {
    static let successResponseStub = """
    {
        "status": "SUCCESS",
        "content": {
            "sections": [
                {
                    "id": "1",
                    "title": "해야 할 일",
                    "cards": [
                        {
                            "id": "3",
                            "title": "제목3",
                            "content": "내용1 출력됩니다."
                        },
                        {
                            "id": "4",
                            "title": "제목22",
                            "content": "내용2 출력됩니다."
                        }
                    ]
                },
                {
                    "id": "2",
                    "title": "하고 있는 일",
                    "cards": [
                        {
                            "id": "3",
                            "title": "제목1",
                            "content": "내용3 출력됩니다."
                        },
                        {
                            "id": "4",
                            "title": null,
                            "content": "내용5 출력됩니다."
                        },
                        {
                            "id": "3",
                            "title": "제목3",
                            "content": "내용6 출력됩니다."
                        },
                        {
                            "id": "4",
                            "title": null,
                            "content": "내용4 출력됩니다."
                        },
                        {
                            "id": "3",
                            "title": null,
                            "content": "내용3 출력됩니다."
                        }
                    ]
                },
                {
                    "id": "3",
                    "title": "완료 된 일",
                    "cards": [
                        {
                            "id": "5",
                            "title": "제목9",
                            "content": "내용5 출력됩니다."
                        },
                        {
                            "id": "6",
                            "title": null,
                            "content": "내용1 출력됩니다."
                        }
                    ]
                }
            ],
            "logs": [
                {
                    "action": "moved",
                    "card": "github 공부하기",
                    "source": "해야 할 일",
                    "destination": "완료 된 일",
                    "createdDateTime": "2020-03-02"
                },
                {
                    "action": "updated",
                    "card": "스켈레톤 작성",
                    "source": null,
                    "destination": null,
                    "createdDateTime": "2020-03-05"
                },
                {
                    "action": "added",
                    "card": "데모 환경 구성",
                    "source": null,
                    "destination": "하고 있는 일",
                    "createdDateTime": "2020-04-11"
                },
                {
                    "action": "removed",
                    "card": "README.md 수정",
                    "source": "해야 할 일",
                    "destination": null,
                    "createdDateTime": "2020-03-24"
                }
            ]
        }
    }
    """.data(using: .utf8)
}
