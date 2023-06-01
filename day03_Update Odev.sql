/*-------------------------------------------------------------------------
1) Lise tablosu olusturun.
 Icinde id,isim,veli_isim ve grade field'lari olsun. 
 Id field'i Primary Key olsun.
 --------------------------------------------------------------------------*/
 create table lise(
 id int PRIMARY KEY,
 isim CHAR(20),
 veli_isim VARCHAR(20),
 grade double
 );
SELECT * FROM LISE;
 /*-------------------------------------------------------------------------
 2)  Kayitlari tabloya ekleyin.
 (123, 'Ali Can', 'Hasan',75), 
 (124, 'Merve Gul', 'Ayse',85), 
 (125, 'Kemal Yasa', 'Hasan',85),
 (126, 'Rumeysa Aydin', 'Zeynep',85);
 (127, 'Oguz Karaca', 'Tuncay',85);
 (128, 'Resul Can', 'Tugay',85);
 (129, 'Tugay Kala', 'Osman',45);
 --------------------------------------------------------------------------*/
  INSERT INTO LISE values
 (123, 'Ali Can', 'Hasan',75), 
 (124, 'Merve Gul', 'Ayse',85), 
 (125, 'Kemal Yasa', 'Hasan',85),
 (126, 'Rumeysa Aydin', 'Zeynep',85),
 (127, 'Oguz Karaca', 'Tuncay',85),
 (128, 'Resul Can', 'Tugay',85),
 (129, 'Tugay Kala', 'Osman',45);
 /*-------------------------------------------------------------------------
3)deneme_puani tablosu olusturun. 
ogrenci_id, ders_adi, yazili_notu field'lari olsun, 
ogrenci_id field'i Foreign Key olsun 
--------------------------------------------------------------------------*/
create table deneme_puani(
 ogrenci_id INT,
 ders_adi VARCHAR(10),
 yazili_notu INT,
 constraint deneme_fk FOREIGN KEY (ogrenci_id)
 references lise(id)
 );
/*-------------------------------------------------------------------------
4) deneme_puani tablosuna kayitlari ekleyin
 ('123','kimya',75), 
 ('124','fizik',65),
 ('125','tarih',90),
 ('126','kimya',87),
 ('127','tarih',69),
 ('128','kimya',93),
 ('129','fizik',25)
--------------------------------------------------------------------------*/
INSERT INTO deneme_puani values
('123','kimya',75), 
 ('124','fizik',65),
 ('125','tarih',90),
 ('126','kimya',87),
 ('127','tarih',69),
 ('128','kimya',93),
 ('129','fizik',25);
 
 select * from lise;
 select * from deneme_puani;
/*-------------------------------------------------------------------------
5) Ismi Resul Can olan ogrencinin grade ini deneme_puani tablosundaki 
ogrenci id'si 129 olan yazili notu ile update edin. 
--------------------------------------------------------------------------*/
update lise
set grade=(select yazili_notu
           from deneme_puani
           where ogrenci_id=129)
where isim='Resul Can';


/*-------------------------------------------------------------------------
6) Ders adi fizik olan kayitlarin yazili notunu Oguz Karaca'nin grade'i
ile update edin. 
--------------------------------------------------------------------------*/
update deneme_puani
set yazili_notu=(select grade
                from lise
                where isim='Oguz Karaca')
where ders_adi='Fizik';


/*-------------------------------------------------------------------------
7) Ali Can'in grade'ini, 124 ogrenci_id'li yazili_notu ile guncelleyin.
--------------------------------------------------------------------------*/
update lise
set grade=(select yazili_notu
                from deneme_puani
                where ogrenci_id=124)
where isim='Ali Can';
/*-------------------------------------------------------------------------
8) Ders adi Kimya olan yazili notlarini Rumeysa Aydin'in 
grade'i ile guncelleyin.
--------------------------------------------------------------------------*/
update deneme_puani
set yazili_notu=(select grade
                from lise
                where isim='Rumeysa Aydin')
where ders_adi='Kimya';

/*-------------------------------------------------------------------------
9) Ders adi tarih olan yazili notlarini Resul Can'in 
grade'i ile guncelleyin.
--------------------------------------------------------------------------*/
update deneme_puani
set yazili_notu=(select grade
                from lise
                where isim='Resul Can')
where ders_adi='Tarih';
/*-------------------------------------------------------------------------
10) Ders adi fizik olan yazili notlarini veli adi Tuncay olan 
grade ile guncelleyin.
--------------------------------------------------------------------------*/
update deneme_puani
set yazili_notu=(select grade
                from lise
                where veli_isim='Tuncay')
where ders_adi='Fizik';

 select * from lise;
 select * from deneme_puani;
 
 /*-------------------------------------------------------------------------
11) Tum cocuklarin gradelerini deneme_puani tablosundaki yazili_notu ile update edin. 
--------------------------------------------------------------------------*/
update lise
set grade=( select yazili_notu
			from deneme_puani
			where deneme_puani.ogrenci_id=lise.id);


-- ************************************************************************
/*------------------------------------------------------------------------
Mart_satislar isimli bir tablo olusturun, 
icinde urun_id, musteri_isim, urun_isim ve urun_fiyat field'lari olsun
1) Ismi hatice olan musterinin urun_id'sini 30,urun_isim'ini Ford yapin 
2) Toyota marka araclara %10 indirim yapin 
3) Ismi Ali olanlarin urun_fiyatlarini %15 artirin 
4) Honda araclarin urun id'sini 50 yapin.
--------------------------------------------------------------------------*/
CREATE TABLE mart_satislar 
(
 urun_id int,
 musteri_isim varchar(20),
 urun_isim varchar(10),
 urun_fiyat int 
);
INSERT INTO mart_satislar VALUES (10, 'Ali', 'Honda',75000); 
INSERT INTO mart_satislar VALUES (10, 'Ayse', 'Honda',95200); 
INSERT INTO mart_satislar VALUES (20, 'Hasan', 'Toyota',107500); 
INSERT INTO mart_satislar VALUES (30, 'Mehmet', 'Ford', 112500); 
INSERT INTO mart_satislar VALUES (20, 'Ali', 'Toyota',88000); 
INSERT INTO mart_satislar VALUES (10, 'Hasan', 'Honda',150000); 
INSERT INTO mart_satislar VALUES (40, 'Ayse', 'Hyundai',140000); 
INSERT INTO mart_satislar VALUES (20, 'Hatice', 'Toyota',60000);
SELECT * FROM mart_satislar;
-- 1) Ismi hatice olan musterinin urun_id'sini 30,urun_isim'ini Ford yapin 
update mart_satislar
set urun_id=30,urun_isim='Ford'
where musteri_isim='hatice';

-- 2) Toyota marka araclara %10 indirim yapin 

update mart_satislar
set urun_fiyat=(urun_fiyat*0.9)
where urun_isim='Toyota';

-- 3) Ismi A ile baslayan butun musterilerin urun_fiyatlarini %15 artirin
update mart_satislar
set urun_fiyat=(urun_fiyat*1.15)
where musteri_isim LIKE 'a%';

-- 4) Honda araclarin urun id'sini 50 yapin.
update mart_satislar
set urun_id=50
where urun_isim='Honda';













