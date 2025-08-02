CREATE DATABASE IF NOT EXISTS pond;
USE pond;
CREATE TABLE SENSOR(
sensor_id INT PRIMARY KEY AUTO_INCREMENT,
sensor_type VARCHAR(255) NOT NULL,
measurement_value DECIMAL(10,2) NOT NULL,
measurement_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP);


CREATE TABLE Action(
action_id INT PRIMARY KEY AUTO_INCREMENT,
action_type VARCHAR(255) NOT NULL,
action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Pond(
pond_id INT PRIMARY KEY AUTO_INCREMENT,
freshwater_supply INT,
acidic_water_discharge INT,
additives_addition INT,
uv_lamp_control INT,
aeration_increase INT,
filter_shutdown INT
);

CREATE TABLE Sensor_Action
( sensor_id INT,
action_id INT,
PRIMARY KEY (sensor_id,action_id),
FOREIGN KEY (sensor_id) REFERENCES Sensor(sensor_id),
FOREIGN KEY(action_id) REFERENCES Action(action_id)

);

CREATE TABLE Pond_Action
( pond_id INT,
action_id INT,
PRIMARY KEY (pond_id,action_id),
FOREIGN KEY (pond_id) REFERENCES Pond(pond_id),
FOREIGN KEY(action_id) REFERENCES Action(action_id)

);