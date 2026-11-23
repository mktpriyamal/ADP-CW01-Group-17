# Unified Data Cleaning Plan (Pre-Execution Review)

**Module:** CI7340 Applied Data Programming — Coursework 1 (Group 17)  
**Input Dataset:** [`data/raw/dataset_coursework1.csv`](../data/raw/dataset_coursework1.csv) (`508,106` rows × `30` columns)  
**Target Output:** `data/processed/cleaned_crime_data.csv.gz` (plus optional `.parquet` if needed)  
**Source Inputs:** [`docs/Dataset_Quality_Analysis.md`](Dataset_Quality_Analysis.md) | [`docs/Data_Cleaning_Options_Checklist.md`](Data_Cleaning_Options_Checklist.md)  
**Status:** **CONFIRMED & READY TO EXECUTE** — All 14 cleaning decisions and both official GIS polygon files are verified.

---

## 1. Final Confirmation Status

All **14 of 14 checklist items**, both execution confirmations, and both official GIS polygon files are now **verified and ready**:
- **Items #1–#14:** Confirmed & verified safe against `dataset_coursework1.csv`.
- **Item #8 Row Retention:** Confirmed — keep all **`508,106` rows** in the final dataset (exclude Null Island `(0.0, 0.0)` rows only from the spatial join subset).
- **Spatial Join Method (Items #6, #7, #8):** Confirmed **Option 2.1 (Exact Point-in-Polygon Joins via `geopandas`)**.

> [!TIP]
> **Verified Official GIS Boundary Files in `data/external/`:**  
> - **[`data/external/montgomery_county_police_districts.geojson`](../data/external/montgomery_county_police_districts.geojson):** `2.56 MB`, `7` exact `Polygon`/`MultiPolygon` geometries in `EPSG:4326` (`AREA_P` ∈ `{1, 2, 3, 4, 5, 6, 8}` where `8 = TPPD`) → **Item #6** (Police District spatial join) & **Item #7** (Montgomery County, MD boundary).
> - **[`data/external/maryland_zip_codes.geojson`](../data/external/maryland_zip_codes.geojson):** `22 MB`, `445` exact Maryland ZIP Code `MultiPolygon` geometries in `EPSG:4326` (`zipcode1` 5-digit ZIP, `zipname` USPS community name) → **Item #8** (`Zip Code` point-in-polygon join) & **Item #7** (Maryland state boundary).

---

## 2. Empirical Dry-Run Summary (All 14 Checklist Decisions)

Every rule below was dry-run against `dataset_coursework1.csv` to verify exact row counts before touching any data:

| # | Decision | Selected | Exact Rows Impacted (Verified) | Safety Status |
| :-: | :--- | :---: | :--- | :---: |
| 1 | Null Island `(0.0, 0.0)` | **A** | `24,648` coords → `NaN` (`0` rows dropped) | Confirmed & Safe |
| 2 | Negative Durations (`Start > End`) | **A** | `8,418` `End_Date_Time` → `NaT` | Confirmed & Safe |
| 3 | Missing `End_Date_Time` | **D** | `0` recoverable via `Incident ID` → keep `282,444` (+`8,418`) `NaT` | Safe |
| 4 | Missing & Early `Dispatch` | **D** | `0` recoverable via `Incident ID`; main analysis keeps `73,405` `NaT` & flags `29,165` early; sensitivity col `dispatch_delay_mins_imputed` uses `(Crime Name1, NIBRS Code, Start_Year)` group median + `is_imputed_dispatch` | Confirmed & Safe |
| 5 | Partial Years & Midnight Heaping | **D** | `28,270` (2016) + `31,907` (2026) flagged; `21,760` midnight starts flagged | Safe |
| 6 | ETL Slicing Bug & District/PRA | **D** | **`15`** Unknown-district + **`12`** PRA + **`1`** Beat (`-PG`) spatially imputable; remaining **`1,542`** Null Island rows → `'Unknown'` | Safe (needs GIS choice) |
| 7 | Corrupted & Missing `State` | **D** | **`8,950`** missing + **`255`** non-MD rows have valid MoCo coords → `'MD'` via `geopandas`; remaining `559` missing → `'MD'` | Safe |
| 8 | Invalid & Missing `Zip Code` | **D** | **`3,399`** of `3,493` missing/invalid zips have valid coords (spatially imputable); **`94`** Null Island rows stay `NaN` | Confirm no row drops + GIS choice |
| 9 | Polluted `City` Column | **D** | New `City_Clean` column; raw `City` untouched; `37` nulls stay `NaN`; manual review of fuzzy matches (`difflib >= 0.85`) | Safe |
| 10 | `Place` Legacy & Grouping | **D** | New `Place_Clean`, `Place_Group`, `is_legacy_place` (`6,433` rows); raw `Place` untouched | Safe |
| 11 | Non-Criminal & `90Z` Flags | **A** | `is_not_a_crime` (`6,158` rows), `is_90z_other` (`121,221` rows); all rows kept | Safe |
| 12 | Multi-Offence Incidents | **A** | Keep all `508,106` rows (`467,601` unique `Incident ID`s) | Safe |
| 13 | Sparse & Redundant Address Cols | **A** | Drop `Location`, `Street Prefix`, `Street Suffix`; fix `451,976` double spaces in `Block Address`; nullify `185` invalid `Address Number`s | Safe |
| 14 | `Agency` & `Victims == 22` | **D** | New `Agency_Clean` (`'P'` → `'OTHR'`, 7 total); keep `Victims == 22` + add `is_victim_outlier` flag (`1` row) | Safe |

---

## 3. Step-by-Step Cleaning Pipeline Architecture

The pipeline is strictly ordered so that **coordinates are cleaned first** (preventing `(0.0, 0.0)` from poisoning spatial joins), **timestamps are validated before derived metrics**, and **all raw columns slated for preservation remain untouched for auditability**.

### Phase 1 — Ingestion & Schema Stabilisation
1. Load `data/raw/dataset_coursework1.csv` (or `.csv.gz`) with `low_memory=False`, preserving `Offence Code`, `CR Number`, and `PRA` as `str` (keeping leading zeros and alphabetic codes `FTAS`/`NSUP`).
2. Verify baseline integrity: `508,106` rows, `30` columns, `0` exact duplicates, `0` duplicate `(Incident ID, Offence Code)` pairs.

### Phase 2 — Geospatial Sanitisation (Item #1)
3. Identify Null Island records: `is_null_island = (Latitude == 0.0) & (Longitude == 0.0)` (`24,648` rows).
4. Set `Latitude` and `Longitude` to `np.nan` where `is_null_island` is `True`.
5. Create boolean flag `has_valid_coords` (`483,458` `True` / `24,648` `False`).
6. Assert all non-null coordinates fall strictly within Montgomery County's bounding box (`Lat ∈ [38.90, 39.38]`, `Lon ∈ [-77.55, -76.85]`).

### Phase 3 — Temporal Parsing, Validation & Coverage Flags (Items #2, #3, #4, #5)
7. Parse `Start_Date_Time`, `End_Date_Time`, and `Dispatch Date / Time` using exact format `%m/%d/%Y %I:%M:%S %p` (assert `0` parse failures on non-null strings).
8. **Item #3 (Step 1 guard):** Check for any null `End_Date_Time` where the same `Incident ID` has a single non-null `End_Date_Time` and backfill (verified `0` rows).
9. **Item #2 (Negative Durations):** Flag `has_invalid_end_time = End_Date_Time < Start_Date_Time` (`8,418` rows), then set `End_Date_Time = pd.NaT` on those rows.
10. Compute `duration_mins = (End_Date_Time - Start_Date_Time).dt.total_seconds() / 60.0` (only populated for valid non-negative windows; `NaN` otherwise).
11. **Item #4 (`Dispatch Date / Time`):**
    - Run same-`Incident ID` backfill guard (verified `0` rows).
    - **Main analysis:** Keep raw `Dispatch Date / Time` untouched (`73,405` `NaT` preserved). Create `has_valid_dispatch_delay = Dispatch.notna() & (Dispatch >= Start_Date_Time)` and compute `dispatch_delay_mins` only where `has_valid_dispatch_delay == True` (excludes `29,165` early-dispatch anomalies without altering raw timestamps).
    - **Sensitivity check:** Compute group median of valid `dispatch_delay_mins` grouped by `(Crime Name1, NIBRS Code, Start_Year)`. Create `dispatch_delay_mins_imputed` by filling missing `Dispatch Date / Time` delays with the group median **only where valid delays exist for that group**, and create boolean flag `is_imputed_dispatch` so imputed rows can be tested and excluded cleanly.
12. **Item #5 (Calendar Coverage & Midnight Heaping):**
    - Extract `Start_Year`, `Start_Month`, `Start_DayOfWeek`, `Start_Hour`.
    - Create `year_coverage`: `'Partial (H2 2016)'` for 2016, `'Full Year (2017-2025)'` for 2017–2025, `'Partial (Jan-Sep 2026)'` for 2026.
    - Create `is_full_year = Start_Year.between(2017, 2025)` (`447,929` `True`).
    - Create `is_midnight_start = (Start_Date_Time.dt.hour == 0) & (Start_Date_Time.dt.minute == 0)` (`21,760` `True`).

### Phase 4 — GeoPandas Spatial Recovery & Command Hierarchy Cleanup (Items #6, #7, #8)
13. Build a `GeoDataFrame` (`EPSG:4326`) strictly from rows with `has_valid_coords == True` (`483,458` rows).
14. **Item #6 (District / Beat / Sector / PRA):**
    - Fix ETL slicing corruption first in clean copies or in-place: mark `Beat == 'own'` (`1,557`), `Beat == '-PG'` (`1`), `Sector == 'w'` (`1,557`), `Police District Name` in `{NaN, 'OTHER'}` (`1,557`), `Police District Number == 'Unknown'` (`1,557`), and `PRA` in `{NaN, 'Unknown', '000', '1A3'}` (`1,569`) as candidates for spatial recovery.
    - For candidates with `has_valid_coords == True` (**`15`** district/beat/sector rows, **`1`** `-PG` beat row, **`12`** PRA rows), perform `geopandas` spatial join (validated first on known rows) and record `district_source` (`'original'`, `'spatial_imputed'`, `'unknown_no_coords'`).
    - For the remaining **`1,542`** Null Island rows (and any unmatched rows), standardise `Police District Number`, `Police District Name`, `Beat`, `Sector`, and `PRA` uniformly to `'Unknown'`.
15. **Item #7 (`State`):**
    - Keep raw `State` or track provenance via `state_source` (`'original_md'`, `'spatial_imputed_md'`, `'jurisdiction_default_md'`, `'original_other'`).
    - Spatially verify all `has_valid_coords == True` rows (`8,950` missing + `255` mislabeled like `'16'`, `'MC'`, `'0'`, `'7'`, `'15'`, `'17'`, border typos) fall inside Montgomery County, MD → assign `'MD'` in `State_Clean`.
    - Apply Option A to remaining `559` Null Island missing-`State` rows and remaining numeric/invalid codes → `'MD'`.
16. **Item #8 (`Zip Code`):**
    - Preserve raw `Zip Code`; create `Zip_Code_Clean` as 5-digit zero-padded string.
    - Set the `19` malformed values (`< 10000`) to `NaN`.
    - **Validation gate:** Run the `geopandas` spatial join on a validation sample of known valid-zip records and log exact agreement % (target ≥ 95%) before imputing.
    - Impute missing/invalid `Zip_Code_Clean` **only** where `has_valid_coords == True` (`3,399` rows); leave the `94` Null Island rows as `NaN`. Never overwrite existing valid 5-digit zips.
    - Add `zip_source` (`'original'`, `'spatial_imputed'`, `'missing_no_coords'`) and `is_md_zip` (`Zip_Code_Clean` in `20600–21999`, `bool`).

### Phase 5 — Categorical Text Standardisation (Items #9, #10, #11, #14)
17. **Item #9 (`City_Clean`):**
    - Keep raw `City` untouched; create `City_Clean`.
    - Uppercase, strip whitespace, collapse repeated spaces (`r'\s+'` → `' '`), strip trailing punctuation (`.,;`).
    - Apply explicit curated mapping dictionary: abbreviations (`'TP'` → `'TAKOMA PARK'`, `'N BETHESDA'` / `'N. BETHESDA'` → `'NORTH BETHESDA'`, `'MONT VILLAGE'` → `'MONTGOMERY VILLAGE'`, etc.) and non-city/invalid tokens (`'MCG'`, `'0'`, `'MARYLAND'` → `'NON-CITY/UNKNOWN'`). Leave `37` nulls as `NaN`.
    - Apply `difflib.get_close_matches()` (cutoff `>= 0.85`, Python stdlib) against the official list of Montgomery County USPS communities; **export/print every fuzzy match pair for manual audit** before applying.
    - Group any remaining unmatched values with `count <= 5` into `'OTHER/UNKNOWN'`.
    - Log unique city counts before and after every sub-step.
18. **Item #10 (`Place_Clean`, `Place_Group`, `is_legacy_place`):**
    - Keep raw `Place` untouched.
    - Create `Place_Clean`: apply regex `r'\s*-\s*'` → `' - '` (fixes `'Residence -Townhouse/Duplex'`, `'Shelter-Mission/Homeless'`, etc.), and rename `'School/College - DO NOT USE'` → `'School/College (Legacy)'`.
    - Create `is_legacy_place = (Place == 'School/College - DO NOT USE')` (`6,433` `True`).
    - Create `Place_Group` mapping all 100 `Place_Clean` values into ~10–12 clean analytical groups (`Residence`, `Street / Roadway`, `Parking Lot / Garage`, `Retail / Commercial`, `School / College`, `Food / Hospitality`, `Public / Government`, `Recreation / Park`, `Transit / Transportation`, `Religious / Community`, `Financial / Office`, `Other / Unknown`), asserting `0` unmapped rows.
19. **Item #11 (NIBRS Taxonomy Flags):**
    - Create `is_not_a_crime = (Crime Name1 == 'Crime Against Not a Crime')` (`6,158` `True`).
    - Create `is_90z_other = (NIBRS Code == '90Z')` (`121,221` `True`).
20. **Item #14 (`Agency_Clean` & `is_victim_outlier`):**
    - Keep raw `Agency` untouched; create `Agency_Clean` mapping `'P'` (`3` rows) → `'OTHR'` (`7` total).
    - Keep `Victims` untouched (retain `Victims == 22`); create `is_victim_outlier = (Victims >= 10)` (`1` `True`).

### Phase 6 — Address Cleanup & Column Pruning (Items #12, #13)
21. **Item #12:** Retain full offence-level grain (`508,106` rows). Do **not** deduplicate rows.
22. **Item #13:**
    - Drop `Location`, `Street Prefix`, and `Street Suffix` (3 redundant/95%+ null columns).
    - Clean `Block Address`: strip and collapse multiple spaces (`r'\s{2,}'` → `' '`, fixing `451,976` rows).
    - Cast `Address Number` to nullable `Int64`; create `has_invalid_addr_num = (Address Number == 0) | (Address Number > 50000)` (`185` rows) and set those `185` values to `pd.NA`.

---

## 4. Final Output Schema Summary

- **Rows:** Exactly **`508,106`** (`0` rows dropped).
- **Columns Dropped (`3`):** `Location`, `Street Prefix`, `Street Suffix`.
- **Original Columns Retained (`27`):** `Incident ID`, `Offence Code`, `CR Number`, `Dispatch Date / Time`, `Start_Date_Time`, `End_Date_Time`, `NIBRS Code`, `Victims`, `Crime Name1`, `Crime Name2`, `Crime Name3`, `Police District Name`, `Block Address`, `City`, `State`, `Zip Code`, `Agency`, `Place`, `Sector`, `Beat`, `PRA`, `Address Number`, `Street Name`, `Street Type`, `Latitude`, `Longitude`, `Police District Number`.
- **New Cleaned & Engineered Columns (`24`):**
  - *Spatial & Geographic:* `has_valid_coords`, `district_source`, `State_Clean`, `state_source`, `Zip_Code_Clean`, `zip_source`, `is_md_zip`, `City_Clean`
  - *Temporal:* `has_invalid_end_time`, `duration_mins`, `has_valid_dispatch_delay`, `dispatch_delay_mins`, `dispatch_delay_mins_imputed`, `is_imputed_dispatch`, `Start_Year`, `Start_Month`, `Start_DayOfWeek`, `Start_Hour`, `year_coverage`, `is_full_year`, `is_midnight_start`
  - *Categorical & Analytical Flags:* `Place_Clean`, `Place_Group`, `is_legacy_place`, `is_not_a_crime`, `is_90z_other`, `Agency_Clean`, `is_victim_outlier`, `has_invalid_addr_num`

---

## 5. Automated Post-Cleaning Verification Assertions

The cleaning script/notebook will run all **12 automated assertions** before saving `data/processed/cleaned_crime_data.csv.gz` — if any check fails, the save aborts:

1. `len(df) == 508_106` (zero accidental row loss)
2. `df.duplicated(subset=['Incident ID', 'Offence Code']).sum() == 0` (primary key intact)
3. `((df['Latitude'] == 0) | (df['Longitude'] == 0)).sum() == 0` (zero Null Island coords)
4. `df.loc[df['has_valid_coords'], 'Latitude'].between(38.90, 39.38).all()` (all valid coords inside MoCo)
5. `(df['End_Date_Time'] < df['Start_Date_Time']).sum() == 0` (zero negative durations)
6. `(df['duration_mins'] < 0).sum() == 0` and `(df['dispatch_delay_mins'] < 0).sum() == 0`
7. `df['Beat'].isin(['own', '-PG']).sum() == 0` and `(df['Sector'] == 'w').sum() == 0` (ETL slicing bug eliminated)
8. `df['Police District Name'].isna().sum() == 0` and `(df['Police District Name'] == 'OTHER').sum() == 0`
9. `df['Zip_Code_Clean'].dropna().str.match(r'^\d{5}$').all()` (all non-null zips strictly 5-digit strings)
10. `df['Place_Group'].isna().sum() == 0` (100% of rows mapped to a `Place_Group`)
11. `(df['Agency_Clean'] == 'P').sum() == 0`
12. `df['Block Address'].dropna().str.contains(r'  ').sum() == 0` (zero double spaces left)

---

## 6. Library Compliance Check

All transformations strictly use **only** Group 17's allowed libraries (`numpy`, `pandas`, `geopandas`) plus Python built-in standard library modules (`re`, `difflib`, `pathlib`).

---

### Execution Next Step
1. Place valid GeoJSON/Shapefile polygon files in `data/external/` for:
   - **Montgomery County Police Reporting Areas (PRA / Beat / District)** (actual GeoJSON features from Layer `0`, not service metadata)
   - **Maryland / Montgomery County ZIP Codes (ZCTA)**
2. Run the cleaning pipeline to produce `data/processed/cleaned_crime_data.csv.gz` and verify all 12 automated assertions.
