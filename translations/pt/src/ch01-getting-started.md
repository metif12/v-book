# Capítulo 1: Primeiros Passos

Vamos começar sua jornada em V! Há muito para aprender, mas toda jornada começa com um pequeno passo. Neste capítulo, você aprenderá como:

- Instalar V no seu sistema
- Escrever um programa "Olá, Mundo!"
- Usar o compilador V e seus comandos
- Criar um projeto V

## Instalação

V pode ser instalado no Windows, macOS e Linux. A maneira mais fácil é usar o script de instalação:

### Windows

Baixe e execute o instalador de [vlang.io/install](https://vlang.io/install.html), ou use PowerShell:

```powershell
irm https://raw.githubusercontent.com/vlang/v/master/installer.ps1 | iex
```

### macOS

```bash
brew install vlang
```

Ou use o script de instalação:

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### Linux

```bash
curl -sSL https://raw.githubusercontent.com/vlang/v/master/installer.sh | bash
```

### A partir do código-fonte

Para compilar V a partir do código-fonte:

```bash
git clone https://github.com/vlang/v
cd v
make
```

## Verificando a instalação

Após a instalação, verifique se V está funcionando:

```bash
v version
```

Você deve ver uma saída como:

```
V 0.5.2
```

## Olá, Mundo!

Agora vamos escrever nosso primeiro programa V. Crie um arquivo chamado `main.v`:

```v
fn main() {
    println('Hello, World!')
}
```

Execute:

```bash
v run main.v
```

Você deve ver:

```
Hello, World!
```

Parabéns! Você escreveu e executou seu primeiro programa V.

## Olá, V!

Vamos ver um exemplo um pouco mais interessante:

```v
fn main() {
    name := 'V'
    println('Hello, ${name}!')
    println('${name} is a great language.')
}
```

Execute:

```bash
v run main.v
```

Saída:

```
Hello, V!
V is a great language.
```

## O compilador V

O compilador V é invocado com o comando `v`. Comandos comuns:

| Comando | Descrição |
|---------|-------------|
| `v run file.v` | Compila e executa um arquivo V |
| `v file.v` | Compila um arquivo V em um executável |
| `v fmt file.v` | Formata um arquivo V |
| `v test .` | Executa testes no diretório atual |
| `v doc .` | Gera documentação |
| `v doctor` | Diagnostica sua instalação V |

## Resumo

Neste capítulo, você aprendeu como instalar V, escrever um programa "Olá, Mundo!" e usar o compilador V. No próximo capítulo, veremos como estruturar um projeto V.
