1.Questions to be answered: 

 --NOTE: It's very important to remark, when the function "Group by" is used, "the field" which is grouped, must be included in the Select as well

a) Youngest player per country and oldest player per country.

SELECT MIN("Player Age") as minimo_edad, MAX("Player Age") as maximo_edad, "Country Moving to"
FROM public.jugadores
where "Country Moving to" is not null
group by "Country Moving to"
order by "Country Moving to"

b) Average age of the players.

SELECT AVG("Player Age") as media_edad
FROM public.jugadores


c) Transferences of players per position.

SELECT "Player Position", count(*) as count_transfer
FROM public.jugadores
group by "Player Position"
order by count_transfer desc

d) --Which is the market value or price of the most expensive player, according to the dataset?

SELECT  MAX("Player Market Value (M)") as maximo_mercado
FROM public.jugadores

e)--Name of the most expensive player (transference) according to the dataset.

SELECT "Player Name", MAX("Fees Paid for Player (M)") as count_paid
from public.jugadores
group by "Player Name"
order by count_paid desc
limit 1

f) --Name of the best paid players (transferences) per position according to the dataset. 
WITH ranked as(
SELECT "Player Name","Player Position", "Fees Paid for Player (M)",
DENSE_RANK() OVER(PARTITION BY "Player Position"  ORDER BY "Fees Paid for Player (M)"  DESC) AS rank_player
FROM public.jugadores
)
select "Player Name","Player Position", rank_player, "Fees Paid for Player (M)"
from ranked
where rank_player = 1 	
order by "Player Position"


g) --"Which Premier League clubs have signed new players according to the dataset?"

SELECT   "Club Moving to"
FROM public.jugadores
where "New League" = 'Premier League' AND
"On Loan" = 'No'
group by "Club Moving to"
order by "Club Moving to"


h) --"How many players are under 18 years old and in which country will they be playing?"

WITH ranked as(
SELECT "Player Name","Country Moving to", "Player Age",
DENSE_RANK() OVER(PARTITION BY "Country Moving to" ORDER BY "Player Age" asc) AS rank_player_age
FROM public.jugadores
where "Player Age" < 18
)
select "Player Name","Country Moving to", "Player Age", rank_player_age
from ranked
where rank_player_age = 1 	
order by "Country Moving to"



2. Additional questions: 

a) Total paid per country per transferences

SELECT  "Country Moving to", sum("Fees Paid for Player (M)") AS total_pais
FROM public.jugadores
where "Fees Paid for Player (M)" <> 0
group by "Country Moving to"
order by total_pais desc


b) --Which is the most expensive position in the market?

SELECT  "Player Position ", "Player Market Value (M))"
FROM public.jugadores
order by "Player Market Value (M))" desc
limit 1

c) --Which is the most expensive position paid per transferences?

SELECT  "Player Position", "Player Market Value (M)"
FROM public.jugadores
order by "Player Market Value (M)" desc
limit 1

d) --The 5 countries with the most transfers in this season?

SELECT "Country Moving to", count(*) as count_transfer
FROM public.jugadores
group by"Country Moving to"
order by count_transfer desc
limit 5


e) --The 5 clubs with the most transfers in this season?

SELECT "Club Moving to", count(*) as count_transfer
FROM public.jugadores
group by "Club Moving to"
order by count_transfer desc
limit 5
 
f) --The 5 leagues with the most transfers in this season?

SELECT "New League", count(*) as count_transfer
FROM public.jugadores
group by "New League"
order by count_transfer desc
limit 5

g) Average paid per positon?

SELECT  "Player Position", round(AVG("Fees Paid for Player (M)"),2) as promedio
from public.jugadores
where "Fees Paid for Player (M)"  > 0
group by "Player Position"

h)--Difference between market value and paid by transferences

SELECT "Player Name", "Player Position", "Player Market Value (M)",  "Fees Paid for Player (M)",
("Fees Paid for Player (M)" - "Player Market Value (M)" ) AS diferencia 
FROM public.jugadores
WHERE "Fees Paid for Player (M)"  > 0

i) --"The club that spent the most money on transfers this season"

SELECT  "Club Moving to", SUM("Fees Paid for Player (M)") as paid
FROM public.jugadores
WHERE  "On Loan" = 'No'
GROUP BY "Club Moving to"
order by paid desc
limit 1
 

j)--"The country that spent the most money on transfers this season"

SELECT  "Country Moving to", SUM("Fees Paid for Player (M)") as paid
FROM public.jugadores
WHERE  "On Loan" = 'No'
GROUP BY "Country Moving to"
order by paid desc
limit 1

k)--"The league that spent the most money on transfers this season"

SELECT  "New League", SUM("Fees Paid for Player (M)") as paid
FROM public.jugadores
WHERE  "On Loan" = 'No'
GROUP BY "New League"
order by paid desc
limit 1
