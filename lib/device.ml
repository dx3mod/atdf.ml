type t = {
  name : string;
  architecture : [ `AVR8 | `AVR32 | `AVR_XMEGA ];
  family : [ `Tiny | `Mega | `XMega | `Unknown of string ];
  (* "tinyAVR"
ATtiny серия
"megaAVR"
ATmega серия
"xmega" *)
  address_spaces : Address_space.t list;
  peripherals : Peripheral_module.t list;
  interrupts : Interrupt.t list;
  interfaces : Interface.t list;
  property_groups : Property_group.t list;
}

let of_xml xml =
  Xml_decoder.assert_element "device" xml;

  let name = Xml_decoder.(attribute "name" string xml)
  and architecture =
    match Xml_decoder.(attribute "architecture" string xml) with
    | "AVR8" -> `AVR8
    | "AVR32" -> `AVR32
    | "AVR-XMEGA" -> `AVR_XMEGA
    | family ->
        invalid_arg @@ Printf.sprintf "unknown %S MCU architecture" family
  and family =
    match Xml_decoder.(attribute "family" string xml) with
    | "tinyAVR" -> `Tiny
    | "megaAVR" -> `Mega
    | "xmega" -> `XMega
    | name -> `Unknown name
  and address_spaces =
    Xml_decoder.(child "address-spaces" (children Address_space.of_xml) xml)
  and peripherals =
    Xml_decoder.child "peripherals"
      (Xml_decoder.children Peripheral_module.of_xml)
      xml
  and interrupts =
    Xml_decoder.child "interrupts" (Xml_decoder.children Interrupt.of_xml) xml
  and interfaces =
    Xml_decoder.child "interfaces" (Xml_decoder.children Interface.of_xml) xml
  and property_groups =
    Xml_decoder.child "property-groups"
      (Xml_decoder.children Property_group.of_xml)
      xml
  in

  {
    name;
    architecture;
    family;
    address_spaces;
    peripherals;
    interrupts;
    interfaces;
    property_groups;
  }
