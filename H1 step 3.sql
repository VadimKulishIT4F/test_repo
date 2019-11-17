-- Все 3 таблицы связаны между собой через международный идентификационный код ценной бумаги, но проблема в том, что
-- по некоторым бумагам которые котируются нет соответствующего ISIN в таблицы листинг,
--и не по всем листингуемым ценным бумагам есть котировки, связать данные две таблицы проблематично (йа нимаааааагуууу)
-- таблицу с описанием бумаг и с информацией о листинге можно связать через ISIN, 
--т.к все бумаги по которым есть описание также полностью есть информация о листинге
--для этого попробуем добавить столбец "SecurityID" в таблицу описания бумаг и поместить в него "ID" из таблицы с листингом,
--при этом, чтобы "ISIN"  в этих таблицах должен соответствовать
--затем зададим данному столбцу ограничение внешнего ключа

ALTER TABLE public.bond_description_task add "SecurityID" integer;
UPDATE public.bond_description_task
SET "SecurityID" = public.listing_task."ID"
FROM public.listing_task
WHERE public.listing_task."ISIN" = public.bond_description_task."ISINCode";
ALTER TABLE public.bond_description_task 
ADD CONSTRAINT fr_key_1 FOREIGN KEY ("SecurityID") REFERENCES public.listing_task ("ID");
