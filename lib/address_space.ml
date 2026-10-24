type t = {
  endianness : [ `Little_endian | `Big_endian ];
  name : string;
  id : string;
  start : int;
  size : int;
  segments : Memory_segment.t list;
}

let of_xml xml =
  Xml_decoder.assert_element "address-space" xml;

  let endianness =
    match Xml_decoder.(attribute "endianness" string xml) with
    | "little" -> `Little_endian
    | "big" -> `Big_endian
    | _ -> invalid_arg "illegal endianness value"
  and name = Xml_decoder.(attribute "name" string xml)
  and id = Xml_decoder.(attribute "id" string xml)
  and start = Xml_decoder.(attribute "start" int xml)
  and size = Xml_decoder.(attribute "size" int xml)
  and segments = Xml_decoder.(children Memory_segment.of_xml xml) in

  { endianness; name; id; start; size; segments }
