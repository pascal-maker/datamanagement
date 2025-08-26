SELECT 
    r.Nederlands AS `BEDREIGING`, 
    f.common_name AS `FAMILIENAAM`,
    b.`common name` AS `VOGELNAAM`
FROM bird b
JOIN family f 
    ON b.familyID = f.id
JOIN Redlist_definition r 
    ON b.Redlist_definition_english = r.Engels
ORDER BY `BEDREIGING`, `FAMILIENAAM`;

#view2
SELECT 

r.Nederlands as `Bedreiging`,count(*) as 'Aantal'
   
FROM bird b
JOIN family f 
    ON b.familyID = f.id
JOIN Redlist_definition r 
    ON b.Redlist_definition_english = r.Engels
group by r.Nederlands
order by `Aantal` desc;


#view3
SELECT 

r.Nederlands as `Bedreiging`,f.`common name` as `FAMILIE`,count(*) as 'Aantal'
   
FROM bird b
JOIN family f 
    ON b.familyID = f.id
JOIN Redlist_definition r 
    ON b.Redlist_definition_english = r.Engels
group by r.Nederlands, f.`common name`
order by  r.Nederlands, f.`common name`

