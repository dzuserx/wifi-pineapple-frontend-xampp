# TODO: Fix Airgeddon Module Data Loading Issue

## Problem
- When navigating to airgeddon via sidebar links, JS loads but data from airgeddon.json does not populate UI elements (#interface-select, #networks-table).
- When opening URL directly with hash, data loads correctly.

## Root Cause
- AirgeddonModule instance created immediately on script load, before module HTML is in DOM.
- UI population functions fail because elements don't exist yet.

## Solution Steps
- [x] Refactor `js/modules/submodules/airgeddon.js` to export AirgeddonModule class without immediate instantiation
- [x] Modify `js/pineapple.js` to instantiate AirgeddonModule after module HTML is loaded
- [x] Store instance in moduleInstances map for lifecycle management
- [x] Fix duplicate script loading issue for main modules
- [x] Fix API.getReconData() to fetch recon.json correctly (was using wrong path)
- [x] Add Chart.js library to index.html for Recon module charts
- [ ] Test sidebar navigation to airgeddon module
- [ ] Test direct URL navigation to airgeddon module
- [ ] Test sidebar navigation to recon module
- [ ] Test direct URL navigation to recon module
- [ ] Verify data loads and UI populates correctly in both cases
