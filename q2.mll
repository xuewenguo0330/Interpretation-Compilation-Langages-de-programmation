{
	open Lexing
	open Printf
	open Hashtbl
	open Char

	let file = Sys.argv.(1)
	let cout = open_out (file^ "q2.cpp")

	let print s = fprintf cout s
	let lines = ref 0
	let tab = Hashtbl.create 10
	let name = ref ""
	let valeur = ref ""
	exception Eof 
}

let def = "#define"
let alpha = ['A'-'Z' 'a'-'z']
let digit = ['0'-'9']
let ident = alpha (digit | alpha | ' ')*
let decimals = '.' digit*
let exponent = ['e' 'E'] ('-')? digit+ 
let fnumber = digit+ (decimals | decimals? exponent)
let chaine ='"'[^'"']*'"'

rule scan_define = parse
	|def as d
	{
		print "%s" d ;
		def_ident lexbuf 
	}
	|ident as i 
	{
		if Hashtbl.mem tab i then 
			print "%s" (Hashtbl.find tab i)
		else 
			print "%s" i;
			scan_define lexbuf
	}

	|[^'\n'] as c
	{ print "%c" c;
     scan_define lexbuf
    }

    |'\n'
 	{ print "%c" '\n';
  	 scan_define lexbuf
  	}

  	|eof{raise Eof}

and def_ident = parse 
	|ident as i
	{
		print "%s" i ;
		Hashtbl.add tab i "";
		name := i;
		valeur := "";
		scan_text lexbuf 
	}
	|" " as e
	{
		print "%c" e;
		def_ident lexbuf
	}

   |eof {()}

and scan_text = parse
    |(digit+ | fnumber | chaine | ident)
    {
    let v = lexeme lexbuf in
    	print "%s" v;
    let cc = !valeur in
    	if Hashtbl.mem tab v then  
      		let vv = Hashtbl.find tab v in
        		valeur := cc^vv
     	else
        	valeur := cc^v;    
     	scan_text lexbuf
    }

    |" " as e
    {
		print "%c" e;
		def_ident lexbuf
	}

	|[^' ''\n'] as c
    { print "%c" c;
      valeur := !valeur ^ (Char.escaped c);
      scan_text lexbuf
    }

    |'\n'
    {
    print "%c" '\n';
    if Hashtbl.mem tab !name
       then
       Hashtbl.replace tab !name !valeur
     else begin 
       Printf.eprintf"no name found for the value %s" !valeur
     end;
     
     scan_define lexbuf
    }
   
   |eof   {raise Eof}

{
let f a b =
  Printf.printf "%s - %s\n" a b;;

let () =
let cin = open_in file in
  try
    let lexbuf = Lexing.from_channel cin in
    while true do
      let _ = scan_define lexbuf in ()
    done
  with
    | Eof ->
      close_in cin;
      close_out cout;
      Hashtbl.iter f tab;

}










