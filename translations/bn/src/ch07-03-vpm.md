# VPM

V's package registry is VPM, and the commands that talk to it are part of `v` itself: there is nothing else to install.

## Installing a module

`v install` puts a module into `~/.vmodules`, which is where V looks for imports after the standard library:

```bash
v install markdown
```

The installed module is imported by name, with no path in the source:

```v no_run
import markdown

fn main() {
	html := markdown.to_html('# Hello from VPM')
	println(html)
}
```

What is in the registry changes from month to month, so search before you install. `vpm.url4e.com` is the registry's home.

## Searching

```bash
v search json
```

## Listing what you installed

```bash
v list                 # everything installed
v outdated             # which of them has an update
v show markdown        # the details of a published module
v update markdown      # update one
v upgrade              # update everything
v remove markdown      # uninstall one
```

## Modules you are working on

A module you are developing is not installed — it is linked. `v link` symlinks the current project into `~/.vmodules`, so a program can import it while you are still editing it, and `v unlink` takes it back out:

```bash
cd mymodule
v link
v unlink
```

`v tool greet` runs an installed tool module by name, the same way an import resolves it. And `v mod why mymodule` prints the chain of imports that brings a module into your build, which is the command to reach for when you cannot remember why a dependency is there.

## Next

[Chapter 8: Collections](ch08-collections.md)
