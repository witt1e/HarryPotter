# Harry Potter
<!--배지-->
![MIT License][license-shield] ![Repository Size][repository-size-shield] ![Issue Closed][issue-closed-shield]

<!--목차-->
# Table of Contents
- [[1] About the Project](#1-about-the-project)
  - [Features](#features)
  - [Technologies](#technologies)
- [[2] Getting Started](#2-getting-started)
  - [Installation](#installation)
- [[3] Usage](#3-usage)
- [[4] Contribution](#4-contribution)
- [[5] Acknowledgement](#5-acknowledgement)
- [[6] Troubleshooting](#6-troubleshooting)
- [[7] Contact](#7-contact)
- [[8] License](#8-license)

# [1] About the Project
- 해리포터 책의 정보를 볼 수 있는 해리포터 시리즈 책 앱을 개발
- 가변적인 데이터에 유연하게 대응하는 UI를 구성
- Autolayout과 View 간의 제약 관계를 적절히 구현
>

## Features
- *1. 해리포터 시리즈별 정보 조회: 시리즈 번호를 누르면 시리즈별 정보(책 제목, 이미지, 저자명, 출판일, 총 페이지 수, 헌정사, 요약 내용, 각 챕터 제목 등)를 일목요연하게 제공*
- *2. 요약내용에 대한 더보기/접기 버튼 기능: 내용이 450자를 초과할 경우 버튼을 눌러 나머지 내용을 확인할 수 있음. 다른 시리즈를 조회하거나 앱을 종료하더라도 버튼 상태를 저장하여 관리*
- *3. 다양한 디바이스 및 가로/세로 모드 모두 지원: iOS 16 이상 기기(아이폰 한정)에 대해 모두 대응*

## Technologies
- [Swift](https://www.swift.org) 5.0

# [2] Getting Started

## Installation
- Repository 클론
```bash
git clone https://github.com/witt1e/HarryPotter.git
```

# [3] Usage
- 각 시리즈 조회: 해리포터 총 시리즈와 동일하게 1~7번의 버튼 제공. 버튼을 누르면 해당 시리즈 정보를 조회할 수 있음.
- 더보기/접기 기능: 요약 내용 우측 하단에 더보기/접기 버튼 제공. 내용이 450자를 초과하는 경우에만 버튼이 활성화되고, 버튼을 토글하면 전체 내용을 확인할 수 있음. 다른 시리즈 버튼을 누르거나 앱을 종료하더라도 해당 시리즈의 상태정보를 기억함.

# [4] Contribution
2조(TJ 미디어)

# [5] Acknowledgement
- https://developer.apple.com/documentation/uikit/uistackview
- https://wittie.tistory.com/19
- https://wittie.tistory.com/27

# [6] Troubleshooting
- https://wittie.tistory.com/28

# [7] Contact
- 📋 https://github.com/witt1e

# [8] License
MIT 라이센스
라이센스에 대한 정보는 [`LICENSE`][license-url]에 있습니다.

<!--Url for Badges-->
[license-shield]: https://img.shields.io/github/license/dev-ujin/readme-template?labelColor=D8D8D8&color=04B4AE
[repository-size-shield]: https://img.shields.io/github/repo-size/dev-ujin/readme-template?labelColor=D8D8D8&color=BE81F7
[issue-closed-shield]: https://img.shields.io/github/issues-closed/dev-ujin/readme-template?labelColor=D8D8D8&color=FE9A2E

<!--URLS-->
[license-url]: LICENSE.md
