(* ========== Vaje 6: Dinamično programiranje  ========== *)


(*----------------------------------------------------------------------------*]
 Požrešna miška se nahaja v zgornjem levem kotu šahovnice. Premikati se sme
 samo za eno polje navzdol ali za eno polje na desno in na koncu mora prispeti
 v desni spodnji kot. Na vsakem polju šahovnice je en sirček. Ti sirčki imajo
 različne (ne-negativne) mase. Miška bi se rada kar se da nažrla, zato jo
 zanima, katero pot naj ubere.

 Funkcija [max_cheese cheese_matrix], ki dobi matriko [cheese_matrix] z masami
 sirčkov in vrne največjo skupno maso, ki jo bo miška požrla, če gre po
 optimalni poti.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # max_cheese test_matrix;;
 - : int = 13
[*----------------------------------------------------------------------------*)

let test_matrix = 
  [| [| 1 ; 2 ; 0 |];
     [| 2 ; 4 ; 5 |];
     [| 7 ; 0 ; 1 |] |]

let max_cheese cheese_matrix =
  let dimx = Array.length cheese_matrix in
  let dimy = Array.length cheese_matrix.(0) in
  let rec best_path x y =
    let current_cheese = cheese_matrix.(x).(y) in
    let best_right = if (x+1 = dimx) then 0 else best_path (x+1) y in
    let best_down = if (y+1 = dimy) then 0 else best_path x (y+1) in
    current_cheese + max best_right best_down
  in
  best_path 0 0

(*----------------------------------------------------------------------------*]
 Rešujemo problem sestavljanja alternirajoče obarvanih stolpov. Imamo štiri
 različne tipe gradnikov, dva modra in dva rdeča. Modri gradniki so višin 2 in
 3, rdeči pa višin 1 in 2.

 Funkcija [alternating_towers] za podano višino vrne število različnih stolpov
 dane višine, ki jih lahko zgradimo z našimi gradniki, kjer se barva gradnikov
 v stolpu izmenjuje (rdeč na modrem, moder na rdečem itd.). Začnemo z gradnikom
 poljubne barve.

 Namig: Uporabi medsebojno rekurzivni pomožni funkciji z ukazom [and].
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # alternating_towers 10;;
 - : int = 35
[*----------------------------------------------------------------------------*)

let alternating_towers height =
  let rec redtop height =
    if height <= 0 then 
      0
    else if height <= 2 then 
      1
    else
      bluetop (height-1) + bluetop (height-2)
  and bluetop height =
    if height <= 0 then 
      0
    else if height = 2 then 
      1
    else if height = 3 then 
      2
    else
      redtop (height-2) + redtop (height-3)
  in
  redtop height + bluetop height
