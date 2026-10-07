# 프로젝트 구조

V 프로젝트는 `v.mod` 파일이 있는 디렉터리입니다:

```
my_project/
├── v.mod
├── main.v
├── my_module.v
└── my_module_test.v
```

## v.mod

```v ignore
Module {
    name: 'my_project'
    description: 'My first V project'
    version: '0.1.0'
    license: 'MIT'
    dependencies: []
}
```

## 프로젝트 생성

```bash
v init
```

## 다음

[v.mod](ch02-02-vmod.md)
