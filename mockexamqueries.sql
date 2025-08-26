USE `eventmanagementdb`;
#Exercise01
#Exercise01



CREATE OR REPLACE VIEW  Query1 AS
SELECT 
r.EventID,
 e.EventName,
 a.AttendeeID,
 a.Email
FROM registrations r
JOIN events e on r.EventID =  e.EventID
LEFT JOIN attendees a on r.AttendeeID = a.AttendeeID
WHERE e.EventName = 'Computer Basics for Business'
ORDER BY a.Email ASC;

 
#view1
 
 SELECT * FROM Query1;
 
 #View2
 
 #Exercise02
 CREATE OR REPLACE VIEW  Query2 AS
 SELECT
 COUNT(ev.EventID) AS NumberOfEvents
 ,e.EventType
 from   event_types e 
 JOIN events ev ON e.EventTypeID = ev.EventTypeID
 GROUP BY e.EventTypeID, e.EventType 
 ORDER BY NumberOfEvents DESC;

 SELECT * FROM Query2;
 
 #view3
  CREATE OR REPLACE VIEW  Query3 AS
 SELECT
 CONCAT(SUM(p.PaymentAmount),'€') AS TotalAmountOfPayments
 ,YEAR(p.PaymentDate) AS TotalAmountinYear, MONTH(p.PaymentDate) AS TotalAmountPerMonth
 from  payments p
 GROUP BY YEAR(p.PaymentDate),MoNTH(p.PaymentDate)

 ORDER BY TotalAmountinYear,TotalAmountPerMonth DESC;

 SELECT * FROM Query3;
 
 #👉 verschil:

#
#In de ORDER BY mag je de aliassen wel gebruiken (TotalAmountinYear, TotalAmountPerMonth
#Om het euroteken toe te voegen aan je som kun je de functie CONCAT() gebruiken.


#View4

CREATE OR REPLACE VIEW  Query4 AS
SELECT 
r.RegistrationID,
 Date_FORMAT(r.RegistrationDate,'%d-%m-%Y') AS RegistrationDate,
CONCAT(r.RegistrationFee,'€') AS RegistrationFee
 
FROM registrations r
LEFT JOIN payments p ON p.RegistrationID = r.RegistrationID

WHERE p.PaymentID IS NULL

ORDER BY r.RegistrationDate ASC;


#De bedoeling is dus alle registraties die nog niet betaald zijn tonen.

#
#We nemen alle registrations.

#We doen een LEFT JOIN met payments.

#We filteren de rijen uit waar geen betaling bestaat (p.PaymentID IS NULL).

#We formatteren de datum in Europees formaat (DD-MM-YYYY).

#We tonen de RegistrationFee mét €.

#LEFT JOIN: toont alle rijen uit registrations, zelfs als er géén match is in payments.

#Daarom is de LEFT JOIN hier juist, want we willen net de registraties die geen betaling hebben → die komen met een NULL uit de payments-kant.

#En met de WHERE p.PaymentID IS NULL filter je alles wat niet betaald is.

 
#view4
 
 SELECT * FROM Query4;

#view5
CREATE OR REPLACE VIEW Query5 AS
SELECT 
  r.EventID,                                  -- Show the event ID
  SUM(r.Nmbr_of_persons) AS TotalNumbersOfRegisteredPersons  -- Total people (sum of Nmbr_of_persons)
FROM registrations r
JOIN events e ON e.EventID = r.EventID        -- Link each registration to its event
WHERE r.RegistrationDate 
      BETWEEN '2022-03-15' AND '2022-04-30'   -- Only registrations between 15/03/2022 and 30/04/2022
GROUP BY r.EventID                            -- Group by each event
HAVING SUM(r.Nmbr_of_persons) > 5;            -- Keep only events with > 5 registered people

# Query the view and sort the result
SELECT * 
FROM Query5
ORDER BY TotalNumbersOfRegisteredPersons DESC;

#-----------------------------------------------
# EXPLANATION / COMMENTS
#
# 1. We take all registrations from the given period (WHERE = row filter).
# 2. We join events so we can group results by event ID.
# 3. We use SUM(r.Nmbr_of_persons) because Nmbr_of_persons already stores
#    how many people were registered in one row.
#    (COUNT would just count rows, not people.)
# 4. We GROUP BY EventID to calculate one total per event.
# 5. We use HAVING instead of WHERE because:
#       - WHERE works before grouping (on raw rows).
#       - HAVING works after grouping (on aggregates).
#    → That’s why the condition "more than 5 people in total"
#      must go into HAVING.
# 6. Finally, we order the output so the events with the
#    largest number of people appear first.

 

