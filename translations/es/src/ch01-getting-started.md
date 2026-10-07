# Capítulo 1: Primeros Pasos

¡Comencemos tu viaje con V! Hay mucho que aprender, pero todo viaje comienza con un pequeño paso. En este capítulo, aprenderás a:

- Instalar V en tu sistema
- Escribir un programa "¡Hola, Mundo!"
- Usar el compilador de V y sus comandos
- Crear un proyecto V

## Instalación

V se puede instalar en Windows, macOS y Linux. La forma más fácil es usar el script de instalación:

### Windows

Descarga y ejecuta el instalador desde [vlang.io/install](https://vlang.io/install.html), o usa PowerShell:

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### macOS

```bash
brew install vlang
```

O usa el script de instalación:

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Linux

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Desde el código fuente

Para compilar V desde el código fuente:

```bash
git clone https://github.com/vlang/v
cd v
make
```

## Verificando la instalación

Después de la instalación, verifica que V funcione:

```bash
v version
```

Deberías ver una salida como:

```
V 0.5.2
```

## ¡Hola, Mundo!

Ahora escribamos nuestro primer programa en V. Crea un archivo llamado `main.v`:

```v
fn main() {
    println('Hello, World!')
}
```

Ejecútalo:

```bash
v run main.v
```

Deberías ver:

```
Hello, World!
```

¡Felicidades! Has escrito y ejecutado tu primer programa en V.

## ¡Hola, V!

Veamos un ejemplo un poco más interesante:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

Ejecútalo:

```bash
v run main.v
```

Salida:

```
Hello, V!
V is a great language.
```

## El compilador de V

El compilador de V se invoca con el comando `v`. Comandos comunes:

| Comando | Descripción |
|---------|-------------|
| `v run file.v` | Compila y ejecuta un archivo V |
| `v file.v` | Compila un archivo V a un ejecutable |
| `v fmt file.v` | Formatea un archivo V |
| `v test .` | Ejecuta pruebas en el directorio actual |
| `v doc .` | Genera documentación |
| `v doctor` | Diagnostica tu instalación de V |

## Resumen

En este capítulo, aprendiste a instalar V, escribir un programa "¡Hola, Mundo!" y usar el compilador de V. En el siguiente capítulo, veremos cómo estructurar un proyecto V.
