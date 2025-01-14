# odin-tinyfiledialogs

[Odin](https://odin-lang.org/) bindings for [`tinyfiledialogs`](https://sourceforge.net/projects/tinyfiledialogs/).

## Usage

- Copy the `tinyfiledialogs` directory to your project.
- Import `tinyfiledialogs` and use the bindings.
- See the `example` directory for a simple example.

```
cd example
odin build . -out:example
./example -help
# This is a single example. See the enum in `example/main.odin` for all types.
./example -type:input
```

## Status

Only tested on macOS arm64. There are Linux libraries that I built but they are completley untested. I also plan to support Windows anand I'd be happy to have help testing these platforms.

## License

[zlib](https://opensource.org/license/zlib)
