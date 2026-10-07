# Chapitre 16 : Interop C

V peut appeler des fonctions C et être appelé depuis C.

## Appeler C depuis V

V peut appeler directement des fonctions C en utilisant le module `C`. Vous devez déclarer la signature de la fonction C et inclure les en-têtes nécessaires.

```v
#flag -lm
#include "math.h"

fn C.sqrt(f64) f64

fn main() {
    result := C.sqrt(16.0)
    println(result)
}
```

La directive `#flag` passe des options au compilateur C. Par exemple, `-lm` lie la bibliothèque mathématique. La directive `#include` inclut les fichiers d'en-tête C pour que le compilateur connaisse les fonctions C. La déclaration `fn C.function_name` informe V de la signature de la fonction C.

Vous pouvez appeler n'importe quelle fonction C en déclarant sa signature. Par exemple, pour appeler `puts` :

```v
#flag -lm
#include "stdio.h"

fn C.puts(byteptr) int

fn main() {
    C.puts(c'Hello, World!')
}
```

## Appeler V depuis C

Compilez V en bibliothèque partagée :

```bash
v -shared -o libmylib.so mylib.v
```

Ensuite, utilisez la bibliothèque partagée depuis C :

```v ignore
#include <stdio.h>

extern int add(int a, int b);

int main() {
    printf("%d\n", add(2, 3));
    return 0;
}
```

## C2V

V peut traduire du code C en V :

```bash
v translate myheader.h
```

## Travailler avec les types C

V fournit des types compatibles C comme `C.int`, `C.double`, `C.char`, etc.

```v
fn main() {
    x := int(42)
    y := f64(3.14)
    println(x)
    println(y)
}
```

## Callbacks

Vous pouvez passer des fonctions V à des callbacks C :

```v ignore
#flag -lm
#include "stdlib.h"

fn C.atexit(fn ())

fn my_callback() {
    println('done')
}

fn main() {
    C.atexit(my_callback)
}
```

## Résumé

Dans ce chapitre, vous avez appris l'interop C. Dans le chapitre suivant, nous explorerons les fonctionnalités avancées.
