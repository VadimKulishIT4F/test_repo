-- Данный скрипт можно запускать либо в pgAdmin, либо в SQL Shell (psql).
-- Видим что данные в экселе, поэтому для импорта сохраняем  файлы в формате CSV(файл/сохранить как),
--предварительно откорректировав каждый файл.

-- Создаем первую таблицу bond_description_task  с нужными форматом и нужным количеством полей, предварительно удаляем старую версию таблицы
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
	"GuaranteeType" text,
	"GuaranteeAmount" text,
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
--сохраним файл в формате CSV.

--Команда импортирует данные в созданную таблицу. Выполнять через терминал  SQL Shell,
--так как в другом способе могут возникнуть проблемы с доступом к файлу
--'WIN 1251' мы используем , потому что в файлах присутствует кириллица.

\copy public.bond_description_task FROM 'C:/data/bond_description_task.csv' DELIMITER ';' CSV HEADER ENCODING 'WIN 1251';


--  Создаем таблицу quotes_task  с нужными форматом и нужным количеством полей, предварительно удаляем старую версию таблицы.
-- Отметим, что "ID" и "ISIN"  являются внешними ключами к данной таблице

DROP TABLE if exists public.quotes_task;
CREATE TABLE public.quotes_task
(
    "ID" integer NOT NULL,
    "TIME" integer NOT NULL,
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
    "DEAL_ACC" smallint,
    "FACEVALUE" smallint,
    "ISIN" character varying COLLATE pg_catalog."default",
    "ISSUER" character varying COLLATE pg_catalog."default",
    "ISSUESIZE" integer,
    "MAT_DATE" date,
    "MPRICE" real,
    "MPRICE2" real,
    "SPREAD" real,
    "VOL_ACC" integer,
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
--затем открыть файл quotes_task и сохранить в формате CSV, предварительно удалив лист fields.

--Команда импортирует данные в созданную таблицу. Выполнять через терминал  SQL Shell,
--так как в другом способе могут возникнуть проблемы с доступом к файлу 
-- 'WIN 1251' мы используем , потому что в файлах присутствует кириллица.
\copy public.quotes_task FROM 'C:/data/quotes_task.csv' DELIMITER ';' CSV HEADER ENCODING 'WIN 1251';
