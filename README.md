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
- [[3] Game Rules](#3-game-rules)
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

# [3] Game Rules
- 정답은 3자리 정수로 랜덤 생성되며, 맨 앞에는 0이 오지 않고, 숫자는 중복되지 않습니다. 예) 123 (O), 012 (X), 450 (O), 112 (X)
- 플레이어도 0~9 사이의 3자리 정수를 입력해야 합니다.
- 각 자리의 숫자와 위치가 모두 맞으면 '스트라이크', 숫자만 맞고 위치가 다르면 '볼'입니다.
- 3자리 모두 맞으면 '홈런'(즉, 정답), 3자리 모두 틀리면 '아웃'입니다.

# [4] Contribution
4조(i구 4람살려)

# [5] Acknowledgement
- https://stackoverflow.com/questions/51300121/how-to-make-a-swift-enum-with-associated-values-equatable

# [6] Troubleshooting
- https://wittie.tistory.com/14

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
