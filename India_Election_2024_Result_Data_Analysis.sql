CREATE DATABASE India_Elections_Results_2024;
USE India_Elections_Results_2024;

SELECT * FROM constituencywise_details;
SELECT * FROM constituencywise_results;
SELECT * FROM partywise_results;
SELECT * FROM statewise_results;
SELECT * FROM states;



                                     ----- PROBLEM STATEMENTS -----

--1. Find Total number of Seats
SELECT COUNT(DISTINCT Parliament_Constituency) AS total_seats 
FROM constituencywise_results;


--2. What are the total number of seats available for election in each state?
SELECT s.State, COUNT(cr.Constituency_ID) AS Total_Seats_Available
FROM constituencywise_results cr JOIN statewise_results sr 
ON cr.Parliament_Constituency = sr.Parliament_Constituency JOIN states s
ON sr.State_ID = s.State_ID
GROUP BY s.State
ORDER BY s.State;


--3. Find Total Seats won by NDA Alliance
SELECT SUM(CASE
            WHEN Party IN ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS',
				'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM') THEN [Won]
            ELSE 0 
        END) AS NDA_Total_Seats_Won
FROM partywise_results;


--4. Seats won by NDA Alliance Parties
SELECT  pr.Party AS NDA_Alliance_Parties, pr.Won AS Seats_Won, pr.Party_ID
FROM partywise_results pr
WHERE pr.Party IN ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS',
				'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM')
ORDER BY pr.Won DESC;


--5. Total seats won by I.N.D.I.A. Alliance
SELECT SUM(CASE
              WHEN pr.Party IN ('Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK') THEN [Won]
			ELSE 0 
END) AS INDIA_total_seats_won
FROM partywise_results pr;


--6. Seats won by I.N.D.I.A. Alliance Parties
SELECT pr.Party AS INDIA_Alliance_Parties, pr.Won AS Seats_Won, pr.Party_ID
FROM partywise_results pr
WHERE pr.Party IN ('Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK')
ORDER BY pr.Won DESC;


--7. Add new column field in table partwise results to get the Party Alliance as NDA, I.N.D.I.A and Other
ALTER TABLE partywise_results
ADD Alliance VARCHAR(100);

UPDATE partywise_results
SET Alliance = 'NDA'
WHERE partywise_results.Party IN ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS',
				'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM');


UPDATE partywise_results
SET Alliance = 'I.N.D.I.A.'
WHERE partywise_results.Party IN ('Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK');

UPDATE partywise_results
SET Alliance = 'OTHER'
WHERE partywise_results.Alliance IS NULL;


--8. Which party alliance (NDA, I.N.D.I.A., or Other) won the most seats across all states?
SELECT pr.Alliance, SUM(pr.Won) AS no_of_seats
FROM partywise_results pr
GROUP BY pr.Alliance
ORDER BY no_of_seats DESC;


--9. Find Winning candidates' name, their party name, total votes and the margin of victory for a specific state and constituency?
SELECT cr.Winning_Candidate, pr.Alliance, pr.Party, cr.Total_Votes, cr.Margin, cr.Constituency_Name, s.state
FROM constituencywise_results cr INNER JOIN partywise_results pr 
ON cr.Party_ID = pr.Party_ID 
INNER JOIN statewise_results sr
ON cr.Parliament_Constituency = sr.Parliament_Constituency
INNER JOIN states s
ON sr.State_ID = s.State_ID


--10. What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?
SELECT cd.EVM_Votes, cd.Postal_Votes, cd.Total_Votes, cd.Candidate, cr.Constituency_Name
FROM constituencywise_details cd INNER JOIN constituencywise_results cr
ON cd.Constituency_ID = cr.Constituency_ID
WHERE cr.Constituency_Name = 'ROHTAK';


--11. Which parties won the most seats in a state and how many seats did each party win?
SELECT pr.Party, COUNT(cr.Constituency_Name) AS Seats_Won
FROM constituencywise_results cr INNER JOIN partywise_results pr
ON cr.Party_ID = pr.Party_ID
INNER JOIN statewise_results sr 
ON cr.Constituency_Name = sr.Constituency
INNER JOIN states s
ON sr.State_ID = s.State_ID
WHERE s.State = 'Kerala'
GROUP BY pr.party
ORDER BY Seats_Won DESC;


--12. What is the total no. of seats won by each party alliance (NDA, I.N.D.I.A., and Other) in each state for the India election 2024?
SELECT s.State AS State_Name,
SUM(CASE WHEN pr.Alliance = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats_Won,
SUM(CASE WHEN pr.Alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_Seats_Won,
SUM(CASE WHEN pr.Alliance = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_Seats_Won
FROM constituencywise_results cr JOIN partywise_results pr 
ON cr.Party_ID = pr.Party_ID 
JOIN statewise_results sr 
ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s 
ON sr.State_ID = s.State_ID
WHERE pr.Alliance IN ('NDA', 'I.N.D.I.A',  'OTHER')
GROUP BY s.State
ORDER BY s.State;


--13. Find top 10 candidates received the highest no of EVM votes in each constituency.
SELECT TOP 10 cr.Constituency_Name, cd.Candidate, cd.Constituency_ID, cd.EVM_Votes 
FROM constituencywise_details cd INNER JOIN constituencywise_results cr
ON cd.Constituency_ID = cr.Constituency_ID
ORDER BY cd.EVM_Votes DESC;


--14. Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?
WITH RankedCandidates AS (
SELECT cd.Constituency_ID, cd.Candidate, cd.Party, cd.EVM_Votes, cd.Postal_Votes, cd.EVM_Votes + cd.Postal_Votes AS Total_Votes,
ROW_NUMBER() OVER (PARTITION BY cd.Constituency_ID ORDER BY cd.EVM_Votes + cd.Postal_Votes DESC) AS VoteRank
FROM constituencywise_details cd INNER JOIN constituencywise_results cr 
ON cd.Constituency_ID = cr.Constituency_ID INNER JOIN statewise_results sr 
ON cr.Parliament_Constituency = sr.Parliament_Constituency INNER JOIN states s 
ON sr.State_ID = s.State_ID
WHERE s.State = 'Maharashtra'
)
SELECT cr.Constituency_Name, 
MAX(CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate, 
MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
FROM RankedCandidates rc INNER JOIN constituencywise_results cr ON rc.Constituency_ID = cr.Constituency_ID
GROUP BY cr.Constituency_Name
ORDER BY cr.Constituency_Name;


--15. For the state of Uttar Pradesh, what are the total number of seats, total number of candidates, total number of Parties, total votes (including EVM and postal) and the breakdown of EVM and postal votes?
SELECT 
COUNT(DISTINCT cr.Parliament_Constituency) AS total_seats, 
COUNT(DISTINCT cd.Candidate) AS total_candidate,
COUNT(DISTINCT pr.Party) AS total_parties,
SUM(cd.EVM_Votes + cd.Postal_Votes) AS total_seats,
SUM(cd.EVM_Votes) AS total_EVM_votes, 
SUM(cd.Postal_Votes) AS total_postal_votes
FROM constituencywise_results cr INNER JOIN constituencywise_details cd 
ON cr.Constituency_ID = cd.Constituency_ID
INNER JOIN statewise_results sr 
ON cr.Parliament_Constituency = sr.Parliament_Constituency
INNER JOIN states s 
ON sr.State_ID = s.State_ID
INNER JOIN partywise_results pr
ON cr.Party_ID = pr.Party_ID
WHERE s.State = 'Uttar Pradesh';
