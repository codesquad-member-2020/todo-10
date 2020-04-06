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
  * `feature<iOS>/issueXXX` : 모바일 iOS 피쳐 개발 브랜치
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

## API 문서
