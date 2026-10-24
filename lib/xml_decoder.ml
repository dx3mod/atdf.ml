let attribute name f xml = Xml.attrib xml name |> f

let attribute_opt name f xml =
  try Some (attribute name f xml) with Xml.No_attribute _ -> None

let assert_element name xml = assert (Xml.tag xml = name)

let child name f xml =
  Xml.children xml |> List.find (fun xml -> Xml.tag xml = name) |> f

let child_opt name f xml =
  Xml.children xml
  |> List.find_map (fun xml ->
      if Xml.tag xml = name then Some (f xml) else None)

let children f xml = Xml.children xml |> List.map f

let children' name f xml =
  Xml.children xml
  |> List.filter_map (fun xml ->
      if Xml.tag xml = name then Some (f xml) else None)

(* *)

let string = Fun.id
and int = int_of_string
and float = float_of_string
and bool = bool_of_string
