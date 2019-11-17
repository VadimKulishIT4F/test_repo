--Команда добавляет новые стоблцы в таблицу listing_task  исходя из информации об эмитентах,
--которая находится в таблице bond_description_task. (Примечание: новый столбец "IssuerSector" создается несмотря 
--на то, что в таблице bond_description_task данный столбец отсутствует, т.к. в таблице
--bond_description_task  столбец BorrowerSector фактически равнозначен новому стоблцу IssuerSector)

ALTER TABLE public.listing_task  
add "IssuerName" text,
add "IssuerName_NRD" text,
add "IssuerOKPO" integer,
add "IssuerSector" text;

--  Для проверки добавления столбцов можно выполнить данную команду

SELECT * FROM public.listing_task;


--  Данная команда добавляет данные данные из таблицы bond_description_task  в созданные стоблцы из предыдущего пункта

UPDATE public.listing_task
SET "IssuerName"=public.bond_description_task."IssuerName",
"IssuerName_NRD"=public.bond_description_task."IssuerName_NRD",
"IssuerOKPO"=public.bond_description_task."IssuerOKPO",
"IssuerSector"=public.bond_description_task."BorrowerSector"
FROM public.bond_description_task
WHERE listing_task."ISIN"=public.bond_description_task."ISIN, RegCode, NRDCode";
 
 --  Для проверки добавления данных можно данную команду

SELECT * FROM public.listing_task;

-- Команда добавляет новые столбцы в таблицу listing_task исходя из информации о площадке, 
--которая находитсся в таблице quotes_task

ALTER TABLE public.listing_task 
ADD "BOARDID" TEXT,
ADD "BOARDNAME" VARCHAR;

-- Для проверки добавления столбцов выполним данную команду
SELECT * FROM public.listing_task;

-- Данная команда добавляет данные данные из таблицы quotes_task  в созданные стоблцы из предыдущего пункта

UPDATE PUBLIC.listing_task
SET "BOARDID" = PUBLIC.quotes_task."BOARDID",
"BOARDNAME" = PUBLIC.quotes_task."BOARDNAME"
FROM PUBLIC.quotes_task
WHERE PUBLIC.listing_task."ID" = PUBLIC.quotes_task."ID";

 --  Для проверки добавления данных можно данную команду

SELECT * FROM public.listing_task;

