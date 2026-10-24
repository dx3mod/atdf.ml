type t = {
  name : string;
  caption : string;
  offset : int;
  size : int;
  initial_value : int option;
  bitfields : bitfield list;
}

and bitfield = {
  name : string;
  caption : string;
  mask : int;
  values : string option;
}

let rec of_xml xml =
  Xml_decoder.assert_element "register" xml;

  let name = Xml_decoder.(attribute "name" string xml)
  and caption = Xml_decoder.(attribute "caption" string xml)
  and offset = Xml_decoder.(attribute "offset" int xml)
  and size = Xml_decoder.(attribute "size" int xml)
  and initial_value = Xml_decoder.(attribute_opt "initval" int xml)
  and bitfields = Xml_decoder.children bitfield_of_xml xml in

  { name; caption; offset; size; initial_value; bitfields }

and bitfield_of_xml xml =
  Xml_decoder.assert_element "bitfield" xml;

  let name = Xml_decoder.(attribute "name" string xml)
  and caption = Xml_decoder.(attribute "caption" string xml)
  and mask =
    Xml_decoder.(attribute_opt "mask" int xml) |> Option.value ~default:0xFFFF
  and values = Xml_decoder.(attribute_opt "values" string xml) in

  { name; caption; mask; values }
