# v fmt로 포맷팅하기

V에는 내장 코드 포매터가 있습니다:

```bash
v fmt -w .
```

`-w` 플래그는 변경 사항을 파일에 다시 저장합니다. 없으면 포매터가 stdout에 출력합니다.

## 예제

포맷팅 전:

```v
fn main(){
println( 'hello' )
}
```

`v fmt` 후:

```v
fn main() {
    println('hello')
}
```

## 다음

[v test로 테스트하기](ch02-04-testing.md)
