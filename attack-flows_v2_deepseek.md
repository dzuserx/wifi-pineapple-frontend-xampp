AIRGEDDN MAIN MENU
├────── Section 1: Preparation ──────────────────────────────────────────────
├── 1. Select Interface and mode:
│      Create a Select tag with a List available wireless interfaces with interface details (driver, chipset, capabilities) : collect mock data from airgeddon.json
│      Beside the Select tag of List of interfaces, Create a Select tag with mode options : collect mock data from airgeddon.json
│      Beside the Select tag of mode options, Add a button at bottom right of the card, to save the configured setting above and continue to Target Discovery
├────── Section 2: Network discovery ────────────────────────────────────────
├── 4. Explore for targets
│      Display a list of networks: collect mock data from airgeddon.json
│      ├── Checkbox
│      ├── # (item number)
│      ├── BSSID (MAC address)
│      ├── ESSID (Network name)
│      ├── Channel
│      ├── Signal strength
│      ├── Encryption type (WEP/WPA/WPA2)
│      ├── WPS status
│      └── Client count (Show * if client count > 0 else show 0)
│      Below the list create an input field to enter the item number of the target network for individual selection
│      Beside the input field, Create a button to save the selected target networks above and continue to Attack Methods selection
├────── Section 3: Attack selection ─────────────────────────────────────────
├── 5. DOS Attacks Menu : Onclick display or close submenus 
│   ├── 5.1. Deauth Attack
│   ├── 5.2. Beacon Flood Attack
│   ├── 5.3. Auth DOS Attack
│   └── 5.4. Return to Main Menu
├── 6. Handshake Tools Menu : Onclick display or close submenus
│   ├── 6.1. Capture Handshake
│   ├── 6.2. Clean/Optimize Handshake
│   ├── 6.3. Verify Handshake
│   └── 6.4. Return to Main Menu
├── 7. Offline WPA/WPA2 decrypt Menu : Onclick display or close submenus
│   ├── 7.1. Dictionary Attack
│   ├── 7.2. Bruteforce Attack
│   └── 7.3. Return to Main Menu
├── 8. WPS Attacks Menu : Onclick display or close submenus
│   ├── 8.1. WPS PIN Attack
│   ├── 8.2. WPS Pixie Dust Attack
│   └── 8.3. Return to Main Menu
├── 9. Evil Twin Attacks Menu : Onclick display or close submenus
│   ├── 9.1. Evil Twin AP Attack with captive portal
│   ├── 9.2. Evil Twin AP Attack with sniffing
│   ├── 9.3. Evil Twin AP Attack with sniffing and sslstrip
│   └── 9.4. Return to Main Menu
├── 10. WEP Attacks Menu : Onclick display or close submenus
│   ├── 10.1. WEP Fake Auth Attack
│   ├── 10.2. WEP Chop-Chop Attack
│   ├── 10.3. WEP Fragmentation Attack
│   └── 10.4. Return to Main Menu
├───────────────────────────────────────────────────────────
└── 11. Exit

> Note: Each menu includes validation checks for required tools and dependencies before options become available. The script maintains state and allows returning to previous menus.

