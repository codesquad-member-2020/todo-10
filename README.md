# todo-10

TODO 웹앱 프로젝트 - 10팀

* BE: [Jay](https://github.com/beginin15)
* FE: [Taek](https://github.com/seungdeng17), [baekCo](https://github.com/baekCode)
* iOS: [Jason](https://github.com/ehgud0670)

## Ground Rule

* [데일리 스크럼 및 회고](https://github.com/codesquad-member-2020/todo-10/wiki/%EB%8D%B0%EC%9D%BC%EB%A6%AC-%EC%8A%A4%ED%81%AC%EB%9F%BC-%EB%B0%8F-%ED%9A%8C%EA%B3%A0)
* 매일 오전 11시 만나서 스크럼하고, 스크럼 이후에 스프레드시트에 백로그(to-do-list)를 작성한다.
* 매일 오후 7시까지 하루 진행 상황을 Wiki로 공유하고, 백로그에서 진행 완료한 항목, 진행 못한 항목을 가려낸다.
* 프로젝트 디렉토리를 Web, Mobile로 나누고 FE, BE는 Web 디렉토리에서 함께 작업

## Branch Rule

* `master`: 배포 브랜치
* `dev`: 디폴트 브랜치
* 작업을 시작할 때: 자신의 클래스 개발 브랜치에서 `feature-<클래스>/issue-<이슈번호>`로 브랜치 생성
  * `feature-<BE>/issueXXX` : 백엔드 피쳐 개발 브랜치
  * `feature-<FE>/issueXXX` : 프론트엔드 피쳐 개발 브랜치
  * `feature-<iOS>/issueXXX` : 모바일 iOS 피쳐 개발 브랜치
* 커밋 메시지에 `Closes #n` 등을 포함시켜 이슈를 닫을 수 있다. 
* 자신의 클래스 피쳐 개발 브랜치에서 작업 후 `dev` 브랜치를 향해 Pull Request를 생성하고 **마스터 리뷰**를 받는다.
  * **머지를 완료했으면 기능(feature)브랜치는 github과 local git에 모두 삭제한다.**
* 팀 프로젝트가 마무리되는 금요일 오후에 `master` 브랜치를 향해 Pull Request을 생성한다.

## Commit Message Rules

[#이슈 번호] 커밋 종류: 커밋 내용(한글)

* feat: The new feature you're adding to a particular application
* fix: A bug fix
* style: Feature and updates related to styling
* refactor: Refactoring a specific section of the codebase
* test: Everything related to testing
* docs: Everything related to documentation
* chore: Regular code maintenance.[You can also use emogjis to represent commit types]

## Issue 및 Pull Request 네이밍 규칙

* Issue 네이밍: [클래스] 제목
* Pull Request 네이밍: [클래스][이슈번호] 제목

## Project Backlog

[백로그 스프레드시트 바로가기](https://docs.google.com/spreadsheets/d/1Sl-0e0Yn5wYYx2IcyoMGC_MMitMFhuW9W1sN1DHI19Q/edit#gid=722419157)

## Mockup API 문서

### 서버 요청 주소 (변경될 수 있음)

ec2-15-164-63-83.ap-northeast-2.compute.amazonaws.com:8080

### 로그인 요청

POST /mock/login

#### 요청 데이터
```
{
    "email": "nigayo@ggmail.com",
    "password": "1234"
}
```

- 현재는 email와 password에 어떤 값을 넣어도 응답을 성공적으로 반환합니다.
- 추후에는 인증된 사용자인 경우 헤더에 JWT를 담아서 보내줄 예정입니다.

#### JSON 응답

- 현재 DB에 아무 데이터가 없는 경우 (최초 접속 시)
```
{
    "status": "SUCCESS",
    "content": {
        "logs": [],
        "sections": [
            {
                "id": 0,
                "title": "해야 할 일",
                "cards": [],
                "createdDateTime": "2020-04-08 21:41:01",
                "updatedDateTime": "2020-04-08 21:41:01"
            },
            {
                "id": 1,
                "title": "하고 있는 일",
                "cards": [],
                "createdDateTime": "2020-04-08 21:41:01",
                "updatedDateTime": "2020-04-08 21:41:01"
            },
            {
                "id": 2,
                "title": "완료한 일",
                "cards": [],
                "createdDateTime": "2020-04-08 21:41:01",
                "updatedDateTime": "2020-04-08 21:41:01"
            }
        ]
    }
}
```

- DB에 데이터가 존재하는 경우
```
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
```
---
### 카드 추가 요청

POST /mock/section/{sectionId}/card

#### 요청 데이터

- 카드 추가 요청 시, URL에 `sectionId`와 Body 데이터를 전달해 합니다.
```
{
    "title": "README.md 추가",
    "content": "구현 API 내용 작성",
}
```

- 프론트에서는 content에 카드 내용을 담아주세요.


#### JSON 응답
```
{
    "status": "SUCCESS",
    "content": {
        "id": 2,
        "title": "README.md 추가",
        "content": "구현 API 내용 작성",
        "createdDateTime": "2020-04-07 15:25:23",
        "updatedDateTime": "2020-04-07 15:25:23"
    }
}
```
---
### 카드 수정 요청

PATCH /mock/section/{sectionId}/card/{id}

#### 요청 데이터

- 수정이 발생하는 Section 아이디와 Card 아이디는 URL에 포함시켜주세요.
- 수정하고 싶은 내용은 Body에 넣어주세요.
```
{
    "title": "일찍 자기",
    "content": "11시",
}
```

#### JSON 응답

- 수정 성공 시 응답
```
{
    "status": "SUCCESS",
    "content": "Card Updated"
}
```

- 수정 실패 시 응답 (잘못된 섹션 아이디값이나 카드값을 URL에 전달하는 경우)
```
{
    "status": "ERROR",
    "content": "Resource Not Found"
}
```
---
### 카드 삭제 요청

DELETE /mock/section/{sectionId}/card/{id}

#### 요청 데이터

- 삭제가 발생하는 Section 아이디와 삭제할 Card 아이디는 URL에 포함시켜주세요.
- Body에는 필요한 데이터가 없습니다.

#### JSON 응답

- 삭제 성공 시 응답
- 삭제가 발생한 Section의 Card 리스트를 반환합니다. (id는 Card의 id를 의미합니다.)
```
{
    "status": "SUCCESS",
    "content": [
        {
            "id": "1"
        },
        {
            "id": "2"
        }
    ]
}
```

- 삭제 실패 시 응답
```
{
    "status": "ERROR",
    "content": "Resource Not Found"
}
```
