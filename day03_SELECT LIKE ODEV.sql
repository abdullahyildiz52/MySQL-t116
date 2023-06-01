-- ************************ Kelimeler Tablosundan *******************************
/*-------------------------------------------------------------------------
Q1: 3 harfli kelimeleri listeleyin
---------------------------------------------------------------------------*/
select kelime
from kelimeler
where kelime LIKE '___';
/*-------------------------------------------------------------------------
Q2: En az 3 harfli kelimeleri listeleyin
---------------------------------------------------------------------------*/
select kelime
from kelimeler
where kelime LIKE '__%';
/*-------------------------------------------------------------------------
Q3: H ile baslayip t ile biten kelimeleri listeleyin
---------------------------------------------------------------------------*/
select kelime
from kelimeler
where kelime LIKE 'h%t';
/*-------------------------------------------------------------------------
Q4: H ile baslayip t ile biten kelimeleri case sensitive listeleyin
---------------------------------------------------------------------------*/
select kelime
from kelimeler
where REGEXP_LIKE (kelime, '^H.*t$', 'c')
/*-------------------------------------------------------------------------
Q5: H ile baslayip T ile biten 3 harfli kelimeleri case sensitive listeleyin
---------------------------------------------------------------------------*/
select kelime
from kelimeler
where REGEXP_LIKE (kelime, '^H[!-~]T', 'c')
/*-------------------------------------------------------------------------
Q6: 3 ya da daha az karakterli kelimeleri listeleyin
---------------------------------------------------------------------------*/
select kelime
from kelimeler
where kelime not LIKE '____%';
/*-------------------------------------------------------------------------
Q7: id'si 8 rakamini iceren kelimeleri listeleyin
---------------------------------------------------------------------------*/
select kelime,id
from kelimeler
where id LIKE '%8%';