(*ex3.1*)
{
  open Lexing
  open Printf 

  let print s = printf "%s" s
  exception Eof
}

let ponctuation = [ ','  '.' '\'']

rule scan_ponctuation = parse 
	| "é"|"â"|"ç" |"ê" |"î" |"ô" 
		{
			let a = lexeme lexbuf in
			print a;
			scan_ponctuation lexbuf
		}

	| [^ ','  '.' '\''] 
		{
			print " ";
			scan_ponctuation lexbuf
		}
	| [ ','  '.' '\'']*
		{
			let s = lexeme lexbuf in 
			print s;
			scan_ponctuation lexbuf

		}

    | eof
      { () }

{
let fct = scan_ponctuation(Lexing.from_channel stdin)
}

      