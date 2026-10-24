type t = { name : string; caption : string; pins : pin list }
and pin = { position : string; pad : string } [@@deriving show]

let rec of_xml xml =
  Xml_decoder.assert_element "pinout" xml;

  let name = Xml_decoder.(attribute "name" string xml)
  and caption =
    Xml_decoder.(attribute_opt "caption" string xml) |> Option.value ~default:""
  and pins = Xml_decoder.children pin_of_xml xml in

  { name; caption; pins }

and pin_of_xml xml =
  Xml_decoder.assert_element "pin" xml;

  let position = Xml_decoder.(attribute "position" string xml)
  and pad = Xml_decoder.(attribute "pad" string xml) in

  { position; pad }
