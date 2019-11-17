=((
select  "IssuerName", "ISIN"
from public.listing_task 
where "Section"=' Основной'
