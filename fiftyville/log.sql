-- Keep a log of any SQL queries you execute as you solve the mystery.
SELECT *
FROM crime_scene_reports
WHERE
    year = 2021 AND
    month = 7 AND
    day = 28 AND
    street = 'Humphrey Street';
-- 10:15 am, Bakery, three witnesses all mention bakery in transcript, interview same day as crime

SELECT *
FROM interviews
WHERE
    year = 2021 AND
    month = 7 AND
    day = 28 AND
    transcript LIKE '%bakery%';
--names: Ruth, Eugene, Raymond;

--Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away.
--If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame."

SELECT activity, license_plate, hour, minute
FROM bakery_security_logs
WHERE
    year = 2021 AND
    month = 7 AND
    day = 28 AND
    hour = 10 AND
    minute >= 0 AND
    minute <= 25;
--Possible plates:
-- 5P2BI95
-- 94KL13X
-- 6P58WS2
-- 4328GD8
-- G412CB7
-- L93JTIZ
-- 322W7JE
-- 0NTHK55

--I don't know the thief's name, but it was someone I recognized. Earlier this morning,
--before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.
SELECT account_number
FROM atm_transactions
WHERE
    year = 2021 AND
    month = 7 AND
    day = 28 AND
    atm_location = 'Leggett Street' AND
    transaction_type = 'withdraw';
--Possible account numbs:
-- 28500762
-- 28296815
-- 76054385
-- 49610011
-- 16153065
-- 25506511
-- 81061156
-- 26013199

--As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call,
SELECT caller, receiver
FROM phone_calls
WHERE
    year = 2021 AND
    month = 7 AND
    day = 28 AND
    duration <= 60;
--+----------------+----------------+
--|     caller     |    receiver    |
--+----------------+----------------+
--| (130) 555-0289 | (996) 555-8899 |
--| (499) 555-9472 | (892) 555-8872 |
--| (367) 555-5533 | (375) 555-8161 |
--| (499) 555-9472 | (717) 555-1342 |
--| (286) 555-6063 | (676) 555-6554 |
--| (770) 555-1861 | (725) 555-3243 |
--| (031) 555-6622 | (910) 555-3251 |
--| (826) 555-1652 | (066) 555-9701 |
--| (338) 555-6650 | (704) 555-2131 |
--+----------------+----------------+

--I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow.
--The thief then asked the person on the other end of the phone to purchase the flight ticket.
SELECT *
FROM airports
WHERE
    city = 'Fiftyville';
-- id = 8

SELECT id, destination_airport_id, origin_airport_id, hour, minute
FROM flights
WHERE
    year = 2021 AND
    month = 7 AND
    day = 29 AND
    origin_airport_id = 8
ORDER BY
    hour ASC,
    minute ASC
LIMIT 3;
--earliest flight = id 36, dest_id 4, 8:20 am

SELECT passport_number
FROM passengers
WHERE
    flight_id = 36 OR
    flight_id = 43 OR
    flight_id = 23;
--+-----------------+
--| passport_number |
--+-----------------+
--| 7214083635      |
--| 1695452385      |
--| 5773159633      |
--| 1540955065      |
--| 8294398571      |
--| 1988161715      |
--| 9878712108      |
--| 8496433585      |
--+-----------------+

SELECT id, name
FROM people
WHERE
    phone_number IN (
        SELECT caller
        FROM phone_calls
        WHERE
            year = 2021 AND
            month = 7 AND
            day = 28 AND
            duration <= 60
    ) AND
    passport_number IN (
        SELECT passport_number
        FROM passengers
        WHERE
            flight_id = 36 OR
            flight_id = 43 OR
            flight_id = 23
    ) AND
    license_plate IN (
        SELECT license_plate
        FROM bakery_security_logs
        WHERE
            year = 2021 AND
            month = 7 AND
            day = 28 AND
            hour = 10 AND
            minute >= 5 AND
            minute <= 25
    );
--thief suspects
--+--------+--------+
--|   id   |  name  |
--+--------+--------+
--| 398010 | Sofia  |
--| 560886 | Kelsey |
--| 686048 | Bruce  |
--+--------+--------+
--accomplice
SELECT receiver
FROM phone_calls
WHERE
    year = 2021 AND
    month = 7 AND
    day = 28 AND
    duration < 60 AND
    caller = (
    ;
-- (375) 555-8161
-- Robin

SELECT person_id
FROM bank_accounts
WHERE
    account_number IN (
        SELECT account_number
        FROM atm_transactions
        WHERE
            year = 2021 AND
            month = 7 AND
            day = 28 AND
            atm_location = 'Leggett Street' AND
            transaction_type = 'withdraw'
    ) AND
    person_id IN (
        SELECT id
        FROM people
        WHERE
            phone_number IN (
                SELECT caller
                FROM phone_calls
                WHERE
                    year = 2021 AND
                    month = 7 AND
                    day = 28 AND
                    duration <= 60
            ) AND
            passport_number IN (
                SELECT passport_number
                FROM passengers
                WHERE
                    flight_id = 36 OR
                    flight_id = 43 OR
                    flight_id = 23
            ) AND
            license_plate IN (
                SELECT license_plate
                FROM bakery_security_logs
                WHERE
                    year = 2021 AND
                    month = 7 AND
                    day = 28 AND
                    hour = 10 AND
                    minute >= 5 AND
                    minute <= 25
            )
    );

--thief = Bruce