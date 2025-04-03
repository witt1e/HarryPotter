# Baseball Game
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
- [[6] Contact](#6-contact)
- [[7] License](#7-license)

# [1] About the Project
- 숫자 야구 게임은 1명이 즐길 수 있는 추리 게임으로, 컴퓨터가 설정한 3자리의 숫자를 맞히는 것이 목표.
- 각 자리의 숫자와 위치가 모두 맞으면 '스트라이크', 숫자만 맞고 위치가 다르면 '볼'로 판정. 예) 정답이 123일 때 132를 추리하면 1스트라이크 2볼.
>

## Features
- *1. 게임 시작: 정답을 맞추면 다시 타이틀 화면으로 복귀함. 게임 중간에 빠져나오려면 qqq 또는 QQQ 입력.*
- *2. 게임 기록 보기: 정답을 맞춘 게임을 게임 1회로 간주하고, 각 게임마다 몇 번의 시도를 했었는지 확인 가능*
- *3. 게임 끝내기: 게임을 끝내고, 기록을 초기화함.*

## Technologies
- [Swift](https://www.swift.org) 5.0

# [2] Getting Started

## Installation
- Repository 클론
```bash
git clone https://github.com/nbcampMasterChapter2Team4/KSWBaseBallGame.git
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

# [6] Contact
- 📋 [https://witt1e.github.io/contact](https://witt1e.github.io/contact)

# [7] License
MIT 라이센스
라이센스에 대한 정보는 [`LICENSE`][license-url]에 있습니다.

<!--Url for Badges-->
[license-shield]: https://img.shields.io/github/license/dev-ujin/readme-template?labelColor=D8D8D8&color=04B4AE
[repository-size-shield]: https://img.shields.io/github/repo-size/dev-ujin/readme-template?labelColor=D8D8D8&color=BE81F7
[issue-closed-shield]: https://img.shields.io/github/issues-closed/dev-ujin/readme-template?labelColor=D8D8D8&color=FE9A2E

<!--URLS-->
[license-url]: LICENSE.md
