# Chapter 19: 도구

## v fmt

공식 스타일 가이드에 따라 V 소스 코드를 포맷합니다. `-w`를 사용하여 변경 사항을 저장합니다.

```bash
v fmt -w .
```

### 단일 파일 포맷팅

```bash
v fmt -w main.v
```

### 포맷 확인만 (저장 안 함)

```bash
v fmt -check .
```

## v doc

V 소스 파일에서 문서를 생성합니다. 기본적으로 HTML로 출력합니다.

```bash
v doc .
```

### 특정 모듈 문서화

```bash
v doc -o docs/ .
```

## v profiler

프로그램 실행을 프로파일링하여 성능 병목 현상을 식별합니다.

```bash
v -profile profile.txt run main.v
```

### 프로파일 출력 분석

```bash
v profile profile.txt
```

## v test

현재 디렉터리 또는 지정된 파일의 유닛 테스트를 실행합니다.

```bash
v test .
```

### 특정 테스트 실행

```bash
v test -run TestName .
```

### 커버리지와 함께 테스트 실행

```bash
v test -cover .
```

## v check

V 코드에 정적 분석을 수행하여 에러, 경고, 스타일 문제를 확인합니다.

```bash
v check .
```

### 단일 파일 검사

```bash
v check main.v
```

## 크로스 컴파일

V는 한 대의 머신에서 다른 운영체제와 아키텍처용 코드를 컴파일할 수 있습니다.

```bash
v -os windows main.v
v -os linux main.v
v -os macos main.v
```

### 아키텍처 지정

```bash
v -os linux -arch amd64 main.v
v -os linux -arch arm64 main.v
```

### 임베디드 타겟 크로스 컴파일

```bash
v -os embedded -arch arm main.v
```

## v doctor

컴파일러 버전, OS, 설정을 포함한 V 설치에 대한 진단 정보를 표시합니다.

```bash
v doctor
```

## v up

V 컴파일러를 최신 버전으로 업데이트합니다.

```bash
v up
```

### 특정 버전으로 업데이트

```bash
v up --version 0.5.2
```

## 요약

이 장에서는 V의 도구 생태계에 대해 배웠습니다: 포맷팅을 위한 `v fmt`, 문서화를 위한 `v doc`, 성능 분석을 위한 `v profiler`, 테스팅을 위한 `v test`, 정적 분석을 위한 `v check`, 크로스 컴파일, 진단을 위한 `v doctor`, 자체 업데이트를 위한 `v up`. 다음 장에서는 최종 프로젝트를 만들어보겠습니다.
