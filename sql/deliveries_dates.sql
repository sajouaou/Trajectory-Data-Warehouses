/**
  This script create a date table and alter the berlinmod generation to introduce it

  Deliveries
  Trips
 */



-- This function create the DateTable
DROP FUNCTION IF EXISTS deliveries_createDates;
CREATE FUNCTION deliveries_createDates()
    RETURNS void LANGUAGE plpgsql STRICT AS $$
DECLARE
BEGIN
  RAISE INFO 'Creating the Dates tables';
DROP TABLE IF EXISTS Dates;
-- Modified Code that come from https://gist.github.com/duffn/38449526e00abb47f4ec292f0491313d
CREATE TABLE Dates
(
    date_dim_id              BIGINT NOT NULL  PRIMARY KEY,
    date_actual              DATE NOT NULL,
    epoch                    BIGINT NOT NULL,
    day_suffix               VARCHAR(4) NOT NULL,
    day_name                 VARCHAR(9) NOT NULL,
    day_of_week              INT NOT NULL,
    day_of_month             INT NOT NULL,
    day_of_quarter           INT NOT NULL,
    day_of_year              INT NOT NULL,
    week_of_month            INT NOT NULL,
    week_of_year             INT NOT NULL,
    week_of_year_iso         CHAR(10) NOT NULL,
    month_actual             INT NOT NULL,
    month_name               VARCHAR(9) NOT NULL,
    month_name_abbreviated   CHAR(3) NOT NULL,
    quarter_actual           INT NOT NULL,
    quarter_name             VARCHAR(9) NOT NULL,
    year_actual              INT NOT NULL,
    first_day_of_week        DATE NOT NULL,
    last_day_of_week         DATE NOT NULL,
    first_day_of_month       DATE NOT NULL,
    last_day_of_month        DATE NOT NULL,
    first_day_of_quarter     DATE NOT NULL,
    last_day_of_quarter      DATE NOT NULL,
    first_day_of_year        DATE NOT NULL,
    last_day_of_year         DATE NOT NULL,
    mmyyyy                   CHAR(6) NOT NULL,
    mmddyyyy                 CHAR(10) NOT NULL,
    weekend_indr             BOOLEAN NOT NULL
);

CREATE INDEX Dates_date_actual_idx ON Dates USING BTREE(date_actual);

END; $$;

-- This function insert a date into the dateTable and return his ID
DROP FUNCTION IF EXISTS deliveries_getDateID;
CREATE FUNCTION deliveries_getDateID(datum date)
    RETURNS BIGINT  LANGUAGE plpgsql STRICT AS $$
DECLARE
date_id integer;
BEGIN

-- Modified Code that come from https://gist.github.com/duffn/38449526e00abb47f4ec292f0491313d
INSERT  INTO Dates(date_dim_id,
                   date_actual,
                   epoch,
                   day_suffix,
                   day_name,
                   day_of_week,
                   day_of_month,
                   day_of_quarter,
                   day_of_year,
                   week_of_month,
                   week_of_year,
                   week_of_year_iso,
                   month_actual,
                   month_name,
                   month_name_abbreviated,
                   quarter_actual,
                   quarter_name,
                   year_actual,
                   first_day_of_week,
                   last_day_of_week,
                   first_day_of_month,
                   last_day_of_month,
                   first_day_of_quarter,
                   last_day_of_quarter,
                   first_day_of_year,
                   last_day_of_year,
                   mmyyyy,
                   mmddyyyy,
                   weekend_indr)
VALUES (TO_CHAR(datum, 'yyyymmdd')::INT ,
        datum,
        EXTRACT(EPOCH FROM datum),
        TO_CHAR(datum, 'fmDDth'),
        TO_CHAR(datum, 'TMDay') ,
        EXTRACT(ISODOW FROM datum) ,
        EXTRACT(DAY FROM datum) ,
        datum - DATE_TRUNC('quarter', datum)::DATE + 1 ,
        EXTRACT(DOY FROM datum) ,
        TO_CHAR(datum, 'W')::INT ,
        EXTRACT(WEEK FROM datum) ,
        EXTRACT(ISOYEAR FROM datum) || TO_CHAR(datum, '"-W"IW-') || EXTRACT(ISODOW FROM datum) ,
        EXTRACT(MONTH FROM datum) ,
        TO_CHAR(datum, 'TMMonth'),
        TO_CHAR(datum, 'Mon') ,
        EXTRACT(QUARTER FROM datum) ,
        CASE
            WHEN EXTRACT(QUARTER FROM datum) = 1 THEN 'First'
            WHEN EXTRACT(QUARTER FROM datum) = 2 THEN 'Second'
            WHEN EXTRACT(QUARTER FROM datum) = 3 THEN 'Third'
            WHEN EXTRACT(QUARTER FROM datum) = 4 THEN 'Fourth'
            END ,
        EXTRACT(YEAR FROM datum) ,
        datum + (1 - EXTRACT(ISODOW FROM datum))::INT ,
        datum + (7 - EXTRACT(ISODOW FROM datum))::INT ,
        datum + (1 - EXTRACT(DAY FROM datum))::INT ,
        (DATE_TRUNC('MONTH', datum) + INTERVAL '1 MONTH - 1 day')::DATE ,
        DATE_TRUNC('quarter', datum)::DATE ,
        (DATE_TRUNC('quarter', datum) + INTERVAL '3 MONTH - 1 day')::DATE ,
        TO_DATE(EXTRACT(YEAR FROM datum) || '-01-01', 'YYYY-MM-DD') ,
        TO_DATE(EXTRACT(YEAR FROM datum) || '-12-31', 'YYYY-MM-DD') ,
        TO_CHAR(datum, 'mmyyyy') ,
        TO_CHAR(datum, 'mmddyyyy') ,
        CASE
            WHEN EXTRACT(ISODOW FROM datum) IN (6, 7) THEN TRUE
            ELSE FALSE
            END )
    on conflict (date_dim_id) do nothing;

SELECT TO_CHAR(datum, 'yyyymmdd')::INT

INTO date_id;
RETURN date_id;
END; $$;



DROP FUNCTION IF EXISTS deliveries_alterDates;
CREATE FUNCTION deliveries_alterDates()
    RETURNS void LANGUAGE plpgsql STRICT AS $$
DECLARE
BEGIN
    PERFORM deliveries_createDates();
    RAISE INFO 'Alter the Deliveries tables';
    ALTER TABLE Deliveries
    ADD  day_id  BIGINT;

    UPDATE Deliveries
    SET day_id = deliveries_getDateID(day);

    ALTER TABLE Deliveries
    DROP COLUMN  day;

    RAISE INFO 'Alter the Trips tables';
    ALTER TABLE Trips
    ADD  day_id  BIGINT;

    UPDATE Trips
    SET day_id = deliveries_getDateID(day);

    ALTER TABLE Trips
    DROP COLUMN  day;
END; $$;