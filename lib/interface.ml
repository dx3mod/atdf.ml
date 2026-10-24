type t = { name : string; kind : string } [@@deriving show]

let of_xml xml =
  Xml_decoder.assert_element "interface" xml;

  let name = Xml_decoder.(attribute "name" string xml)
  and kind = Xml_decoder.(attribute "type" string xml) in

  { name; kind }
