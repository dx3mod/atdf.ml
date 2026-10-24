(lang dune 3.20)

(name atdf)

(generate_opam_files true)

(source
 (github dx3mod/atdf.ml))

(authors "Mikhail Lopatin <dx3mod@bk.ru>")

(maintainers "Mikhail Lopatin <dx3mod@bk.ru>")

(license MIT)

(package
 (name atdf)
 (synopsis "Atmel's ATDF files parsing library")
 (depends
  (ocaml
   (>= 4.14))
  xml-light
  (ppx_deriving :build))
 (tags
  (embedded avr atmel atdf)))
