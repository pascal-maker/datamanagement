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
