class AirgeddonModule {
    constructor() {
        console.log('🚀 AirgeddonModule constructor called');
        this.interfaces = [];
        this.modes = [];
        this.networks = [];
        this.attackMethods = {};
        this.selectedInterface = null;
        this.selectedMode = null;
        this.selectedTargets = new Set();
        this.init();
    }

    async init() {
        await this.loadMockData();
        this.populateInterfaceSelect();
        this.populateModeSelect();
        this.populateNetworksTable();
        this.setupEventListeners();
    }

    async loadMockData() {
        try {
            const response = await fetch('api/mock/airgeddon.json');
            const data = await response.json();
            this.interfaces = data.interfaces.available;
            this.modes = data.interfaces.modes;
            this.networks = data.networks.discovered;
            this.attackMethods = data.attack_methods;
        } catch (error) {
            console.error('Error loading mock data:', error);
        }
    }

    populateInterfaceSelect() {
        const select = document.getElementById('interface-select');
        select.innerHTML = '<option value="">Choose interface...</option>';
        this.interfaces.forEach(iface => {
            const option = document.createElement('option');
            option.value = iface.name;
            option.textContent = `${iface.name} (${iface.driver}, ${iface.chipset})`;
            select.appendChild(option);
        });
    }

    populateModeSelect() {
        const select = document.getElementById('mode-select');
        select.innerHTML = '<option value="">Choose mode...</option>';
        this.modes.forEach(mode => {
            const option = document.createElement('option');
            option.value = mode;
            option.textContent = mode;
            select.appendChild(option);
        });
    }

    populateNetworksTable() {
        const tbody = document.querySelector('#networks-table tbody');
        tbody.innerHTML = '';
        this.networks.forEach((network, index) => {
            const tr = document.createElement('tr');

            const checkboxTd = document.createElement('td');
            const checkbox = document.createElement('input');
            checkbox.type = 'checkbox';
            checkbox.dataset.id = network.id;
            checkbox.checked = this.selectedTargets.has(network.id);
            checkbox.addEventListener('change', (e) => {
                if (e.target.checked) {
                    this.selectedTargets.add(network.id);
                } else {
                    this.selectedTargets.delete(network.id);
                }
            });
            checkboxTd.appendChild(checkbox);
            tr.appendChild(checkboxTd);

            const numberTd = document.createElement('td');
            numberTd.textContent = index + 1;
            tr.appendChild(numberTd);

            const bssidTd = document.createElement('td');
            bssidTd.textContent = network.bssid;
            tr.appendChild(bssidTd);

            const essidTd = document.createElement('td');
            essidTd.textContent = network.essid;
            tr.appendChild(essidTd);

            const channelTd = document.createElement('td');
            channelTd.textContent = network.channel;
            tr.appendChild(channelTd);

            const signalTd = document.createElement('td');
            signalTd.textContent = network.signal_strength;
            tr.appendChild(signalTd);

            const encryptionTd = document.createElement('td');
            encryptionTd.textContent = network.encryption;
            tr.appendChild(encryptionTd);

            const wpsTd = document.createElement('td');
            wpsTd.textContent = network.wps_enabled ? 'Yes' : 'No';
            tr.appendChild(wpsTd);

            const clientsTd = document.createElement('td');
            clientsTd.textContent = network.client_count > 0 ? '*' : '0';
            tr.appendChild(clientsTd);

            tbody.appendChild(tr);
        });
    }

    setupEventListeners() {
        document.getElementById('save-preparation').addEventListener('click', () => {
            this.savePreparation();
        });

        document.getElementById('save-targets').addEventListener('click', () => {
            this.saveTargets();
        });

        document.getElementById('select-all').addEventListener('change', (e) => {
            const checkboxes = document.querySelectorAll('#networks-table tbody input[type="checkbox"]');
            checkboxes.forEach(cb => {
                cb.checked = e.target.checked;
                const id = parseInt(cb.dataset.id);
                if (e.target.checked) {
                    this.selectedTargets.add(id);
                } else {
                    this.selectedTargets.delete(id);
                }
            });
        });

        document.getElementById('target-input').addEventListener('input', (e) => {
            const val = parseInt(e.target.value);
            if (!isNaN(val) && val > 0 && val <= this.networks.length) {
                const networkId = this.networks[val - 1].id;
                this.selectedTargets.add(networkId);
                this.populateNetworksTable();
            }
        });

        // Attack menu toggles handled by Bootstrap collapse, no extra JS needed here

        document.getElementById('exit-airgeddon').addEventListener('click', () => {
            if (confirm('Are you sure you want to exit Airgeddon?')) {
                // Reset selections and UI or navigate away
                this.resetModule();
            }
        });
    }

    savePreparation() {
        const ifaceSelect = document.getElementById('interface-select');
        const modeSelect = document.getElementById('mode-select');
        this.selectedInterface = ifaceSelect.value;
        this.selectedMode = modeSelect.value;

        if (!this.selectedInterface) {
            alert('Please select an interface.');
            return;
        }
        if (!this.selectedMode) {
            alert('Please select a mode.');
            return;
        }

        alert(`Interface "${this.selectedInterface}" and mode "${this.selectedMode}" saved. Proceeding to Target Discovery.`);
        // Here you could hide Section 1 and show Section 2 or navigate accordingly
    }

    saveTargets() {
        if (this.selectedTargets.size === 0) {
            alert('Please select at least one target network.');
            return;
        }
        alert(`Selected targets saved: ${Array.from(this.selectedTargets).join(', ')}. Proceeding to Attack Methods.`);
        // Here you could hide Section 2 and show Section 3 or navigate accordingly
    }

    resetModule() {
        this.selectedInterface = null;
        this.selectedMode = null;
        this.selectedTargets.clear();
        document.getElementById('interface-select').value = '';
        document.getElementById('mode-select').value = '';
        document.getElementById('target-input').value = '';
        document.getElementById('select-all').checked = false;
        this.populateNetworksTable();
        alert('Airgeddon module reset.');
    }
}

// Export the class for dynamic instantiation
window.AirgeddonModule = AirgeddonModule;
