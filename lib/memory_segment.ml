type t = {
  name : string;
  kind : string;
  start : int;
  access_mode : [ `R | `W | `RW ];
  executable : bool;
  size : int;
  external' : bool;
  page_size : int option;
}

let of_xml xml =
  Xml_decoder.assert_element "memory-segment" xml;

  let name = Xml_decoder.(attribute "name" string xml)
  and kind = Xml_decoder.(attribute "type" string xml)
  and start = Xml_decoder.(attribute "start" int xml)
  and size = Xml_decoder.(attribute "size" int xml)
  and access_mode =
    match Xml_decoder.(attribute_opt "rw" string xml) with
    | Some "R" | None -> `R
    | Some "W" -> `W
    | Some "RW" -> `RW
    | _ -> invalid_arg "illegal mode value"
  and executable =
    match Xml_decoder.(attribute_opt "exec" int xml) with
    | Some 0 | None -> false
    | Some 1 -> true
    | _ -> invalid_arg "illegal exec value"
  and external' =
    Xml_decoder.(attribute_opt "external" bool xml)
    |> Option.value ~default:false
  and page_size = Xml_decoder.(attribute_opt "pagesize" int xml) in

  { name; kind; start; size; access_mode; executable; page_size; external' }
