# atdf

Atmel's ATDF (AVR Target Description Format) files parsing library.

ATDF files describe the complete hardware layout of AVR microcontrollers, including memory maps, registers, bitfields, interrupts, peripherals, pinouts, and programmer interfaces. This library parses them into strongly-typed OCaml records.


**Features**

- Full ATDF v0.3 schema coverage (variants, devices, modules, pinouts)


## Quick start

You can install `atdf` using the [OPAM] package manager or another method. If you are using [Dune], add `atdf` to your dependencies.

### In use

The library uses `xml-light` for XML parsing; the parsed XML is then passed to the `atdf` library to produce a structured representation.

```ocaml
#require "xml-light";;
#require "atdf";;

Xml.parse_file "atmega328pb.atdf" |> Atdf.File.of_xml
(* - : Atdf.File.t = ... *)
```

For more details, see the [API reference](https://ocaml.org/p/atdf/latest/doc/index.html).


## License

The project is licensed under [the MIT License](./LICENSE), which allows for all permissions.
Just use it and enjoy yourself without fear. We are always open to pull requests!


[OPAM]: https://opam.ocaml.org/
[Dune]: https://dune.build