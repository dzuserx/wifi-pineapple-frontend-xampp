-- Mock data for db_wifi_pineapple database

-- Insert into networks
INSERT INTO networks (ssid, bssid, channel, `signal`, encryption, client_count) VALUES
('HomeWiFi', '00:11:22:33:44:55', 6, -45, 'WPA2', 3),
('Office_Network', 'AA:BB:CC:DD:EE:FF', 11, -62, 'WPA2', 8),
('GuestWiFi', '11:22:33:44:55:66', 1, -78, 'Open', 12);

-- Insert into clients
INSERT INTO clients (mac, vendor, packets, `signal`, connected_ssid) VALUES
('AA:BB:CC:11:22:33', 'Apple Inc.', 245, -55, 'HomeWiFi'),
('BB:CC:DD:22:33:44', 'Samsung Electronics', 189, -48, 'Office_Network');

-- Insert into interfaces
INSERT INTO interfaces (name, status, ip, mac, mode) VALUES
('wlan0', 'up', '172.16.42.1', '00:11:22:33:44:55', 'AP'),
('wlan1', 'up', '192.168.1.100', '00:11:22:33:44:56', 'Client'),
('eth0', 'down', NULL, '00:11:22:33:44:57', 'Ethernet');

-- Insert into dhcp_leases (mock data, assuming some leases)
INSERT INTO dhcp_leases (ip, mac, lease_start, lease_end) VALUES
('172.16.42.100', 'AA:BB:CC:11:22:33', '2024-01-15 10:00:00', '2024-01-15 12:00:00'),
('172.16.42.101', 'BB:CC:DD:22:33:44', '2024-01-15 09:30:00', '2024-01-15 11:30:00');

-- Insert into routing
INSERT INTO routing (destination, gateway, interface_name, metric) VALUES
('default', '172.16.42.1', 'wlan0', 0),
('192.168.1.0/24', '0.0.0.0', 'wlan1', 1);

-- Insert into ssid_pool
INSERT INTO ssid_pool (name, count, added) VALUES
('HomeWiFi', 8, '2024-01-15 09:00:00'),
('FreeWiFi', 12, '2024-01-15 08:30:00'),
('Starbucks', 4, '2024-01-15 10:15:00');

-- Insert into pineapple_settings
INSERT INTO pineapple_settings (enabled, pool_size, beacon_interval, response_interval, broadcast_ssid, log_associations, karma_mode) VALUES
(1, 50, 100, 1000, 1, 1, 'standard');

-- Insert into modules
INSERT INTO modules (name, version, description, enabled, author, size, type) VALUES
('URL Sniffer', '1.2.0', 'Captures and analyzes HTTP/HTTPS traffic', 1, 'Hak5', 2457600, 'installed'),
('DNS Spoof', '2.1.0', 'DNS spoofing and redirection module', 1, 'Hak5', 1835008, 'installed'),
('Evil Portal', '3.0.1', 'Captive portal and phishing module', 0, 'Hak5', 4194304, 'installed'),
('Network Scanner', '1.0.0', 'Advanced network discovery and mapping', 0, 'Community', 1048576, 'available'),
('Packet Analyzer', '2.3.0', 'Deep packet inspection and analysis', 0, 'Hak5', 5242880, 'available');

-- Insert into campaign_modes
INSERT INTO campaign_modes (id, name, description) VALUES
('automated', 'Automated Mode', 'Runs campaigns automatically based on predefined triggers and schedules.'),
('manual', 'Manual Mode', 'User-controlled execution with real-time monitoring and adjustments.'),
('advanced', 'Advanced Mode', 'Custom scripting and API integration for complex attack scenarios.');

-- Insert into campaigns
INSERT INTO campaigns (id, name, status, mode, results, description, created, last_run) VALUES
(1, 'SSID Harvesting Campaign', 'active', 'Automated', 45, 'Automatically captures SSID information from nearby networks', '2024-01-15 10:30:00', '2024-01-20 14:22:00'),
(2, 'Client Deauth Attack', 'paused', 'Manual', 12, 'Deauthenticates clients from target networks', '2024-01-10 09:15:00', '2024-01-18 16:45:00'),
(3, 'Beacon Flooding Test', 'completed', 'Automated', 67, 'Floods area with fake beacon frames', '2024-01-05 11:20:00', '2024-01-19 13:10:00'),
(4, 'Probe Response Capture', 'active', 'Automated', 23, 'Captures probe responses from client devices', '2024-01-12 08:45:00', '2024-01-20 12:30:00'),
(5, 'Evil Twin Setup', 'stopped', 'Manual', 8, 'Creates evil twin access points', '2024-01-08 14:00:00', '2024-01-17 10:15:00');

-- Insert into reports
INSERT INTO reports (id, name, type, generated, size) VALUES
(1, 'SSID Harvest Report', 'summary', '2024-01-20 15:30:00', '2.3MB'),
(2, 'Client Activity Log', 'detailed', '2024-01-19 11:45:00', '5.1MB');

-- Insert into activity_logs
INSERT INTO activity_logs (type, message, timestamp, client_mac) VALUES
('client_connected', 'New client connected to open network', '2024-01-15 10:28:00', 'AA:BB:CC:11:22:33'),
('scan_completed', 'Network reconnaissance scan completed', '2024-01-15 10:15:00', NULL);
