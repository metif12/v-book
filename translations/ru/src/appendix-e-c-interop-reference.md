# Приложение E: Справочник по интероперабельности V и C

## Подключение кода C

```v ignore
#include "myheader.h"
```

## Флаги C

```v
#flag -lm
#flag -I/path/to/include
```

## Вызов функций C

```v
fn C.my_c_function(int) int
```

## Экспорт функций V

```v
@[export: 'my_v_function']
fn my_v_function() {
    // ...
}
```

## Разделяемые библиотеки

```bash
v -shared -o libmylib.so mylib.v
```
