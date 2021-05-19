{
open Lexing
open Printf
open String

let file = Sys.argv.(1)

let cout = open_out (file ^ ".ml")
let print s = fprintf cout s
let lines = ref 1
let colones = ref 0
let commentaire = ref ""

type lexeme =
  | IDENT of string
  | SYMBOLE of string
  | COMMENTAIRE of string 
  | CARACTERS
  | ILLEGAL of int * (int * int)
  | ENTIER of int
  | FUN
exception Eof
}

let digit = ['0' - '9']
let alpha = ['a'-'z' 'A'-'Z']*
let ident = alpha (digit | alpha | '_')*
let fpnumber = digit+

rule token = parse
  | "fun"
  {
    colones := !colones + 3;
    FUN
  }

  | fpnumber as f
  {
    colones := !colones + (String.length f);
    ENTIER (int_of_string f)
  }

  | ident as i
  {
    colones := !colones + (String.length i);
    IDENT i
  }

  | [^' ']* as s
  {
    let debut = !colones in
      colones := !colones + (String.length s);
      ILLEGAL (!lines, (debut, !colones))
  }

  | "(*"
  {
    scan_commentaire lexbuf
  }

  | "/->" as flash
  {
    colones := !colones + 2;
    SYMBOLE flash
  }

  | (' ' | ',' | ';')
  {
    colones := !colones + 1;
    CARACTERS
  }

  | '\n'
  {
    colones := 0;
    lines := !lines + 1;
    CARACTERS
  }


  | ('+' | '(' | ')') as cs
  {
    colones := !colones + 1;
    SYMBOLE (Printf.sprintf "%c" cs)
  }

  | eof
  {
    raise Eof
  }

and scan_commentaire = parse
  | "*)"
  {
    colones := !colones + 2;
    COMMENTAIRE !commentaire
  }
  | '\n'
  {
    colones := 0;
    lines := !lines + 1;
    scan_commentaire lexbuf
  }
  | eof
  {
    raise Eof
  }


{
let print_lexeme lex =
  match lex with
  | IDENT s -> Printf.printf "IDENT %s\n" s
  | ENTIER i -> Printf.printf "ENTIER %d\n" i
  | FUN -> Printf.printf "FUN\n"
  | SYMBOLE s -> Printf.printf "SYMBOLE %s\n" s
  | COMMENTAIRE s -> Printf.printf "COMMENTAIRE %s\n" s
  | ILLEGAL (l, (c1, c2)) -> Printf.printf "ILLEGAL line %d, characters %d-%d\n" l c1 c2
  | CARACTERS -> ()

let () =
let cin = open_in file in
  try
    let lexbuf = Lexing.from_channel cin in
    while true do
      let lex = token lexbuf in
        print_lexeme lex;
    done
  with
    | Eof ->
      close_in cin;
      close_out cout;
      printf "Nombre de lignes de commentaires : %d\n" !lines

}
