# Chapter 1: 시작하기

V 여정을 시작해봅시다! 배울 것이 많지만, 모든 여정은 작은 걸음으로 시작됩니다. 이 장에서는 다음 내용을 배웁니다:

- 시스템에 V 설치하기
- "Hello, World!" 프로그램 작성하기
- V 컴파일러와 명령어 사용하기
- V 프로젝트 생성하기

## 설치

V는 Windows, macOS, Linux에 설치할 수 있습니다. 가장 쉬운 방법은 인스톨러 스크립트를 사용하는 것입니다:

### Windows

[vlang.io/install](https://vlang.io/install.html)에서 인스톨러를 다운로드하여 실행하거나 PowerShell을 사용하세요:

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### macOS

```bash
brew install vlang
```

또는 인스톨러 스크립트를 사용하세요:

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Linux

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### 소스에서 빌드

소스에서 V를 빌드하려면:

```bash
git clone https://github.com/vlang/v
cd v
make
```

## 설치 확인

설치 후 V가 정상 작동하는지 확인하세요:

```bash
v version
```

다음과 같은 출력이 표시되어야 합니다:

```
V 0.5.2
```

## Hello, World!

이제 첫 번째 V 프로그램을 작성해봅시다. `main.v` 파일을 생성하세요:

```v
fn main() {
    println('Hello, World!')
}
```

실행하세요:

```bash
v run main.v
```

다음과 같이 표시됩니다:

```
Hello, World!
```

축하합니다! 첫 번째 V 프로그램을 작성하고 실행했습니다.

## Hello, V!

조금 더 흥미로운 예제를 살펴봅시다:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

실행하세요:

```bash
v run main.v
```

출력:

```
Hello, V!
V is a great language.
```

## V 컴파일러

V 컴파일러는 `v` 명령으로 실행됩니다. 주요 명령어:

| 명령어 | 설명 |
|---------|-------------|
| `v run file.v` | V 파일을 컴파일하고 실행 |
| `v file.v` | V 파일을 실행 파일로 컴파일 |
| `v fmt file.v` | V 파일 포맷팅 |
| `v test .` | 현재 디렉터리의 테스트 실행 |
| `v doc .` | 문서 생성 |
| `v doctor` | V 설치 진단 |

## 요약

이 장에서는 V 설치, "Hello, World!" 프로그램 작성, V 컴파일러 사용 방법을 배웠습니다. 다음 장에서는 V 프로젝트의 구조를 살펴보겠습니다.
