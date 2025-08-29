SELECT  r.Nederlands as `Bedreiging`, f.common_name as `FAMILIENAAM`,
b.`common_name` as `VOGELNAAM`
from bird b join family f on b.familyid = f.id join  redlist_definition r on r.engels = b.redlist_definition_engels
order by `BEDREIGING` , `FAMILIENAAM`;

-- view2
SELECT  r.Nederlands as `Bedreiging`,count(*) as `Aantal`
from bird b join family f on b.familyid = f.id join  redlist_definition r on r.engels = b.redlist_definition_engels
group by r.Nederlands
order by `Aantal` desc;
-- view3

SELECT  r.Nederlands as `Bedreiging`,f.`common_name` as `FAMILIE`,
count(*) as `Aantal`
from bird b join family f on b.familyid = f.id join  redlist_definition r on r.engels = b.redlist_definition_engels
group by r.Nederlands, f.`common_name`
order by r.Nederlands , f.`common_name`

