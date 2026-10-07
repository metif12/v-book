# Chapter 19: Tooling

## v fmt

Formats V source code according to the official style guide. Use `-w` to write changes in place.

```bash
v fmt -w .
```

### Formatting a single file

```bash
v fmt -w main.v
```

### Check formatting without writing

```bash
v fmt -check .
```

## v doc

Generates documentation from V source files. Outputs HTML by default.

```bash
v doc .
```

### Documenting a specific module

```bash
v doc -o docs/ .
```

## v profiler

Profiles program execution to identify performance bottlenecks.

```bash
v -profile profile.txt run main.v
```

### Analyzing profile output

```bash
v profile profile.txt
```

## v test

Runs unit tests in the current directory or specified file.

```bash
v test .
```

### Running a specific test

```bash
v test -run TestName .
```

### Running tests with coverage

```bash
v test -cover .
```

## v check

Performs static analysis on V code, checking for errors, warnings, and style issues.

```bash
v check .
```

### Checking a single file

```bash
v check main.v
```

## Cross-compilation

V can compile code for different operating systems and architectures from a single machine.

```bash
v -os windows main.v
v -os linux main.v
v -os macos main.v
```

### Specifying architecture

```bash
v -os linux -arch amd64 main.v
v -os linux -arch arm64 main.v
```

### Cross-compiling for embedded targets

```bash
v -os embedded -arch arm main.v
```

## v doctor

Displays diagnostic information about the V installation, including compiler version, OS, and configuration.

```bash
v doctor
```

## v up

Updates the V compiler to the latest version.

```bash
v up
```

### Updating to a specific version

```bash
v up --version 0.5.2
```

## Summary

In this chapter, you learned about V's tooling ecosystem: `v fmt` for formatting, `v doc` for documentation, `v profiler` for performance analysis, `v test` for testing, `v check` for static analysis, cross-compilation, `v doctor` for diagnostics, and `v up` for self-updates. In the next chapter, we'll build a final project.
