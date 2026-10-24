type t = {
  variants : Variant.t list;
  devices : Device.t list;
  modules : Module.t list;
  pinouts : Pinout.t list;
}

let of_xml xml =
  Xml_decoder.assert_element "avr-tools-device-file" xml;

  let variants = Xml_decoder.(child "variants" (children Variant.of_xml) xml)
  and devices = Xml_decoder.(child "devices" (children Device.of_xml) xml)
  and modules = Xml_decoder.(child "modules" (children Module.of_xml) xml)
  and pinouts = Xml_decoder.(child "pinouts" (children Pinout.of_xml) xml) in

  { variants; devices; modules; pinouts }

let of_channel ic = Xml.parse_in ic |> of_xml
and of_string s = Xml.parse_string s |> of_xml

let device { devices; _ } = List.hd devices
