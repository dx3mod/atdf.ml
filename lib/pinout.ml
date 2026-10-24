type t = { name : string; caption : string; pins : pin list }
and pin = { position : int; pad : string }

let rec of_xml xml =
  Xml_decoder.assert_element "pinout" xml;

  let name = Xml_decoder.(attribute "name" string xml)
  and caption = Xml_decoder.(attribute "caption" string xml)
  and pins = Xml_decoder.children pin_of_xml xml in

  { name; caption; pins }

and pin_of_xml xml =
  Xml_decoder.assert_element "pin" xml;

  let position = Xml_decoder.(attribute "position" int xml)
  and pad = Xml_decoder.(attribute "pad" string xml) in

  { position; pad }
