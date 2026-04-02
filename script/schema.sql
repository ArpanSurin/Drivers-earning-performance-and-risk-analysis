-- drivers
CREATE TABLE drivers (
  driver_id      INT PRIMARY KEY,
  name           TEXT NOT NULL,
  signup_date    DATE NOT NULL,
  city           TEXT NOT NULL,
  vehicle_type   TEXT NOT NULL, -- economy / premium / XL
  status         TEXT NOT NULL  -- active / suspended / inactive
);

-- riders
CREATE TABLE riders (
  rider_id    INT PRIMARY KEY,
  name        TEXT NOT NULL,
  signup_date DATE NOT NULL,
  home_city   TEXT NOT NULL,
  segment     TEXT NOT NULL      -- casual / power / corporate
);

-- trips
CREATE TABLE trips (
  trip_id         INT PRIMARY KEY,
  rider_id        INT NOT NULL REFERENCES riders(rider_id),
  driver_id       INT NOT NULL REFERENCES drivers(driver_id),
  request_time    TIMESTAMP NOT NULL,
  pickup_time     TIMESTAMP,
  dropoff_time    TIMESTAMP,
  pickup_city     TEXT NOT NULL,
  dropoff_city    TEXT NOT NULL,
  status          TEXT NOT NULL, -- completed / rider_cancelled / driver_cancelled
  distance_km     NUMERIC(6,2),
  duration_min    NUMERIC(6,2),
  surge_multiplier NUMERIC(3,2) DEFAULT 1.0,
  fare_amount     NUMERIC(8,2),
  driver_earnings NUMERIC(8,2),
  platform_fee    NUMERIC(8,2)
);

-- ratings
CREATE TABLE ratings (
  rating_id        INT PRIMARY KEY,
  trip_id          INT NOT NULL REFERENCES trips(trip_id),
  rated_by         TEXT NOT NULL, -- 'rider' or 'driver'
  rating           INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  rating_timestamp TIMESTAMP NOT NULL
);

-- driver_payouts
CREATE TABLE driver_payouts (
  payout_id          INT PRIMARY KEY,
  driver_id          INT NOT NULL REFERENCES drivers(driver_id),
  payout_period_start DATE NOT NULL,
  payout_period_end   DATE NOT NULL,
  total_trips        INT NOT NULL,
  total_earnings     NUMERIC(10,2) NOT NULL,
  bonuses            NUMERIC(10,2) DEFAULT 0,
  cancellations      INT DEFAULT 0
);