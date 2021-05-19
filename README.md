# Interpretation-Compilation-Langages-de-programmation 
interprétation
 <br>
     c'est-à-dire l'écriture d'une fonction qui prend en entrée un programme (donné par son code source) et 
     ses éventuels arguments et renvoie le résultat de l'exécution du programme
 <br>
 compilation
 <br>
 c'est-à-dire l'écriture d'une fonction qui prend entrée un programme (donné par son code source) et 
     produit un programme équivalent écrit dans un autre langage.
 <br>
*** 
Fichier q1 : <br>
A l’aide d’ocamllex, un programme qui prend en entrée un texte et l’affiche en ne montrant que les ponctuations, chaque lettre ´etant simplement remplacée par une espace.

*** 
Fichier q2 : <br>
Un programme qui transforme un fichier source C en appliquant ses directives #define


*** 
Fichier q3 : <br>
Un programme qui prend en entrée un fichier source C et affiche son contenu en prenant intégralement en charge la bonne indentation du code.
Votre programme doit donc ignorer tous les retraits déjà présents, pour afficher à la place des
retraits calculés sur la base du critère suivant : toute accolade ouvrante augmente le niveau de
retrait, et toute accolade fermante ramène le retrait au niveau précédent.

*** 
Fichier q4 : <br>
Un analyseur lexical pour le fragment de caml composé:<br>
— des identifiants<br>
— des nombres entiers<br>
— du mot clé fun<br>
— des symboles ->, +, (, )<br>
— des commentaires délimit´es par (* et *), éventuellement imbriqués<br>
L’analyseur doit d´efinir un type pour les lexèmes, et une règle token qui renvoie le prochain
lexème reconnu.
