-- код возвращает только имена эмитентов и ISIN код бумаг которые торгруются в режиме основной на мосбирже  =((
select  "IssuerName", "ISIN"
from public.listing_task 
where "Section"=' Основной' or "Section"=' МБ Основной Т+' or "Section"=' МБ Основной Т+'

-- Комментарий:
-- Все получится!