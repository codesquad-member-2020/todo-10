# TODO API

## 서버 요청 주소 (변경될 수 있음)

http://ec2-15-164-63-83.ap-northeast-2.compute.amazonaws.com:8080

## 로그인 요청

### POST /board/login

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

### GET /board

### 요청 데이터
- 현재는 전달해야할 데이터가 존재하지 않습니다.
- JWT 구현 후, 헤더에 담긴 토큰이 유효한 경우에만 보드 내용을 성공적으로 반환합니다.

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
            "createDateTime": "2020-04-14T14:33:45",
            "updateDateTime": "2020-04-14T14:33:45",
            "cards": [
                {
                    "id": 1,
                    "title": null,
                    "content": "ㅇㅇㅇ2",
                    "createDateTime": "2020-04-14T14:33:57",
                    "updateDateTime": "2020-04-14T14:33:57",
                    "author": "nigayo",
                    "sectionKey": 0
                },
                {
                    "id": 3,
                    "title": "발리",
                    "content": "ㅇㅇㅇ2",
                    "createDateTime": "2020-04-14T14:37:46",
                    "updateDateTime": "2020-04-14T14:37:46",
                    "author": "nigayo",
                    "sectionKey": 1
                }
            ]
        },
        {
            "id": 2,
            "title": "하고 있는 일",
            "createDateTime": "2020-04-14T14:33:45",
            "updateDateTime": "2020-04-14T14:33:45",
            "cards": [
                {
                    "id": 2,
                    "title": "발리",
                    "content": "ㅇㅇㅇ2",
                    "createDateTime": "2020-04-14T14:34:16",
                    "updateDateTime": "2020-04-14T14:34:16",
                    "author": "nigayo",
                    "sectionKey": 0
                }
            ]
        },
        {
            "id": 3,
            "title": "완료된 일",
            "createDateTime": "2020-04-14T14:33:45",
            "updateDateTime": "2020-04-14T14:33:45",
            "cards": []
        }
    ]
}
```
- 실패한 경우
- 상태 코드 : FORBIDDEN (300)
```
{
    "status": "ERROR",
    "content": "접근 금지"
}
```
## 카드 추가 요청

### POST /board/section/{sectionId}/card

### 요청 데이터
```
{
    "title": "README.md 추가",
    "content": "구현 API 내용 작성",
}
```
- 카드 추가 요청 시, URL에 sectionId와 Body 데이터를 전달해야 합니다.
- 프론트에서는 content에 카드 내용을 담아주세요.

### JSON 응답

- 성공적으로 반환하는 경우
- 상태 코드 : OK (200)
```
{
    "status": "SUCCESS",
    "content": {
        "log_id": 3,
        "card_count": 3,
        "card": {
            "id": 3,
            "title": "회고",
            "content": "회고하자",
            "createDateTime": "2020-04-14T15:26:30",
            "updateDateTime": "2020-04-14T15:26:30",
            "author": "nigayo",
            "sectionKey": 2
        }
    }
}
```

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
