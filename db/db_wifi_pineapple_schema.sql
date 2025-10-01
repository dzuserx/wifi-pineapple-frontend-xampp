-- Database: db_wifi_pineapple ---

-- Table: clients
CREATE TABLE clients (
    mac VARCHAR(17) PRIMARY KEY,
    vendor VARCHAR(255),
    packets INT,
    signal INT,
    connected_ssid VARCHAR(255),
    FOREIGN KEY (connected_ssid) REFERENCES networks(ssid)
);

-- Table: networks
CREATE TABLE networks (
    ssid VARCHAR(255) PRIMARY KEY,
    bssid VARCHAR(17) UNIQUE,
    channel INT,
    signal INT,
    encryption VARCHAR(50),
    client_count INT
);

-- Table: interfaces
CREATE TABLE interfaces (
    name VARCHAR(50) PRIMARY KEY,
    status VARCHAR(10),
    ip VARCHAR(15),
    mac VARCHAR(17),
    mode VARCHAR(20)
);

-- Table: dhcp_leases
CREATE TABLE dhcp_leases (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ip VARCHAR(15),
    mac VARCHAR(17),
    lease_start DATETIME,
    lease_end DATETIME
);

-- Table: routing
CREATE TABLE routing (
    id INT AUTO_INCREMENT PRIMARY KEY,
    destination VARCHAR(50),
    gateway VARCHAR(15),
    interface_name VARCHAR(50),
    metric INT,
    FOREIGN KEY (interface_name) REFERENCES interfaces(name)
);

-- Table: ssid_pool
CREATE TABLE ssid_pool (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    count INT,
    added DATETIME
);

-- Table: pineapple_settings
CREATE TABLE pineapple_settings (
    id INT PRIMARY KEY DEFAULT 1,
    enabled BOOLEAN,
    pool_size INT,
    beacon_interval INT,
    response_interval INT,
    broadcast_ssid BOOLEAN,
    log_associations BOOLEAN,
    karma_mode VARCHAR(50)
);

-- Table: modules
CREATE TABLE modules (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    version VARCHAR(20),
    description TEXT,
    enabled BOOLEAN,
    author VARCHAR(255),
    size INT,
    type ENUM('installed', 'available')
);

-- Table: campaigns
CREATE TABLE campaigns (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    status VARCHAR(50),
    mode VARCHAR(50),
    results INT,
    description TEXT,
    created DATETIME,
    last_run DATETIME
);

-- Table: campaign_modes
CREATE TABLE campaign_modes (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255),
    description TEXT
);

-- Table: reports
CREATE TABLE reports (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    type VARCHAR(50),
    generated DATETIME,
    size VARCHAR(20)
);

-- Table: activity_logs
CREATE TABLE activity_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50),
    message TEXT,
    timestamp DATETIME,
    client_mac VARCHAR(17),
    FOREIGN KEY (client_mac) REFERENCES clients(mac)
);
