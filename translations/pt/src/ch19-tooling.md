# Capítulo 19: Ferramentas

## v fmt

Formata código-fonte V de acordo com o guia de estilo oficial. Use `-w` para gravar alterações no local.

```bash
v fmt -w .
```

### Formatando um único arquivo

```bash
v fmt -w main.v
```

### Verificando formatação sem gravar

```bash
v fmt -check .
```

## v doc

Gera documentação a partir de arquivos-fonte V. Produz HTML por padrão.

```bash
v doc .
```

### Documentando um módulo específico

```bash
v doc -o docs/ .
```

## v profiler

Faz perfil da execução do programa para identificar gargalos de desempenho.

```bash
v -profile profile.txt run main.v
```

### Analisando a saída do perfil

```bash
v profile profile.txt
```

## v test

Executa testes unitários no diretório atual ou arquivo especificado.

```bash
v test .
```

### Executando um teste específico

```bash
v test -run TestName .
```

### Executando testes com cobertura

```bash
v test -cover .
```

## v check

Realiza análise estática em código V, verificando erros, avisos e problemas de estilo.

```bash
v check .
```

### Verificando um único arquivo

```bash
v check main.v
```

## Compilação cruzada

V pode compilar código para diferentes sistemas operacionais e arquiteturas a partir de uma única máquina.

```bash
v -os windows main.v
v -os linux main.v
v -os macos main.v
```

### Especificando arquitetura

```bash
v -os linux -arch amd64 main.v
v -os linux -arch arm64 main.v
```

### Compilação cruzada para alvos embarcados

```bash
v -os embedded -arch arm main.v
```

## v doctor

Exibe informações de diagnóstico sobre a instalação V, incluindo versão do compilador, SO e configuração.

```bash
v doctor
```

## v up

Atualiza o compilador V para a versão mais recente.

```bash
v up
```

### Atualizando para uma versão específica

```bash
v up --version 0.5.2
```

## Resumo

Neste capítulo, você aprendeu sobre o ecossistema de ferramentas de V: `v fmt` para formatação, `v doc` para documentação, `v profiler` para análise de desempenho, `v test` para testes, `v check` para análise estática, compilação cruzada, `v doctor` para diagnósticos e `v up` para auto-atualizações. No próximo capítulo, vamos construir um projeto final.
