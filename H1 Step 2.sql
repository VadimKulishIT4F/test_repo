--Команда добавляет новые стоблцы в таблицу listing_task  исходя из информации об эмитентах,
--которая находится в таблице bond_description_task. (Примечание: новый столбец "IssuerSector" создается несмотря 
--на то, что в таблице bond_description_task данный столбец отсутствует, т.к. в таблице
--bond_description_task  столбец BorrowerSector фактически равнозначен новому стоблцу IssuerSector)

ALTER TABLE listing_task  
add "IssuerName" text,
add "IssuerName_NRD" text,
add "IssuerOKPO" integer,
add "IssuerSector" text;

