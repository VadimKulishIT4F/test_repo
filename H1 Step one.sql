-- Видим что данные в экселе, поэтому для импорта сохраняем  файлы в формате CSV (файл/сохранить как)
--(Для преподавателя - при импорте данных из файла bond_description_task была ошибка в столбцах HaveOffer, AmortisedMty и IsConvertible. 
--по одному эмитенту данные в этих столбцах были в форме даты, а не boolean как в остальных строках,
--по умолчанию проставлены вручную нулевые значения).

-- Создаем первую таблицу bond_description_task  с нужными форматом и нужным количеством полей.
DROP TABLE if exists public.bond_description_task;
CREATE TABLE public.bond_description_task
(
   "ISIN, RegCode, NRDCode" varchar(12),
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


--Команда импортирует данные в созданную таблицу. Выполнять через терминал  SQL Shell,
--так как в другом способе могут возникнуть проблемы с доступом к файлу

\copy public.bond_description_task FROM 'C:/data/bond_description_task.csv' DELIMITER ';' CSV HEADER ENCODING 'WIN 1251';
