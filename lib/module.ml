module Value_group = struct
  type t = { name : string; caption : string; values : value list }
  and value = { name : string; caption : string; value : int }

  let rec of_xml xml =
    Xml_decoder.assert_element "value-group" xml;

    let name = Xml_decoder.(attribute "name" string xml)
    and caption = Xml_decoder.(attribute "caption" string xml)
    and values = Xml_decoder.children value_of_xml xml in

    { name; caption; values }

  and value_of_xml xml =
    Xml_decoder.assert_element "value" xml;

    let name = Xml_decoder.(attribute "name" string xml)
    and caption = Xml_decoder.(attribute "caption" string xml)
    and value = Xml_decoder.(attribute "value" int xml) in

    { name; caption; value }
end

module Register_group = struct
  type t = { name : string; caption : string; registers : Register.t list }

  let of_xml xml =
    Xml_decoder.assert_element "register-group" xml;

    let name = Xml_decoder.(attribute "name" string xml)
    and caption = Xml_decoder.(attribute "caption" string xml)
    and registers = Xml_decoder.children Register.of_xml xml in

    { name; caption; registers }
end

type t = {
  name : string;
  caption : string;
  register_groups : Register_group.t list;
  value_groups : Value_group.t list;
}

let of_xml xml =
  Xml_decoder.assert_element "module" xml;

  let name = Xml_decoder.(attribute "name" string xml)
  and caption = Xml_decoder.(attribute "caption" string xml)
  and register_groups =
    Xml_decoder.children' "register-group" Register_group.of_xml xml
  and value_groups =
    Xml_decoder.children' "value-group" Value_group.of_xml xml
  in

  { name; caption; register_groups; value_groups }
