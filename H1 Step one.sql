-- Данный скрипт можно запускать либо в pgAdmin, либо в SQL Shell (psql).
-- Видим что данные в экселе, поэтому для импорта сохраняем  файлы в формате CSV(файл/сохранить как),
--предварительно откорректировав данные в  каждом файле.

-- Создаем первую таблицу bond_description_task  с нужными форматом и нужным количеством полей 
---предварительно удаляем старую версию таблицы
--(некоторые столбцы таблицы спрятаны, нужно выделить все столбцы таблицы  в excel файле, затем правая кнопка мыши, нажать отобразить)


DROP TABLE if exists public.bond_description_task;
CREATE TABLE public.bond_description_task
(
   "ISIN, RegCode, NRDCode" varchar(12) NOT NULL,
	"FinToolType" text,
	"SecurityType" text,
	"SecurityKind" text,
	"CouponType" text,
	"RateTypeNameRus_NRD" text,
	"CouponTypeName_NRD" text,
	"HaveOffer" boolean,
	"AmortisedMty" boolean,
	"MaturityGroup" text,
	"IsConvertible" boolean,
	"ISINCode" varchar (12),
	"Status" text,
	"HaveDefault" boolean,
        "IsLombardCBR_NRD" boolean,
        "IsQualified_NRD" boolean,
        "ForMarketBonds_NRD" boolean,
        "MicexList_NRD" text COLLATE pg_catalog."default",
        "Basis" text COLLATE pg_catalog."default",
        "Basis_NRD" text COLLATE pg_catalog."default",
        "Base_Month" text COLLATE pg_catalog."default",
        "Base_Year" text COLLATE pg_catalog."default",
        "Coupon_Period_Base_ID" bigint,
        "AccruedintCalcType" boolean,
        "IsGuaranteed" boolean,
	"GuaranteeType" text,
	"GuaranteeAmount" text,
	"GuarantVal" bigint,
	"Securitization" text COLLATE pg_catalog."default",
        "CouponPerYear" integer,
        "Cp_Type_ID" integer,
        "NumCoupons" integer,
        "NumCoupons_M" integer,
        "NumCoupons_NRD" integer,
        "Country" text COLLATE pg_catalog."default",
        "FaceFTName" text COLLATE pg_catalog."default",
        "FaceFTName_M" integer,
        "FaceFTName_NRD" text COLLATE pg_catalog."default",
        "FaceValue" real,
        "FaceValue_M" integer,
        "FaceValue_NRD" real,
        "CurrentFaceValue_NRD" real,
	"BorrowerName" text,
	"BorrowerOKPO" integer,
	"BorrowerSector" text,
	"BorrowerUID" integer,
	"IssuerName" text,
	"IssuerName_NRD" text,
	"IssuerOKPO" integer,
	"NumGuarantors" smallint,
	"EndMtyDate" date,
	CONSTRAINT bond_description_task_pkey PRIMARY KEY ("ISIN, RegCode, NRDCode")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

-- команда назначает владельца таблицы 

ALTER TABLE public.bond_description_task
    OWNER to postgres;

--(при импорте данных из файла bond_description_task была ошибка в столбцах HaveOffer, AmortisedMty и IsConvertible по 133 строке. 
-- в 133 строке данные в этих столбцах были типа date, а не boolean как в остальных строках,
--заменим формат в данных ячейках на текстовый, получим HaveOffer = 1, AmortisedMty = 0, IsConvertible = 0 в 133 строке
-- в столбце GuarantVal заменим формат на числовой, 0 чисел после запятой т.к. данные отражаются некорректно.
-- даллее сохраняем файл в формате CSV.

--Команда импортирует данные в созданную таблицу. Выполнять через терминал  SQL Shell,
--так как в другом способе могут возникнуть проблемы с доступом к файлу
--'WIN 1251' мы используем , потому что в файлах присутствует кириллица.

\copy public.bond_description_task FROM 'C:/data/bond_description_task.csv' DELIMITER ';' CSV HEADER ENCODING 'WIN 1251';


--  Создаем таблицу quotes_task  с нужными форматом и нужным количеством полей, предварительно удаляем старую версию таблицы.
-- Отметим, что "ID"(listing_task) и "ISIN"(bond_description_task)  являются внешними ключами к данной таблице
--(только задать их я не смог почему-то...)

DROP TABLE if exists public.quotes_task;
CREATE TABLE public.quotes_task
(
    "ID" integer NOT NULL,
    "TIME" date NOT NULL,
    "ACCRUEDINT" real,
    "ASK" real,
    "ASK_SIZE" integer,
    "ASK_SIZE_TOTAL" integer,
    "AVGE_PRCE" real,
    "BID" real,
    "BID_SIZE" integer,
    "BID_SIZE_TOTAL" integer,
    "BOARDID" text COLLATE pg_catalog."default",
    "BOARDNAME" character varying COLLATE pg_catalog."default",
    "BUYBACKDATE" timestamp without time zone,
    "BUYBACKPRICE" real,
    "CBR_LOMBARD" real,
    "CBR_PLEDGE" real,
    "CLOSE" real,
    "CPN" real,
    "CPN_DATE" date,
    "CPN_PERIOD" smallint,
    "DEAL_ACC" integer,
    "FACEVALUE" real,
    "ISIN" character varying COLLATE pg_catalog."default",
    "ISSUER" character varying COLLATE pg_catalog."default",
    "ISSUESIZE" bigint,
    "MAT_DATE" date,
    "MPRICE" real,
    "MPRICE2" real,
    "SPREAD" real,
    "VOL_ACC" bigint,
    "Y2O_ASK" real,
    "Y2O_BID" real,
    "YIELD_ASK" real,
    "YIELD_BID" real
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

--Команда назначает владельца таблицы

ALTER TABLE public.quotes_task
    OWNER to postgres;
 
--(для импорта данных из файла quotes_task необходимо сначала  настроить excel, убрав галочку
--c "использовать системные разделители"  и поставить точку вместо запятой (параметры excel/дополнительно)
--затем открыть файл quotes_task,  в столбцах VOL_ACC и ISSUESIZE данные отражаются некорректно
--ставим формат столбцов числовой, 0 чисел после запятой
-- в столбцах BAYBACKDATE и TIME  ставим формат дату, т.к. данные некорректно отражаются. 
--сохраняем файл в формате CSV, предварительно удалив лист fields.

--Команда импортирует данные в созданную таблицу. Выполнять через терминал  SQL Shell,
--так как в другом способе могут возникнуть проблемы с доступом к файлу 
-- 'WIN 1251' мы используем , потому что в файлах присутствует кириллица.

\copy public.quotes_task FROM 'C:/data/quotes_task.csv' DELIMITER ';' CSV HEADER ENCODING 'WIN 1251';


-- Создаем таблицу quotes_task  с нужными форматом и нужным количеством полей, предварительно удаляем старую версию таблицы.
--Отметим, что ISIN(bond_description_task) является внешним ключом к данной таблице.

DROP TABLE if exists public.listing_task;
CREATE TABLE public.listing_task
(
    "ID" integer NOT NULL,
    "ISIN" character varying COLLATE pg_catalog."default",
    "Platform" text COLLATE pg_catalog."default",
    "Section" text COLLATE pg_catalog."default",
    CONSTRAINT listing_task_pkey PRIMARY KEY ("ID")
)
TABLESPACE pg_default;

-- Команда назначает владельца таблицы

ALTER TABLE public.listing_task
    OWNER to postgres;
    
--сохраняем excel файл в формате CSV для импорта данных.
--Команда импортирует данные в созданную таблицу. Выполнять через терминал  SQL Shell,
--так как в другом способе могут возникнуть проблемы с доступом к файлу 
-- 'WIN 1251' мы используем , потому что в файлах присутствует кириллица.

\copy public.listing_task FROM 'C:/data/listing_task.csv' DELIMITER ';' CSV HEADER ENCODING 'WIN 1251';

-- в результате всех операций должны получиться таблицы:
--listing_task - 20 680 строк
--bond_description_task - 2 934 строк
--quotes_task - 1 047 800 строк.
