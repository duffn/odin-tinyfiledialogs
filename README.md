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

## Building

There are pre-built libraries available for multiple platforms. You may want to build your own, however. You can use the `build.sh` and `build.bat` files to build the libraries or as a starting point.

## Status

- Tested on macOS arm64 and Windows amd64.
- There are Linux libraries that I built but they are completley untested.
- _Note:_ Windows UTF-16 functions are untested.

## License

[zlib](https://opensource.org/license/zlib)
