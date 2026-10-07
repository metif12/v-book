# v.mod

`v.mod` 파일은 프로젝트를 설명합니다:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

## 필드

| 필드 | 설명 |
|-------|-------------|
| `name` | 프로젝트 이름 (디렉터리 이름과 일치해야 함) |
| `description` | 간단한 설명 |
| `version` | 시맨틱 버전 |
| `license` | 라이선스 식별자 |
| `dependencies` | VPM 패키지 이름 목록 |

## 다음

[v fmt로 포맷팅하기](ch02-03-formatting.md)
