-- burası yorum satırı
/*
burası da
 yorum 
 paragrafı
*/
/*========================================
    TABLO OLUSTURMA 1 (CRUD - Create)
========================================*/
-- id, isim, not ortalamasi, adres ve son degistirme tarihi
-- fieldlari iceren bir ogrenciler table'i olusturunuz.

Use sys;
CREATE TABLE ogrenciler1(
id CHAR(4),
isim VARCHAR(20),
not_ortalamasi DOUBLE,
adres VARCHAR(100),
son_degistirme_tarihi DATE
);
SELECT * FROM ogrenciler1;

/*------------------------------------------------------------
Q1: "tedarikciler" isminde bir tablo olusturun.
   "tedarikci_id", "tedarikci_ismi", "tedarikci_adres" ve 
   "ulasim_tarihi" field'lari olsun.
-------------------------------------------------------------*/

CREATE TABLE tedarikciler(
tedarikci_id INT(4),
tedarikci_ismi varchar(25),
tedarikci_adres varchar(50),
ulasim_tarihi DATE
);

SELECT * FROM tedarikciler;

/*========================================
    VAROLAN TABLODAN TABLO OLUSTURMA  
========================================
------------------Syntax------------------
CREATE TABLE table_name
AS
SELECT field1,field2
FROM other_table_name
========================================*/
-- ogrenciler1 tablosundan "isim" ve "not_ortalamasi" field'larini
-- alarak ogrenci_derece isimli yeni bir tablo olusturun.

CREATE TABLE ogrenci_derece
AS
SELECT isim,not_ortalamasi
FROM ogrenciler1;

/*--------------------------------------------------------
Q2: "tedarikciler" table'indan "tedarikci_ismi" ve
 "ulasim_tarihi" field'lari olan "tedarikciler_son" 
 isimli yeni bir table olusturun.
---------------------------------------------------------*/
CREATE TABLE tedarikciler_son
AS
SELECT tedarikci_ismi,ulasim_tarihi
FROM tedarikciler;

select * from tedarikciler_son;





