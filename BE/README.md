# TODO API

## 서버 요청 주소 (변경될 수 있음)

http://ec2-15-164-63-83.ap-northeast-2.compute.amazonaws.com:8080

## 로그인 요청

#### POST `/board/login`

### 요청 데이터
```
{
    "name": "nigayo",
    "password": "1234"
}
```
- 현재는 name password에 어떤 값을 넣어도 응답을 성공적으로 반환합니다.
- 추후에는 인증된 사용자인 경우 헤더에 JWT를 담아서 보내줄 예정입니다.

### JSON 응답
- 로그인 성공
   - 상태 코드 : OK (200)
```
{
    "status": "SUCCESS",
    "content": "로그인 성공"
}
```

- 로그인 실패
   - 상태 코드 : UNAUTHORIZED (401)
```
{
    "status": "ERROR",
    "content": "로그인 실패"
}
```

## 보드 내용 요청

### GET `/board`

### 요청 데이터
- 로그인하고 발급받은 토큰을 Authorization 헤더에 넣어서 요청 해주세요.

### JSON 응답
- 성공적으로 반환하는 경우
   - 상태 코드 : OK (200)
```
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
```
- 실패한 경우
   - 상태 코드 : FORBIDDEN (400)
```
{
    "status": "ERROR",
    "content": "접근 금지"
}
```

## 카드 추가 요청

#### POST `/board/section/{sectionId}/card`

### 요청 데이터
```
{
    "title": "README.md 추가",
    "content": "구현 API 내용 작성",
}
```
- 카드 추가 요청 시, URL에 sectionId와 Body 데이터를 전달해야 합니다.
- 프론트에서는 content에 카드 내용을 담아주세요.
- 로그인하고 발급받은 토큰을 Authorization 헤더에 넣어서 요청 해주세요.

### JSON 응답
- 성공적으로 반환하는 경우
   - 상태 코드 : OK (200)
```
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
```
- 실패한 경우
   - 상태 코드 : FORBIDDEN (400)
   - 토큰이 인증되지 않은 경우
```
{
    "status": "ERROR",
    "content": "접근 금지"
}
```

## 카드 수정 요청

#### PATCH `/board/section/{sectionId}/card/{cardId}`

### 요청 데이터
```
{
    "title": "README.md 추가 안함",
    "content": "구현 API 내용 작성 안함",
}
```
- 카드 수정 요청 시, URL에 sectionId와 cardId를 전달해야 합니다.
- Body에는 변경하고자 하는 데이터(title, content)를 함께 보냅니다.
- 프론트에서는 content에 변경될 카드 내용을 담아주세요.
- 로그인하고 발급받은 토큰을 Authorization 헤더에 넣어서 요청 해주세요.

### JSON 응답

- 성공적으로 반환하는 경우
   - 상태 코드 : OK (200)
```
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
```

- 실패한 경우 1
   - 상태 코드 : Not Found (404)
   - 존재하지 않는 sectionId나 cardId를 전달하는 경우
   - 섹션에 존재하지 않는 cardIndex를 전달하는 경우
```
{
    "status": "ERROR",
    "content": "리소스를 찾을 수 없습니다."
}
```

- 실패한 경우 2
   - 상태 코드 : Bad Request (400)
   - Body에 필요한 데이터를 포함하지 않은 경우
```
{
    "status": "ERROR",
    "content": "요청 데이터가 충족하지 않습니다."
}
```

- 실패한 경우 3
   - 상태 코드 : FORBIDDEN (400)
   - 토큰이 인증되지 않은 경우
```
{
    "status": "ERROR",
    "content": "접근 금지"
}
```

## 카드 삭제 요청

#### DELETE `/board/section/{sectionId}/card/{cardId}`

### 요청 데이터
- 로그인하고 발급받은 토큰을 Authorization 헤더에 넣어서 요청 해주세요.

### JSON 응답
- 성공적으로 반환하는 경우
   - 상태 코드 : OK (200)
```
{
    "status": "SUCCESS",
    "content": {
        "log_id": 4,
        "card_count": 1
    }
}
```

- 실패한 경우 1
   - 상태 코드 : Not Found (404)
   - 존재하지 않는 sectionId나 cardId를 전달하는 경우
```
{
    "status": "ERROR",
    "content": "리소스를 찾을 수 없습니다."
}
```

- 실패한 경우 2
   - 상태 코드 : Bad Request (400)
   - 전달한 sectionId에 포함된 cardId가 아닌 경우 (즉, 다른 섹션에 존재하는 cardId인 경우)
   - 전달한 sectionId에 카드가 존재하지 않는 경우
```
{
    "status": "ERROR",
    "content": "요청 데이터가 서버와 일치하지 않습니다."
}
```

- 실패한 경우 3
   - 상태 코드 : FORBIDDEN (400)
   - 토큰이 인증되지 않은 경우
```
{
    "status": "ERROR",
    "content": "접근 금지"
}
```

## 카드 이동 요청 (동일 섹션 내)

#### PUT `/board/section/{sectionId}/card/{cardId}?cardTo={newIndex}`
- `newIndex` : 현재 섹션 내 이동하고자 하는 위치 인덱스 (0부터 시작)

### 요청 데이터
- 로그인하고 발급받은 토큰을 Authorization 헤더에 넣어서 요청 해주세요.

### JSON 응답
- 성공적으로 반환하는 경우
   - 상태 코드 : OK (200)
```
{
    "status": "SUCCESS",
    "content": {
        "log_id": 7,
        "card_count_to_section": null,
        "card_count_from_section": 3
    }
}
```

- 실패한 경우 1
   - 상태 코드 : Not Found (404)
   - 존재하지 않는 sectionId나 cardId를 전달하는 경우
```
{
    "status": "ERROR",
    "content": "리소스를 찾을 수 없습니다."
}
```

- 실패한 경우 2
   - 상태 코드 : Bad Request (400)
   - 전달한 sectionId에 포함된 cardId가 아닌 경우 (즉, 다른 섹션에 존재하는 cardId인 경우)
   - 전달한 sectionId에 카드가 존재하지 않는 경우
   - 잘못된 newIndex를 전달하는 경우 (현재 섹션 개수를 넘어가는 인덱스 등)
```
{
    "status": "ERROR",
    "content": "요청 데이터가 서버와 일치하지 않습니다."
}
```

- 실패한 경우 3
   - 상태 코드 : Bad Request (400)
   - 카드가 이동하지 않고 제자리에 놓인 경우
```
{
    "status": "ERROR",
    "content": "카드 이동 무효"
}
```

- 실패한 경우 4
   - 상태 코드 : FORBIDDEN (400)
   - 토큰이 인증되지 않은 경우
```
{
    "status": "ERROR",
    "content": "접근 금지"
}
```

## 카드 이동 요청 (다른 섹션으로 이동)

#### PUT `/board/section/{sectionId}/card/{cardId}?cardTo={newIndex}&sectionTo={newSectionId}`
- `newIndex` : 새로운 섹션 내 이동하고자 하는 위치 인덱스 (0부터 시작)
- `newSectionId` : 새로운 섹션의 아이디 (인덱스 아님)

### 요청 데이터
- 로그인하고 발급받은 토큰을 Authorization 헤더에 넣어서 요청 해주세요.

### JSON 응답
- 성공적으로 반환하는 경우
   - 상태 코드 : OK (200)
```
{
    "status": "SUCCESS",
    "content": {
        "log_id": 5,
        "card_count_to_section": 1,
        "card_count_from_section": 3
    }
}
```

- 실패한 경우 1
   - 상태 코드 : Not Found (404)
   - 존재하지 않는 sectionId나 cardId를 전달하는 경우
```
{
    "status": "ERROR",
    "content": "리소스를 찾을 수 없습니다."
}
```

- 실패한 경우 2
   - 상태 코드 : Bad Request (400)
   - 전달한 sectionId에 포함된 cardId가 아닌 경우 (즉, 다른 섹션에 존재하는 cardId인 경우)
   - 전달한 sectionId에 카드가 존재하지 않는 경우
   - 잘못된 newIndex를 전달하는 경우 (현재 섹션의 개수를 넘어가는 인덱스 등)
```
{
    "status": "ERROR",
    "content": "요청 데이터가 서버와 일치하지 않습니다."
}
```

- 실패한 경우 3
   - 상태 코드 : Bad Request (400)
   - sectionId와 sectionTo가 동일한 경우 (동일한 섹션 아이디인 경우)
```
{
    "status": "ERROR",
    "content": "카드 이동 무효"
}
```

- 실패한 경우 4
   - 토큰이 인증되지 않은 경우
   - 상태 코드 : FORBIDDEN (400)
```
{
    "status": "ERROR",
    "content": "접근 금지"
}
```

## 섹션 추가 요청

#### POST `/board/section`

### 요청 데이터
- 로그인하고 발급받은 토큰을 Authorization 헤더에 넣어서 요청 해주세요.
- Body에 생성하고자 하는 섹션의 title을 함께 전달해주세요.
```
{
    "title": "나머지"
}
```

### JSON 응답
- 성공적으로 반환하는 경우
   - 상태 코드 : OK (200)
```
{
    "status": "SUCCESS",
    "content": {
        "log_id": 1,
        "section": {
            "id": 4,
            "title": "추가 섹션",
            "createDateTime": "2020-04-18 00:56:38",
            "updateDateTime": "2020-04-18 00:56:38",
            "cards": []
        }
    }
}
```

## 섹션 삭제 요청

#### DELETE `/board/section/{sectionId}`

### 요청 데이터
- 로그인하고 발급받은 토큰을 Authorization 헤더에 넣어서 요청 해주세요.

### JSON 응답
- 성공적으로 반환하는 경우
   - 상태 코드 : OK (200)
```
{
    "status": "SUCCESS",
    "content": {
        "log_id": 4
    }
}
```

## 전체 로그 요청

#### GET `/board/logs`

### 요청 데이터
- 로그인하고 발급받은 토큰을 Authorization 헤더에 넣어서 요청 해주세요.

### JSON 응답

- 성공적으로 반환하는 경우
   - 상태 코드 : OK (200)
```
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
            "action": "UPDATED",
            "target": "CARD",
            "title": null,
            "content": "음료 사기",
            "source": null,
            "destination": null,
            "createDateTime": "2020-04-15 16:15:41"
        }
    ]
}
```

## 개별 로그 요청

#### GET `/board/log/{id}`

### 요청 데이터
- 현재는 전달해야할 데이터가 존재하지 않습니다.

### JSON 응답

- 성공적으로 반환하는 경우
   - 상태 코드 : OK (200)
```
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
```

- 실패한 경우
   - 상태 코드 : Not Found (404)
   - 존재하지 않는 id를 전달한 경우
```
{
    "status": "ERROR",
    "content": "리소스를 찾을 수 없습니다."
}
```

## 로그 서버 시간 요청

#### GET `/board/log/serverTime`

### 요청 데이터
- 현재는 전달해야할 데이터가 존재하지 않습니다.

### JSON 응답

- 성공적으로 반환하는 경우
   - 상태 코드 : OK (200)
```
{
    "status": "SUCCESS",
    "content": "2020-04-16 15:37:43"
}
```
---

# BE 요구사항 분석

1. 스프링 부트 프로젝트 세팅
2. Ngnix 설치
3. MySQL 설치
4. DB 스키마 설계 
   - Column 내에서 순서 변경이 가능해야 한다.
   - 다른 Column으로 변경이 가능해야 한다.
5. Mock API 설계
6. MySQL과 스프링 부트 연결
7. [카드 추가](https://docs.google.com/presentation/d/13OX2mGk-wvwPyI06afMPITMPz9jGYLe4y2FIFBImeyA/edit#slide=id.g5d3e915f61_0_17)
    - \+ 버튼
8. [카드 삭제](https://docs.google.com/presentation/d/13OX2mGk-wvwPyI06afMPITMPz9jGYLe4y2FIFBImeyA/edit#slide=id.g63a6825c18_0_66)
    - x 버튼
9. [카드 내용 수정](https://docs.google.com/presentation/d/13OX2mGk-wvwPyI06afMPITMPz9jGYLe4y2FIFBImeyA/edit#slide=id.g63a6825c18_0_6)
    - 모달 창
   - 글자 수 제한 500자
10. 로그인
    - JWT를 이용한 인증
    - 인터셉터 이용
    - 하드코딩된 회원
11. [Column 내 카드 순서 변경](https://docs.google.com/presentation/d/13OX2mGk-wvwPyI06afMPITMPz9jGYLe4y2FIFBImeyA/edit#slide=id.g5d3e915f61_0_63)
    - 드래그 앤 드랍
12. [카드의 Column 변경](https://docs.google.com/presentation/d/13OX2mGk-wvwPyI06afMPITMPz9jGYLe4y2FIFBImeyA/edit#slide=id.g5d3e915f61_0_63)
    - 드래그 앤 드랍
13. [Activity 기록 리스트](https://docs.google.com/presentation/d/13OX2mGk-wvwPyI06afMPITMPz9jGYLe4y2FIFBImeyA/edit#slide=id.g5d3e915f61_0_84)
    - 추가(add), 삭제(remove), 변경(update), 이동(move) 행위에 대한 기록
    - 변경 시간 표시
    - (선택) 사용자 이름과 프로필 사진 표시
14. [Column 제목 변경](https://docs.google.com/presentation/d/13OX2mGk-wvwPyI06afMPITMPz9jGYLe4y2FIFBImeyA/edit#slide=id.g63a6825c18_0_29)
    - 글자 수 제한 50자
15. (선택) [Column 추가 및 삭제](https://docs.google.com/presentation/d/13OX2mGk-wvwPyI06afMPITMPz9jGYLe4y2FIFBImeyA/edit#slide=id.g5d468f7fda_1_0)
