type t = { name : string; properties : property list }

and property = {
  name : string;
  value : [ `Int of int | `Binary of string | `Variable of string ];
}
[@@deriving show]

let rec of_xml xml =
  Xml_decoder.assert_element "property-group" xml;

  let name = Xml_decoder.(attribute "name" string xml)
  and properties = Xml_decoder.(children property_of_xml xml) in

  { name; properties }

and property_of_xml xml =
  Xml_decoder.assert_element "property" xml;

  let value s =
    match int_of_string_opt s with
    | None when String.length s >= 8 ->
        let buffer = Buffer.create 100 in

        String.split_on_char ' ' s
        |> List.iter (fun num -> Buffer.add_uint8 buffer @@ int_of_string num);

        `Binary (Buffer.contents buffer)
    | None -> `Variable s
    | Some num -> `Int num
  in

  let name = Xml_decoder.(attribute "name" string xml)
  and value = Xml_decoder.(attribute "value" value xml) in

  { name; value }
