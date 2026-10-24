let () =
  let atdf_dir = Sys.argv.(1) in

  print_endline "open Atdf;;\n";

  let mcus = ref [] in

  Sys.readdir atdf_dir
  |> Array.iter begin fun filename ->
      if String.ends_with ~suffix:".atdf" filename then begin
        let mcu_name = Filename.chop_extension filename in
        mcus := mcu_name :: !mcus;

        let atdf_file =
          Xml.parse_file (Filename.concat atdf_dir filename) |> Atdf.File.of_xml
        in

        Format.printf "let %s = (%a);;" mcu_name Atdf.File.pp atdf_file
      end
    end;

  print_string "let mcus = [";
  List.iter (fun mcu_name -> Printf.printf "(%S, %s);" mcu_name mcu_name) !mcus;
  print_endline "];;";

  print_endline {|
  let find name = List.assoc name mcus;;
  |};

  ()
