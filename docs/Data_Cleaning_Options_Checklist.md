# Data Cleaning Decisions & Options Checklist

**Module:** CI7340 Applied Data Programming — Coursework 1 (Group 17)  
**Source Dataset:** [`data/raw/dataset_coursework1.csv`](../data/raw/dataset_coursework1.csv)  
**Reference Audit:** [`docs/Dataset_Quality_Analysis.md`](Dataset_Quality_Analysis.md)  
**Instructions:** Review each of the 14 data quality issues below and tick (`- [x]`) **one option** per item (or choose **Option D** to write your own custom rule) to lock in the cleaning rules for Group 17's unified cleaning pipeline.

---

## Quick Decision Summary Table

| # | Issue / Column(s) | Scope | Recommended | Final Choice |
| :-: | :--- | :--- | :---: | :---: |
| 1 | Null Island Coordinates `(0.0, 0.0)` | `24,648` rows (4.85%) | **Option A** | `___` |
| 2 | Negative Durations (`Start > End`) | `8,418` rows | **Option A** | `___` |
| 3 | Missing `End_Date_Time` | `282,444` rows (55.59%) | **Option A** | `___` |
| 4 | Missing & Early `Dispatch Date / Time` | `73,405` nulls; `29,165` early | **Option A** | `___` |
| 5 | Partial Years (`2016`, `2026`) & Midnight Heaping | `60,177` partial-yr; `21,760` midnight | **Option A** | `___` |
| 6 | ETL Slicing Bug (`Beat='own'`, `Sector='w'`) & District/PRA | `1,557` rows + 13 edge rows | **Option A** | `___` |
| 7 | Corrupted & Missing `State` | `9,509` nulls; `367` non-MD | **Option A** | `___` |
| 8 | Invalid & Missing `Zip Code` | `3,474` nulls; `19` malformed; `130` non-MD | **Option A** | `___` |
| 9 | Polluted `City` Column | `314` unique (`236` typos/rare) | **Option A** | `___` |
| 10 | `Place` Deprecated & Inconsistent Categories | `6,433` legacy; `40,895` unknown | **Option A** | `___` |
| 11 | Non-Criminal & Catch-All Taxonomy (`Not a Crime`, `90Z`) | `6,158` + `121,221` rows | **Option A** | `___` |
| 12 | Multi-Offence Incidents (`Incident ID` vs `CR Number`) | `40,505` multi-offence rows | **Option A** | `___` |
| 13 | Sparse, Redundant & Messy Address Columns | `Location`, `Street Prefix/Suffix`, `Address Number` | **Option A** | `___` |
| 14 | Cryptic `Agency` Codes & `Victims == 22` Outlier | `7` agency rows; `1` victim outlier | **Option A** | `___` |

---

## 1. Null Island Coordinates `(0.0, 0.0)` (`24,648` rows — 4.85%)

- [x] **Option A (Recommended):** Replace `0.0` in `Latitude`/`Longitude` with `NaN` and add a boolean flag `has_valid_coords`. Keep all rows for non-spatial analysis; filter `has_valid_coords == True` for maps.
- [ ] **Option B:** Impute missing coordinates using the median `Latitude`/`Longitude` of the row's `Beat` or `Zip Code`.
- [ ] **Option C:** Drop all `24,648` rows from the dataset completely.
- [ ] **Option D (Custom):** _Write your suggestion here:_ 

> [!TIP]
> **Why Option A:** Preserves 100% of crime counts for temporal/offence RQs without inventing fake GPS coordinates or losing 4.85% of records.

---

## 2. Negative Crime Durations (`Start_Date_Time > End_Date_Time`, `8,418` rows)

- [x] **Option A (Recommended):** Nullify `End_Date_Time` (`NaT`) for all `8,418` inverted rows and add a flag `has_invalid_end_time` (keep `Start_Date_Time` untouched).
- [ ] **Option B:** For the `6,519` same-day midnight (`00:00:00`) rows, shift `End_Date_Time` to `23:59:00` of that same day; nullify the remaining `1,899` true inversions.
- [ ] **Option C:** Swap `Start_Date_Time` and `End_Date_Time` whenever `Start > End`.
- [ ] **Option D (Custom):** _Write your suggestion here:_ 

> [!TIP]
> **Why Option A:** Safest and most defensible academically; avoids fabricating end times (Option B) or corrupting `Start_Date_Time` (Option C).

---

## 3. Missing `End_Date_Time` (`282,444` rows — 55.59%)

- [ ] **Option A (Recommended):** Keep `NaT` as-is (structural missingness for point-in-time incidents) and compute `duration_mins` only where `End_Date_Time` is valid.
- [ ] **Option B:** Impute missing `End_Date_Time` with `Start_Date_Time` (assuming 0-minute duration).
- [ ] **Option C:** Drop the `End_Date_Time` column entirely.
- [x] **Option D (Custom):** first find same incident number and if End_Date_Time available and same time then fill End_Date_Time column. otherwise keep current as it is. secondly do option A.

> [!TIP]
> **Why Option A:** Preserves the distinction between instantaneous events and multi-hour/multi-day crime windows without skewing duration medians to zero.

---

## 4. Missing & Early `Dispatch Date / Time` (`73,405` nulls; `29,165` where `Dispatch < Start`)

- [ ] **Option A (Recommended):** Keep `NaT` for nulls (do **not** impute 2016–Q1 2017 pre-CAD era). For response/reporting-delay analysis, filter to `Dispatch >= Start` and add a flag `has_valid_dispatch_delay`.
- [ ] **Option B:** Set `Dispatch Date / Time` to `NaT` whenever `Dispatch < Start` (removes negative delays permanently).
- [ ] **Option C:** Drop `Dispatch Date / Time` completely due to 2016–2017 MNAR missingness.
- [x] **Option D (Custom):** First check same `Incident ID` for recoverable `Dispatch Date / Time` (0 rows recoverable). For the main analysis, keep missing `Dispatch Date / Time` as `NaT` and use only records with valid non-negative delays (`Dispatch >= Start`, flagged with `has_valid_dispatch_delay`). Rejected group-minimum imputation because minimum timestamps return 2017 dates and minimum delays return 0 seconds. As a sensitivity check, add `dispatch_delay_mins_imputed` using the group median delay by `(Crime Name1, NIBRS Code, Start_Year)` applied only where valid delays exist for that group, and flag imputed rows with `is_imputed_dispatch`.

> [!TIP]
> **Why Option A:** Retains raw operational timestamps for auditability while preventing negative reporting delays from distorting operational RQs.

---

## 5. Partial Boundary Years (`2016`: `28,270`; `2026`: `31,907`) & Midnight Heaping (`00:00:00`)

- [ ] **Option A (Recommended):** Keep all rows in the cleaned dataset, and add helper flags: `is_full_year` (`2017 <= year <= 2025`) and `is_midnight_start` (`hour == 0 & minute == 0`). Use `is_full_year == True` for annual trend totals.
- [ ] **Option B:** Drop `2016` and `2026` rows permanently so only the 9 full years (`2017–2025`) remain.
- [ ] **Option C:** Keep all rows with no flags and include `2016`/`2026` in all charts with text annotations only.
- [x] **Option D (Custom):** go with A plus the year_coverage column, use is_full_year for annual totals, use month-matched or per-day rates when you want to show 2026, and apply the midnight flag only to time-of-day analysis with a sensitivity comparison. Document the decision in your methodology section so a marker or reader can see exactly why those choices were made.

> [!TIP]
> **Why Option A:** Matches the coursework dataset span while making it effortless and error-proof to filter full years for YoY comparisons and check midnight-heaping sensitivity.

---

## 6. ETL String-Slicing Bug (`1,557` rows: `Beat='own'`, `Sector='w'`) & District/PRA Edge Cases

- [ ] **Option A (Recommended):** Replace `Beat == 'own'` and `Sector == 'w'` with `'Unknown'`; unify `Police District Name` (`NaN` and `'OTHER'` → `'Unknown'`); replace `Beat == '-PG'` (1) and `PRA == '1A3'` (1) / `'000'` (2) / `NaN` (9) with `'Unknown'`.
- [ ] **Option B:** Replace all corrupted values above with `NaN` instead of the string `'Unknown'`.
- [ ] **Option C:** Drop all `1,557` rows where `Police District Number == 'Unknown'`.
- [x] **Option D (Custom):** first fill missing using geopandas filter by long and latitude columns then do Option A

> [!TIP]
> **Why Option A:** Cleanly fixes the upstream ETL bug while keeping `Police District Number`, `Police District Name`, `Beat`, `Sector`, and `PRA` 100% consistent with `'Unknown'` (no silent drops in `groupby()`).

---

## 7. Corrupted & Missing `State` (`9,509` nulls; `224` `'16'`; `5` other invalid; `138` non-MD)

- [ ] **Option A (Recommended):** Fix corrupted codes (`'16'`, `'7'`, `'17'`, `'15'`, `'0'`, `'MC'`) and any row with valid Montgomery County GPS coordinates to `'MD'`; fill remaining `NaN`s with `'MD'` (all records belong to Montgomery County, MD jurisdiction).
- [ ] **Option B:** Fix only the clearly corrupted codes (`'16'`, `'7'`, `'17'`, `'15'`, `'0'`, `'MC'`) → `'MD'`, keep `'DC'`/`'VA'` border entries, and fill `NaN` with `'Unknown'`.
- [ ] **Option C:** Drop the `State` column entirely (99.9%+ constant `'MD'`).
- [x] **Option D (Custom):** first fill missing Status using geopandas filter by long and latitude columns then do Option A 

> [!TIP]
> **Why Option A:** Cleans every error deterministically while keeping the column available if needed for address/metadata tables (choose Option C if you prefer a leaner schema).

---

## 8. Invalid & Missing `Zip Code` (`3,474` nulls; `19` non-5-digit; `130` non-MD; `float64`)

- [ ] **Option A (Recommended):** Convert to 5-digit string (`str`); set the `19` non-5-digit values (`<10000`) to `NaN`; leave `3,474` nulls as `NaN` (or `'Unknown'`); keep valid 5-digit border zips (`DC`/`VA`) with a boolean flag `is_md_zip`.
- [ ] **Option B:** Same as Option A, plus spatially impute missing/invalid `Zip Code`s from valid `Latitude`/`Longitude` using a nearest-neighbour / polygon lookup.
- [ ] **Option C:** Drop `Zip Code` and rely solely on `Police District Number` and `City` for geography.
- [X] **Option D (Custom):** I chose Option B (Option A plus spatial imputation) because geopandas allows an exact point-in-polygon join between each incident's Latitude/Longitude and Census ZCTA boundaries, which avoids the boundary errors of a hand-built nearest-neighbour method. I first converted Zip Code to a five-digit string, set the 19 values below 10000 to NaN, and removed rows with invalid coordinates. I validated the spatial join on records with a known valid zip, and only after confirming a high agreement rate did I fill the 3,474 missing and 19 invalid values. Original values were never overwritten, and I added zip_source and is_md_zip flags so imputed and out-of-state values are transparent and can be excluded in sensitivity checks.

> [!TIP]
> **Why Option A:** Fast, clean, zero risk of mis-imputation, and uses only the allowed standard libraries (`pandas`/`numpy`).

---

## 9. Polluted `City` Column (`314` unique values, `236` typos/rare entries, `TP`, `MCG`, `37` nulls)

- [ ] **Option A (Recommended):** Strip/collapse whitespace & punctuation, map known abbreviations (`TP` → `TAKOMA PARK`, `MCG` → `MONTGOMERY COUNTY`) and top typos to official Montgomery County USPS city names via a clean dictionary, and group unmapped rare entries (`count <= 5` or invalid `'0'`/`'MARYLAND'`) into `'OTHER/UNKNOWN'`.
- [ ] **Option B:** Keep raw `City` untouched and create a new `City_Clean` column with only the top 20 valid Montgomery County communities + `'OTHER/UNKNOWN'`.
- [ ] **Option C:** Leave `City` as-is and avoid using it in visualisations (use `Police District Name` instead).
- [x] **Option D (Custom):** I chose Option A's cleaning logic but stored the result in a new City_Clean column so the raw City values remain available for audit. I first standardised the text by converting to uppercase, trimming whitespace, collapsing repeated spaces, and removing punctuation. I then mapped known abbreviations (such as TP to TAKOMA PARK) and frequent typos using a dictionary built from the most common values, and applied fuzzy matching with a high similarity cutoff to correct the remaining misspellings, which I reviewed manually to avoid wrongly merging distinct places. I treated MCG (and similar county-level or invalid entries such as '0' and 'MARYLAND') as non-city values, since mapping them to a place name would create a misleading category, and I left the 37 nulls as missing. Only values still unmatched after these steps and with five or fewer records were grouped into OTHER/UNKNOWN, which avoids discarding valid small communities. I rejected Option B's fixed top-20 list as too restrictive and Option C because it would discard a useful geographic variable. I recorded the number of unique values before and after each step to keep the cleaning transparent and reproducible.

> [!TIP]
> **Why Option A:** Directly fixes the messy `City` column so community-level charts are accurate and typo-free without losing valid towns.

---

## 10. `Place` Deprecated & Inconsistent Categories (`School/College - DO NOT USE`: `6,433`; `Other/Unknown`: `40,895`)

- [ ] **Option A (Recommended):** Fix hyphen spacing (`Residence -Townhouse/Duplex` → `Residence - Townhouse/Duplex`), rename `'School/College - DO NOT USE'` → `'School/College (Legacy)'`, keep `'Other/Unknown'`, **and** engineer a clean grouped column `Place_Group` (`Residence`, `Street/Roadway`, `Parking`, `Retail/Commercial`, `School/College`, `Other/Unknown`, etc.).
- [ ] **Option B:** Merge `'School/College - DO NOT USE'` directly into `'School - Elementary/Secondary'` or `'School - College/University'`.
- [ ] **Option C:** Leave all 100 `Place` strings completely unchanged.
- [X] **Option D (Custom):** I chose Option A, keeping the original Place column unchanged and creating Place_Clean and Place_Group columns. I normalised spacing around hyphens with a single regular expression so that all inconsistent variants (such as Residence -Townhouse/Duplex) were fixed consistently. I renamed the deprecated School/College - DO NOT USE label to School/College (Legacy) and placed it in the broad School/College group, rather than merging it into a specific school type as Option B suggests, because the data does not show whether those 6,433 records were elementary, secondary, or college incidents, and merging would introduce guesswork. I kept Other/Unknown (40,895 records) as its own category so the uncertainty stays visible, and I rejected Option C because 100 uncleaned labels would split counts and make visualisations hard to read. I confirmed that every row had a Place_Group, and I added an is_legacy_place flag after checking the legacy category by year, so any trend that depends on it can be interpreted correctly.

> [!TIP]
> **Why Option A:** Avoids guessing whether legacy school records were K-12 or College (Option B), while `Place_Group` eliminates 100-category clutter in visualisations.

---

## 11. Non-Criminal & Catch-All Taxonomy (`Crime Against Not a Crime`: `6,158`; `NIBRS 90Z`: `121,221`)

- [x] **Option A (Recommended):** Keep all rows in the cleaned dataset, and add two explicit boolean flags: `is_not_a_crime` (`Crime Name1 == 'Crime Against Not a Crime'`) and `is_90z_other` (`NIBRS Code == '90Z'`). Filter or segment by them per RQ.
- [ ] **Option B:** Drop all `6,158` `'Crime Against Not a Crime'` rows permanently during cleaning; keep `90Z`.
- [ ] **Option C:** Drop both `'Crime Against Not a Crime'` (`6,158`) and `'90Z'` (`121,221`) — removing `127,379` rows (`25.1%`).
- [ ] **Option D (Custom):** _Write your suggestion here:_ 

> [!TIP]
> **Why Option A:** Preserves the complete official dataset while allowing transparent sensitivity analysis and demonstrating strong NIBRS domain knowledge.

---

## 12. Multi-Offence Incidents (`40,505` repeated `Incident ID`s; `67` shared `CR Number`s)

- [x] **Option A (Recommended):** Keep the offence-level grain (`508,106` rows, unique on `(Incident ID, Offence Code)`), and document using `df['Incident ID'].nunique()` whenever counting unique incidents (never `CR Number`).
- [ ] **Option B:** Deduplicate to 1 row per `Incident ID` (`467,601` rows), keeping the most severe offence (Person > Property > Society).
- [ ] **Option C:** Maintain two separate cleaned files: `cleaned_offences.csv.gz` (`508,106` rows) and `cleaned_incidents.csv.gz` (`467,601` rows).
- [ ] **Option D (Custom):** _Write your suggestion here:_ 

> [!TIP]
> **Why Option A:** Avoids losing 40,505 secondary offences (critical for crime-type & victim RQs) and avoids maintaining two datasets when `.nunique()` on `Incident ID` handles incident counts cleanly.

---

## 13. Sparse, Redundant & Messy Address Columns (`Street Prefix`, `Street Suffix`, `Location`, `Block Address`, `Address Number`)

- [x] **Option A (Recommended):** Drop `Location` (100% redundant with `Latitude`/`Longitude`, plus 4 leading spaces), drop `Street Prefix` (`95.56%` null) and `Street Suffix` (`98.64%` null); collapse double spaces in `Block Address`; cast `Address Number` to nullable `Int64` and nullify `== 0` (`1` row) & `> 50,000` (`184` rows).
- [ ] **Option B:** Drop `Location` only; keep `Street Prefix` and `Street Suffix` untouched; clean `Block Address` spacing and cast `Address Number` to `Int64`.
- [ ] **Option C:** Keep all 30 original columns (only strip `Location` leading spaces and `Block Address` double spaces).
- [ ] **Option D (Custom):** _Write your suggestion here:_ 

> [!TIP]
> **Why Option A:** Eliminates 3 dead-weight columns cleanly while keeping `Block Address`, `Street Name`, `Street Type`, and cleaned `Address Number` intact.

---

## 14. Cryptic `Agency` Codes (`P`: `3`, `OTHR`: `4`) & `Victims == 22` Outlier (`1` row)

- [ ] **Option A (Recommended):** Map `Agency == 'P'` (3 rows) into `'OTHR'` (total 7 rows); **keep** `Victims == 22` (plausible multi-victim apartment assault) and document it as a right-tail outlier.
- [ ] **Option B:** Drop the 7 `Agency` (`'P'`/`'OTHR'`) rows and cap/winsorise `Victims` at 9.
- [ ] **Option C:** Leave both `Agency` and `Victims` completely untouched.
- [x] **Option D (Custom):** I chose Option A. For Agency, I created Agency_Clean and mapped the three P records into OTHR (seven rows in total), after checking that nothing in those rows indicated they belonged to a named agency; this avoids showing two near-empty categories while keeping every incident in the dataset. I rejected Option B because deleting seven valid incidents over a vague agency code loses real information, and winsorising Victims to 9 would replace an actual recorded value with a number that never occurred. For Victims == 22, I inspected the record's crime type and location, judged it a plausible multi-victim incident, and kept it, adding an is_victim_outlier flag so that the effect of this right-tail value can be tested. I reported Victims summaries using the median alongside the mean and compared results with and without the flagged row, so any conclusion is shown to be robust to this single observation. I rejected Option C because leaving the cryptic codes unaddressed would leave redundant categories in the charts and no documentation of the outlier.

> [!TIP]
> **Why Option A:** Cleans the obvious truncated `'P'` code without discarding valid incident data or artificially altering a legitimate victim count.
