type t = { index : int; name : string; caption : string }

let of_xml xml =
  Xml_decoder.assert_element "interrupt" xml;

  let index = Xml_decoder.(attribute "index" int xml)
  and name = Xml_decoder.(attribute "name" string xml)
  and caption = Xml_decoder.(attribute "caption" string xml) in

  { index; name; caption }
