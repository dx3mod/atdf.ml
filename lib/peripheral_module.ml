type t = { name : string; instances : instance list }

and instance = {
  name : string;
  register_group : register_group option;
  signals : signal list;
}

and register_group = {
  name : string;
  name_in_module : string;
  offset : int;
  address_space : string;
}

and signal = { group : string; func : string; pad : string }

let rec of_xml xml =
  Xml_decoder.assert_element "module" xml;

  let name = Xml_decoder.(attribute "name" string xml)
  and instances = Xml_decoder.children' "instance" instance_of_xml xml in

  { name; instances }

and instance_of_xml xml =
  Xml_decoder.assert_element "instance" xml;

  let name = Xml_decoder.(attribute "name" string xml)
  and register_group =
    Xml_decoder.child_opt "register-group" register_group_of_xml xml
  and signals =
    Xml_decoder.child_opt "signals"
      (fun xml -> Xml_decoder.children signal_of_xml xml)
      xml
    |> Option.value ~default:[]
  in

  { name; register_group; signals }

and register_group_of_xml xml =
  Xml_decoder.assert_element "register-group" xml;

  let name = Xml_decoder.(attribute "name" string xml)
  and name_in_module = Xml_decoder.(attribute "name-in-module" string xml)
  and offset = Xml_decoder.(attribute "offset" int xml)
  and address_space = Xml_decoder.(attribute "address-space" string xml) in

  { name; name_in_module; offset; address_space }

and signal_of_xml xml =
  Xml_decoder.assert_element "signal" xml;

  let group = Xml_decoder.(attribute "group" string xml)
  and func = Xml_decoder.(attribute "function" string xml)
  and pad = Xml_decoder.(attribute "pad" string xml) in

  { group; func; pad }
