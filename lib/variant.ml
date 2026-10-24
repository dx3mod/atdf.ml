type t = {
  order_code : string;
  package : string;
  pinout : string;
  speed_max : int;
  vcc : float * float;
  temperature : int * int;
}

let of_xml xml =
  Xml_decoder.assert_element "variant" xml;

  let order_code = Xml_decoder.(attribute "ordercode" string xml)
  and temperature =
    Xml_decoder.(attribute "tempmin" int xml, attribute "tempmax" int xml)
  and speed_max = Xml_decoder.(attribute "speedmax" int xml)
  and pinout = Xml_decoder.(attribute "pinout" string xml)
  and package = Xml_decoder.(attribute "package" string xml)
  and vcc =
    Xml_decoder.(attribute "vccmin" float xml, attribute "vccmax" float xml)
  in

  { order_code; package; pinout; speed_max; vcc; temperature }
