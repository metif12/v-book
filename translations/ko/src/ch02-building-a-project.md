# Chapter 2: 프로젝트 구성하기

이 장에서는 V 프로젝트의 구조, `v.mod` 사용법, `v fmt`로 코드 포맷팅, `v test`로 테스트 작성 방법을 배웁니다.

## 프로젝트 구조

V 프로젝트는 `v.mod` 파일과 하나 이상의 `.v` 파일이 있는 디렉터리입니다:

```
my_project/
├── v.mod
├── main.v
└── my_module.v
```

## v.mod

모든 V 프로젝트는 프로젝트를 설명하는 `v.mod` 파일을 가집니다:

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

새 프로젝트 생성:

```bash
v init
```

이 명령은 기본 템플릿이 포함된 `v.mod`과 `main.v`를 생성합니다.

## v fmt로 포맷팅하기

V에는 내장 코드 포매터가 있습니다. 프로젝트에 실행하세요:

```bash
v fmt -w .
```

`-w` 플래그는 포맷팅된 코드를 파일에 다시 저장합니다.

## v test로 테스트하기

V에는 내장 테스팅 프레임워크가 있습니다. `_test.v`로 끝나는 파일을 생성하세요:

```v
fn add(a int, b int) int {
    return a + b
}

fn test_add() {
    assert add(2, 3) == 5
    assert add(-1, 1) == 0
}
```

테스트 실행:

```bash
v test .
```

## 요약

이 장에서는 V 프로젝트의 구조, `v.mod` 사용법, 코드 포맷팅, 테스트 작성 방법을 배웠습니다. 다음 장에서는 V의 일반적인 프로그래밍 개념을 살펴보겠습니다.
