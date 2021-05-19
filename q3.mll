{
  
open Lexing
open Printf
open String

let file = Sys.argv.(1)

let cout = open_out (file ^ "q3.c")
let print s = fprintf cout s

let lines = ref 1
let retrait = ref 0
let indexCharecter = ref 1
let indexParent = ref 0

let rec print_retrait x =
  if x = 0 then
    begin
    end
  else
    begin
      print "%c" '\t';
      print_retrait (x-1);
    end

let rec print_parent x =
  if x = 0 then
    begin
    end
  else
    begin
      print "%c" ' ';
      print_parent (x-1);
    end

exception Eof
}

let string = '"' [^'"'] '"'

rule scan_text = parse
  | string as s
  {
    print "%s" s;
    scan_text lexbuf
  }
  | '{'
  {
    print "%c" '{';
    retrait := !retrait + 1;
    scan_text lexbuf
  }
  | '\n' [' ']* ['\t']* ')'
  {
    print "%c" '\n';
    print_retrait (!retrait);
    print_parent (!indexParent);
    print "%c" ')';
    indexParent := 0;
    scan_text lexbuf
  }
  | '\n' [' ']* ['\t']* '}'
  {
    retrait := !retrait - 1;
    print "%c" '\n';
    print_retrait (!retrait);
    print_parent (!indexParent);
    indexCharecter := 2;
    lines := !lines + 1;
    print "%c" '}';
    scan_text lexbuf
  }
  | '}'
  {
    print "%c" '}';
    retrait := !retrait - 1;
    scan_text lexbuf
  }
  | '\n' [' ']* ['\t']*
  {
    print "%c" '\n';
    print_retrait (!retrait);
    print_parent (!indexParent);
    indexCharecter :=  1;
    lines := !lines + 1;
    scan_text lexbuf
  }
  | '('
  {
    print "%c" '(';
    indexParent := !indexCharecter;
    scan_text lexbuf
  }
  | ')'
  {
    print "%c" ')';
    indexParent := 0;
    scan_text lexbuf
  }
  | [^'\n'] as c
  {
    print "%c" c;
    indexCharecter := !indexCharecter + 1;
    scan_text lexbuf
  }
  | eof
  {
    raise Eof
  }


{
let () =
let cin = open_in file in
  try
    let lexbuf = Lexing.from_channel cin in
    while true do
      let _ = scan_text lexbuf in ()
    done
  with
    | Eof | _ ->
      close_in cin;
      close_out cout;
}
