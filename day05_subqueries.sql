/*================================= SUBQUERY =================================
    Sorgu icinde calisan sorguya SUBQUERY (ALT SORGU) denir.
============================================================================*/

CREATE TABLE atom_karincalar
(
id int,
isim varchar(50),
sehir varchar(50),
maas int,
sirket varchar(20)
);
INSERT INTO atom_karincalar VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Honda');
INSERT INTO atom_karincalar VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'Toyota');
INSERT INTO atom_karincalar VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Honda');
INSERT INTO atom_karincalar VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Ford');
INSERT INTO atom_karincalar VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Hyundai');
INSERT INTO atom_karincalar VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Ford');
INSERT INTO atom_karincalar VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Honda');

CREATE TABLE sirketler
(
sirket_id int,
sirket varchar(20),
calisan_sayisi int
);
INSERT INTO sirketler VALUES(100, 'Honda', 12000);
INSERT INTO sirketler VALUES(101, 'Ford', 18000);
INSERT INTO sirketler VALUES(102, 'Hyundai', 10000);
INSERT INTO sirketler VALUES(103, 'Toyota', 21000);

select * from atom_karincalar;
select * from sirketler;

-- ======================== WHERE ile SUBQUERY ===========================
/*----------------------------------------------------------------
 1) Calisan sayisi 15.000'den cok olan sirketlerin isimlerini
 ve bu sirkette calisan personelin isimlerini listeleyin
----------------------------------------------------------------*/

-- 1.adim  Calisan sayisi 15.000'den cok olan sirketlerin isimleri
select sirket
from sirketler
where calisan_sayisi>15000; -- Toyota ve Ford u dondurur

-- 2. Adim : Ford ve Toyota'da calisan personeli listeleyiniz.
SELECT isim,sirket
FROM atom_karincalar
WHERE sirket IN('Toyota','Ford'); 
 
-- 3 adim Calisan sayisi 15.000'den cok olan sirketlerin isimlerini
 -- ve bu sirkette calisan personelin isimlerini listeleyin

SELECT isim,sirket
FROM atom_karincalar
WHERE sirket IN( select sirket
                 from sirketler
                 where calisan_sayisi>15000); -- bu sekilde komutu dinamiklerstirdik
                 
 -- Honda sirketinin personel sayisini 16000 olarak guncelleyiniz
update sirketler
set calisan_sayisi=16000
where sirket='Honda';

/*----------------------------------------------------------------
 2) Sirket_id'si 101'den buyuk olan sirketlerin 
 maaslarini ve sehirlerini listeleyiniz
----------------------------------------------------------------*/
select maas,sehir,sirket
from atom_karincalar
where sirket IN (select sirket
				from sirketler
				where sirket_id>101);
                
/*----------------------------------------------------------------                
  3) Ankara'daki sirketlerin sirket id ve personel 
  sayilarini listeleyiniz.
----------------------------------------------------------------*/

select sirket_id,calisan_sayisi
from sirketler
where sirket IN (SELECT sirket
                 FROM atom_karincalar
                 WHERE sehir='Ankara');
            
/*----------------------------------------------------------------                
  4) Veli Yilmaz isimli personelin calistigi sirketlerin sirket 
  ismini ve personel sayilarini listeleyiniz.
----------------------------------------------------------------*/
select sirket,calisan_sayisi
from sirketler
where sirket in (select sirket
				   from atom_karincalar
				   where isim='Veli Yilmaz');     
                   
 /* ======================== SELECT ile SUBQUERY ===========================
  SELECT ile SUBQUERY kullanimi :
  
-- SELECT -- hangi sutunlari(field) getirsin
-- FROM -- hangi tablodan(table) getirsin
-- WHERE -- hangi satirlari(record) getirsin
  
 * Yazdigimiz QUERY'lerde SELECT satirinda field isimleri kullaniyoruz.
  Dolayisiyla eger SELECT satirinda bir SUBQUERY yazacaksak sonucun
  tek bir field donmesi gerekir.
  
  * SELECT satirinda SUBQUERY yazacaksak SUM, COUNT, MIN, MAX ve AVG gibi 
  fonksiyonlar kullanilir. Bu fonksiyonlara AGGREGATE FUNCTION denir.
=> Interview Question : Subquery'i Select satirinda kullanirsaniz ne ile 
kullanmaniz gerekir?
=========================================================================*/

/*----------------------------------------------------------------
 SORU 1- Her sirketin ismini, personel sayisini ve personelin 
 ortalama maasini listeleyen bir QUERY yazin.
----------------------------------------------------------------*/                  
select * from atom_karincalar;
select * from sirketler;              

select sirket ,calisan_sayisi,(select AVG(maas)
							   from atom_karincalar
							   where atom_karincalar.sirket=sirketler.sirket)ort_maas
from sirketler;

/*----------------------------------------------------------------
SORU 2- Her sirketin ismini ve personelin aldigi max. maasi 
listeleyen bir QUERY yazin.
----------------------------------------------------------------*/

select sirket,(select max(maas)
			  from atom_karincalar
			  where atom_karincalar.sirket=sirketler.sirket)max_maas
from sirketler;

-- dis select formati istenen tablo ic select ise aranan ozellikler

/*----------------------------------------------------------------
SORU 3- Her sirketin id'sini, ismini ve toplam kac sehirde 
bulundugunu listeleyen bir QUERY yaziniz.
----------------------------------------------------------------*/

select sirket_id,sirket,(SELECT COUNT(sehir)
				         FROM atom_karincalar
						WHERE atom_karincalar.sirket = sirketler.sirket)sehir_sayisi
from sirketler;

/*----------------------------------------------------------------
SORU 4- ID'si 101'den buyuk olan sirketlerin id'sini, ismini ve 
toplam kac sehirde bulundugunu listeleyen bir QUERY yaziniz.
----------------------------------------------------------------*/
select sirket_id,sirket,(SELECT COUNT(sehir)
				         FROM atom_karincalar
						WHERE atom_karincalar.sirket = sirketler.sirket)sehir_sayisi
from sirketler
where sirket_id>101;

/*----------------------------------------------------------------
SORU 5- Her sirketin ismini,personel sayisini ve personelin 
aldigi max. ve min. maasi listeleyen bir QUERY yazin.
----------------------------------------------------------------*/    
select sirket,calisan_sayisi, ( SELECT min(maas)
				              FROM atom_karincalar
						      WHERE atom_karincalar.sirket = sirketler.sirket)min_maas,
                             (SELECT max(maas)
				            FROM atom_karincalar
						     WHERE atom_karincalar.sirket = sirketler.sirket)max_maas
from sirketler;

/*----------------------------------------------------------------
SORU 6- Her sirketin ismini ve personel sayisini ve iscilere
odedigi toplam maasi listeleyen bir QUERY yazin.
----------------------------------------------------------------*/   
select * from atom_karincalar;
select * from sirketler;   

select sirket,calisan_sayisi, ( SELECT sum(maas*calisan_sayisi)
				              FROM atom_karincalar
						      WHERE atom_karincalar.sirket = sirketler.sirket)top_maas
from sirketler;

/*----------------------------------------------------------------
SORU 6- Ismi 'H' ile baslayan sirketlerin ismini ve personel sayisini 
ve iscilere odedigi toplam maasi listeleyen bir QUERY yazin.
----------------------------------------------------------------*/ 
select sirket,calisan_sayisi, ( SELECT sum(maas*calisan_sayisi)
				              FROM atom_karincalar
						      WHERE atom_karincalar.sirket = sirketler.sirket)top_maas
from sirketler
where sirket like 'H%';