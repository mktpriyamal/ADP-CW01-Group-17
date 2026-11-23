# Raw Dataset Quality & Anomaly Analysis Report

**Module:** CI7340 Applied Data Programming — Coursework 1 (Group 17)  
**Source File Analysed:** [`data/raw/dataset_coursework1.csv`](../data/raw/dataset_coursework1.csv)  
**Document Purpose:** Comprehensive technical audit of the current raw dataset status, missing/null values, disguised sentinels, data-type & cross-column incompatibilities, false/invalid values, and categorical variable distributions to guide Group 17's unified cleaning pipeline.

---

## Table of Contents

1. [Executive Summary & Current Dataset Status](#1-executive-summary--current-dataset-status)
2. [Missing Values, Nulls & Disguised Sentinels](#2-missing-values-nulls--disguised-sentinels)
3. [Data Types, Schema & Formatting Incompatibilities](#3-data-types-schema--formatting-incompatibilities)
4. [False, Invalid & Anomalous Values](#4-false-invalid--anomalous-values)
5. [Cross-Column Incompatibilities & Referential Integrity](#5-cross-column-incompatibilities--referential-integrity)
6. [Categorical Columns Deep Audit](#6-categorical-columns-deep-audit)
7. [Prioritised Remediation Roadmap for Cleaning Pipeline](#7-prioritised-remediation-roadmap-for-cleaning-pipeline)

---

## 1. Executive Summary & Current Dataset Status

### 1.1 File & Structural Overview

| Metric | Value | Notes |
| :--- | :---: | :--- |
| **Raw File Path** | `data/raw/dataset_coursework1.csv` | Compressed Git counterpart: `dataset_coursework1.csv.gz` (30.50 MB) |
| **File Size (Uncompressed)** | **176.43 MB** (`184,998,453` bytes) | — |
| **In-Memory Footprint (`pandas`)** | **231.71 MB** | Deep memory usage with default `read_csv()` |
| **Dimensions** | **508,106 rows × 30 columns** | `15,243,180` total data cells |
| **Temporal Coverage (`Start_Date_Time`)** | **2016-07-01 00:00:00** to **2026-09-14 20:44:00** | 2016 and 2026 are **partial years** (H2 2016 & Jan–Sep 2026) |
| **Exact Duplicate Rows** | **0** (`0.00%`) | Every row is unique across all 30 columns |
| **Unique `Incident ID`s** | **467,601** (`40,505` multi-offence rows) | Grain is **1 row = 1 offence within an incident**, not 1 incident |
| **Unique `(Incident ID, Offence Code)`** | **508,106** (`0` duplicates) | Confirmed true composite primary key of the table |
| **Unique `CR Number`s** | **467,534** | 67 fewer unique CR Numbers than `Incident ID`s (see §5.4) |
| **Total Missing (`NaN`) Cells** | **1,439,929** (`9.45%` of all cells) | Concentrated in 13 of 30 columns |
| **Complete Rows (0 `NaN`s)** | **0** (`0.00%`) | Every row has ≥1 `NaN` because `Street Prefix` (95.56%) & `Street Suffix` (98.64%) are structurally sparse |

### 1.2 Overall Data Quality Scorecard

| Quality Dimension | Status | Key Findings |
| :--- | :---: | :--- |
| **Completeness** | **Moderate** | 17 columns have 0% `NaN`; 13 columns contain nulls. Heavy structural missingness in `Street Suffix` (98.64%), `Street Prefix` (95.56%), `End_Date_Time` (55.59%), and `Dispatch Date / Time` (14.45% — 99.06% missing in 2016). |
| **Validity & Accuracy** | **Needs Cleaning** | `24,648` disguised null coordinates at `(0.0, 0.0)`, `8,418` negative durations (`Start > End`), `29,165` records with `Dispatch < Start`, `229` numeric/invalid `State` codes (e.g., `'16'`), `19` non-5-digit `Zip Code`s, and `>230` misspelled/rare `City` entries. |
| **Consistency & Integrity** | **Needs Cleaning** | Upstream ETL string-slicing bug turns `Police District Number = 'Unknown'` into `Beat = 'own'` and `Sector = 'w'` (`1,557` rows). `255` non-`MD` state rows have GPS coordinates inside Montgomery County. `143` rows have an `Address Number` with a null `Block Address`. |
| **Schema & Formatting** | **Needs Cleaning** | All 3 timestamp columns stored as `str`; `Zip Code` & `Address Number` upcast to `float64`; 100% of `Location` strings have 4 leading spaces; `451,976` `Block Address` values contain double spaces. |
| **Categorical Cleanliness** | **Moderate** | Core NIBRS hierarchy (`Crime Name1/2/3`, `NIBRS Code`, `Offence Code`) is 100% populated and referentially clean, but `Place` contains a deprecated label (`School/College - DO NOT USE`, `6,433` rows) and `Agency` has cryptic/corrupted codes (`P`, `OTHR`). |

---

## 2. Missing Values, Nulls & Disguised Sentinels

### 2.1 Explicit `NaN` / Null Summary (All 30 Columns)

Only **13 of 30 columns** contain explicit `NaN` values. The remaining 17 columns are 100% non-null, though several hide missingness behind sentinel tokens (see §2.4).

| # | Column Name | Raw `dtype` | Null Count | Null % | Unique Values | Missingness Classification |
| :-: | :--- | :--- | :---: | :---: | :---: | :--- |
| 24 | `Street Suffix` | `str` | **501,176** | **98.64%** | 6 | **Structural** — Most streets have no directional suffix |
| 22 | `Street Prefix` | `str` | **485,545** | **95.56%** | 4 | **Structural** — Most streets have no directional prefix |
| 5 | `End_Date_Time` | `str` | **282,444** | **55.59%** | 157,941 | **Structural / Operational** — Omitted for point-in-time incidents |
| 3 | `Dispatch Date / Time` | `str` | **73,405** | **14.45%** | 397,963 | **Systemic (MNAR)** — CAD dispatch logging started April 2017; walk-in/online reports lack dispatch |
| 12 | `Block Address` | `str` | **39,804** | **7.83%** | 23,491 | **Operational / Privacy** — Intersections, highways, parks, or redacted addresses |
| 21 | `Address Number` | `float64` | **39,661** | **7.81%** | 441 | **Operational / Privacy** — Closely tracks `Block Address` (differs by 143 rows) |
| 14 | `State` | `str` | **9,509** | **1.87%** | 12 | **Data Entry Omission** — Implicitly `MD` for Montgomery County jurisdiction |
| 15 | `Zip Code` | `float64` | **3,474** | **0.68%** | 206 | **Data Entry / Geocoding Gap** — Recoverable via coordinates or city/street |
| 25 | `Street Type` | `str` | **1,856** | **0.37%** | 35 | **Structural / Entry Gap** — Highways, intersections, or unparsed street names |
| 11 | `Police District Name` | `str` | **1,542** | **0.30%** | 8 | **Systemic** — Maps 100% to `Police District Number = 'Unknown'` (along with 15 `'OTHER'` rows) |
| 23 | `Street Name` | `str` | **1,467** | **0.29%** | 8,156 | **Operational / Privacy** — Unspecified or redacted locations |
| 13 | `City` | `str` | **37** | **0.01%** | 314 | **Sporadic** — Very low missingness |
| 20 | `PRA` | `str` | **9** | **0.002%** | 808 | **Sporadic** — Plus `1,557` disguised `'Unknown'` strings |
| — | *Remaining 17 Columns* | *Various* | **0** | **0.00%** | — | `Incident ID`, `Offence Code`, `CR Number`, `Start_Date_Time`, `NIBRS Code`, `Victims`, `Crime Name1–3`, `Agency`, `Place`, `Sector`, `Beat`, `Latitude`, `Longitude`, `Police District Number`, `Location` |

### 2.2 Missingness Co-Occurrence Patterns

Examining which columns are simultaneously missing reveals clear structural clusters:

| Rank | Row Count | % of Dataset | Simultaneously Missing Columns |
| :-: | :---: | :---: | :--- |
| 1 | **201,878** | 39.73% | `End_Date_Time`, `Street Prefix`, `Street Suffix` |
| 2 | **167,170** | 32.90% | `Street Prefix`, `Street Suffix` *(effectively complete records)* |
| 3 | **33,748** | 6.64% | `Dispatch Date / Time`, `End_Date_Time`, `Street Prefix`, `Street Suffix` |
| 4 | **29,176** | 5.74% | `Dispatch Date / Time`, `Street Prefix`, `Street Suffix` |
| 5 | **21,734** | 4.28% | `End_Date_Time`, `Block Address`, `Address Number`, `Street Prefix`, `Street Suffix` |
| 6 | **9,507** | 1.87% | `Block Address`, `Address Number`, `Street Prefix`, `Street Suffix` |
| 7 | **8,866** | 1.74% | `End_Date_Time`, `Street Suffix` |
| 8 | **7,713** | 1.52% | `Street Suffix` |
| 9 | **3,393** | 0.67% | `End_Date_Time`, `State`, `Street Prefix`, `Street Suffix` |
| 10 | **3,357** | 0.66% | `State`, `Street Prefix`, `Street Suffix` |

> [!NOTE]
> Excluding the two optional directional fields (`Street Prefix` and `Street Suffix`), **167,170+ rows** are completely populated across all analytical columns, and `Block Address` + `Address Number` almost always go missing together.

### 2.3 Temporal Missingness of `Dispatch Date / Time` (MNAR Proof)

`Dispatch Date / Time` missingness is **strongly non-random across time** — driven by a CAD system rollout in **April 2017** (earliest non-null dispatch is `2017-04-02 07:37:54`) and an increase in non-dispatched/online reporting from 2023 onward:

| `Start_Date_Time` Year | Total Records | Missing Dispatch | Missing % | Operational Explanation |
| :---: | :---: | :---: | :---: | :--- |
| **2016** *(H2 only)* | 28,270 | **28,004** | **99.06%** | Pre-CAD integration era (only delayed 2017+ reports have dispatch timestamps) |
| **2017** | 56,355 | **16,105** | **28.58%** | Partial-year coverage (Jan–Mar 2017 missing; logging begins 2 Apr 2017) |
| **2018** | 54,468 | 2,772 | 5.09% | Steady-state baseline |
| **2019** | 52,666 | 2,856 | 5.42% | Steady-state baseline |
| **2020** | 45,369 | 546 | 1.20% | Low missingness |
| **2021** | 44,915 | 616 | 1.37% | Low missingness |
| **2022** | 48,814 | 582 | 1.19% | Low missingness |
| **2023** | 47,832 | 3,108 | 6.50% | Rise in self-reported / online / administrative entries |
| **2024** | 50,151 | **7,759** | **15.47%** | Sustained elevated non-dispatch rate |
| **2025** | 47,359 | **6,641** | **14.02%** | Sustained elevated non-dispatch rate |
| **2026** *(Jan–Sep)* | 31,907 | **4,416** | **13.84%** | Sustained elevated non-dispatch rate |

### 2.4 Disguised Nulls & Sentinel Values (Hidden Missingness)

A standard `.isna().sum()` misses **tens of thousands** of records where missingness is encoded as a placeholder value:

| Column | Disguised Null / Sentinel Value | Affected Rows | % of Dataset | Impact if Unhandled |
| :--- | :--- | :---: | :---: | :--- |
| `Latitude` & `Longitude` | `0.0` & `0.0` (**Null Island**) | **24,648** | **4.85%** | Corrupts maps, centroids, KDE heatmaps, and mean coordinates |
| `Location` | `'    (0.0, 0.0)'` | **24,648** | **4.85%** | Mirrors Null Island coordinates with 4 leading spaces |
| `Place` | `'Other/Unknown'` | **40,895** | **8.05%** | 4th largest `Place` category; represents unclassified venue |
| `Police District Number` | `'Unknown'` | **1,557** | **0.31%** | Masks `1,542` null + `15` `'OTHER'` district names |
| `PRA` | `'Unknown'` (and `'000'`: 2) | **1,557** (+2) | **0.31%** | Same 1,557 rows as `Police District Number == 'Unknown'` |
| `Beat` | `'own'` | **1,557** | **0.31%** | Truncated substring of `'Unknown'` (ETL bug) |
| `Sector` | `'w'` *(lowercase)* | **1,557** | **0.31%** | Truncated character of `'Unknown'` (ETL bug) |
| `Police District Name` | `'OTHER'` | **15** | 0.003% | Paired with `Police District Number == 'Unknown'` |
| `Agency` | `'OTHR'` (4), `'P'` (3) | **7** | 0.001% | Unspecified / truncated agency codes |
| `City` | `'0'` (1), `'MARYLAND'` (1) | **2** | <0.001% | Placeholder/state name entered in `City` |
| `State` | `'0'` (1) | **1** | <0.001% | Numeric zero sentinel |
| `Address Number` | `0.0` (`'O00 BLK  BETHESDA METRO CTR'`) | **1** | <0.001% | Letter `'O'` typo in block number parsed as `0.0` |

> [!IMPORTANT]
> **Whitespace-only strings:** `0` across all 30 columns. All empty values were properly parsed as `NaN` by `pandas.read_csv()`, but leading/double whitespace issues exist in populated string columns (see §3.2).

---

## 3. Data Types, Schema & Formatting Incompatibilities

### 3.1 Inappropriate Raw Data Types

| Column(s) | Current `pandas` `dtype` | Expected / Target `dtype` | Root Cause & Impact |
| :--- | :--- | :--- | :--- |
| `Dispatch Date / Time`, `Start_Date_Time`, `End_Date_Time` | `str` (object) | `datetime64[ns]` | Stored as 12-hour strings (`MM/DD/YYYY HH:MM:SS AM/PM`). All 3 columns parse cleanly with **0 format failures** under `%m/%d/%Y %I:%M:%S %p`. |
| `Zip Code` | `float64` | `str` (5-digit zero-padded string) | Upcast to float due to `3,474` `NaN`s (renders as `20904.0`). ZIP codes are categorical postal identifiers, not continuous numbers. |
| `Address Number` | `float64` | `Int64` (nullable integer) or `str` | Upcast to float due to `39,661` `NaN`s (renders as `1000.0`). |
| `Offence Code` | `str` | `str` (categorical code) | 99.999% are 4-digit numeric strings (`9108`, `2901`), but **6 rows** are alphabetic (`FTAS`: 5, `NSUP`: 1) — **cannot** be cast to integer. |
| `PRA` | `str` | `str` (categorical code) | Primarily 3-digit zero-padded codes (`094`, `702`), but contains `'Unknown'` (`1,557`), `'1A3'` (`1`), and `NaN` (`9`) — must stay string to preserve leading zeros. |
| `CR Number` | `int64` | `str` (identifier) | Mixed string lengths: **466,811** rows are 9 digits (e.g., `260040147`), while **41,295** rows are 8 digits (mostly 2016–2017: `16xxxxxx` = 27,402; `17xxxxxx` = 13,797). |
| Low-cardinality text fields | `str` | `category` | `Crime Name1` (4), `Agency` (8), `Police District Name` (8), `Police District Number` (8), `Sector` (16), `NIBRS Code` (54), `Beat` (60), `Place` (100) — converting saves significant memory. |

### 3.2 String & Whitespace Formatting Defects

| Column | Defect Type | Affected Rows | Example |
| :--- | :--- | :---: | :--- |
| `Location` | **4 leading spaces** on every record | **508,106 (100.00%)** | `'    (39.0457, -76.992)'` |
| `Block Address` | **Double spaces** between `BLK` and street name | **451,976 (96.51% of non-null)** | `'1000 BLK  MILESTONE DR'` |
| `Place` | **Inconsistent hyphen spacing** | **23,347+** | `'Residence -Townhouse/Duplex'` (22,325), `'Shelter-Mission/Homeless'` (1,022) |
| `City` | **Double spaces / trailing punctuation** | **6+** | `'SILV ER SPRING'`, `'ROCKVILLE,'` |

---

## 4. False, Invalid & Anomalous Values

### 4.1 Temporal Anomalies

All three datetime columns parse with **0 strict parse errors**, and no dates fall before 2016 or after 2026. However, deep chronological checks reveal major logical anomalies:

| Anomaly Check | Affected Rows | % of Applicable | Root Cause & Analytical Guidance |
| :--- | :---: | :---: | :--- |
| **`Start_Date_Time > End_Date_Time`** (Negative Duration) | **8,418** | 3.73% of rows with `End` | **77.44% (`6,519` rows)** occur because `End_Date_Time` is **`12:00:00 AM` (`00:00:00`) on the same calendar day** as `Start_Date_Time` (date entered without time → defaults to midnight, which precedes daytime start). `5` rows have midnight on an earlier date; **`1,894` rows** are true non-midnight inversions (AM/PM or date-entry errors). |
| **`Start_Date_Time == End_Date_Time`** (Zero Duration) | **15,138** | 6.71% of rows with `End` | Point-in-time events recorded with identical start/end timestamps. |
| **`End - Start > 365 days`** (Multi-year Duration) | **1,099** | 0.49% of rows with `End` | Long-running frauds, identity thefts, embezzlement, or year typos (0 rows exceed 10 years). |
| **`Dispatch Date / Time < Start_Date_Time`** | **29,165** | 6.71% of rows with `Dispatch` | Police dispatched *before* recorded crime start: **8,701** exceed 1 hour early; **1,841** exceed 1 day early. Typically officer-initiated stops, rounding (`Start` has `sec == 0` on 100% of rows), or AM/PM/date entry errors. |
| **`Dispatch Date / Time < End_Date_Time`** | **42,204** | 22.7% of rows with both | Ongoing offences where police were dispatched before the incident concluded, or `End` entry errors. |
| **`Dispatch - Start > 365 days`** (Delayed Report >1 yr) | **2,125** | 0.49% of rows with `Dispatch` | Historical/delayed crime reports (e.g., fraud, sexual assault, or legacy 2016 crimes reported in 2017+). |
| **Midnight (`00:00:00`) Heaping** | `21,760` (`Start`) / `16,318` (`End`) | **4.28%** / **7.23%** | Default timestamp when exact hour is unknown — creates an artificial midnight spike in hourly crime charts! |
| **Zero-Second Rounding (`:00`)** | `508,106` (`Start`) / `225,662` (`End`) | **100.00%** / **100.00%** | `Start` and `End` are always truncated to minute precision (`Dispatch` retains second precision: only 1.59% have `:00`). |
| **Partial Boundary Years (2016 & 2026)** | `28,270` (2016) / `31,907` (2026) | 5.56% / 6.28% | Must be excluded or explicitly annotated in annual trend totals (`2017–2025` are the 9 complete calendar years). |

### 4.2 Geospatial & Address Anomalies

1. **Null Island Coordinates `(0.0, 0.0)` — `24,648` rows (`4.85%`):**
   - `Latitude == 0.0` and `Longitude == 0.0` always co-occur (`24,648` rows each; `0` rows have only one zero).
   - **All remaining `483,458` non-zero coordinates (`95.15%`) fall strictly inside Montgomery County's valid bounding box** (`Lat: [38.90, 39.38]`, `Lon: [-77.55, -76.85]`; actual non-zero max `Lat = 39.35124`, min `Lon = -77.5167`). There are **0 out-of-county GPS outliers** once `(0.0, 0.0)` is removed!
   - Crucially, of the `24,648` Null Island rows, only `1,704` are missing `Block Address` — meaning **`22,944` rows have a valid street/block address** whose geocoding failed or was intentionally suppressed (top offences: `All Other Offenses` 5,959, `Simple Assault` 2,202, `Theft From Motor Vehicle` 1,956, `Vandalism` 1,778).

2. **Corrupted & Out-of-State `State` Values — `367` non-`MD` rows (+ `9,509` nulls):**
   - **Numeric / Invalid Codes (`229` rows):** `'16'` (**224 rows** — Maryland's county code `16` for Montgomery County accidentally entered into `State`!), `'7'` (1), `'17'` (1), `'15'` (1), `'0'` (1), `'MC'` (1 — abbreviation for Montgomery County).
   - **Other US States (`138` rows):** `'DC'` (121), `'VA'` (12), `'ME'` (2), `'MS'` (2), `'ND'` (1).

3. **Invalid & Non-Maryland `Zip Code`s — `149` anomalous rows (+ `3,474` nulls):**
   - **Not 5-digit (`19` rows):** Truncated or malformed numbers ranging from `6` to `2910` (e.g., `2902`, `2906`, `2087`, `874`, `209`, `6` — mostly missing a middle digit from `20902`, `20874`, etc.).
   - **5-digit Outside Maryland (`20600–21999`) (`130` rows):** Mostly bordering Washington, D.C. (`20012`: 19, `20011`: 9, `20001`: 6) and Northern Virginia (`22032`, `22314`, `22202`, `22102`), plus digit-transposition typos like `29874` (5 rows, likely `20874` Germantown) and `29882` (likely `20882` Gaithersburg).

4. **Severe `City` Typo & Abbreviation Pollution — `314` unique values:**
   - Although there are **0 case-variant duplicates** (all values are uppercase), **236 of 314 unique cities (`75.2%`) appear ≤ 5 times** (totalling 389 rows), overwhelmingly consisting of data-entry typos, abbreviations, and noise:
     - **Abbreviations:** `'TP'` (**538 rows** = Takoma Park), `'MCG'` (**387 rows** = Montgomery County Government / unincorporated), `'N. BETHESDA'`, `'MONT VILLAGE'`.
     - **Misspellings:** `'SILVE4R SPRING'`, `'SILV ER SPRING'`, `'SILVER SPRNIG'`, `'SILVER SPRIGN'`, `'RCKVILLE'`, `'ROCKVILLE,'`, `'GAISTHERSBURG'`, `'GAITHERSBURD'`, `'GERANTOWN'`, `'CERWOOD'`, `'CALARKSBURG'`, `'KENSINGTOWN'`, `'KENSONGTON'`, `'NORTH BEHTESDA'`, `'MONTGGOMERY VILLAGE'`, `'MCGGAITHERSBURG'`.
     - **Invalid Entries:** `'0'` (1), `'MARYLAND'` (1).

5. **`Address Number` Outliers:**
   - **1 zero value (`0.0`):** Paired with `Block Address = 'O00 BLK  BETHESDA METRO CTR'` (letter `O` typed instead of `0`).
   - **184 extreme values (`> 50,000`, max `2,090,600.0`):** Values such as `2,090,600`, `1,810,000`, `980,000`, `60,000` appear to be ZIP codes or street numbers accidentally multiplied by 100 during block-rounding anonymisation.

### 4.3 Numeric Outlier Audit (`Victims`)

- **Range:** `1` to `22` (`0` nulls, `0` values `<= 0`).
- **Distribution:** Heavily concentrated at 1 victim (`499,046` rows = **98.22%**); `9,060` rows (`1.78%`) have 2–9 victims (`2`: 7,704; `3`: 928; `4`: 288; `5`: 86; `6`: 23; `7`: 23; `8`: 5; `9`: 2).
- **Single Extreme Outlier (`Victims == 22`):** `Incident ID = 201090564` (`2016-07-23 04:30:00 PM`, `Simple Assault` / `ASSAULT - SIMPLE` at `Residence - Apartment/Condo`). Plausible (e.g., apartment building disturbance/altercation) and should be **retained**, but documented as a right-tail outlier when reporting mean/max victim counts.

---

## 5. Cross-Column Incompatibilities & Referential Integrity

### 5.1 Upstream ETL String-Slicing Bug (`1,557` Rows)

Every single row where `Police District Number == 'Unknown'` (**1,557 rows**) exhibits a deterministic corruption across four spatial-command columns:

| Column | Expected Value | Observed Value in Raw Data | Affected Rows | Diagnosis |
| :--- | :--- | :--- | :---: | :--- |
| `Police District Number` | `'Unknown'` | `'Unknown'` | 1,557 | Sentinel string |
| `Police District Name` | `'Unknown'` / `NaN` | `NaN` (**1,542**) or `'OTHER'` (**15**) | 1,557 | Inconsistent split between `NaN` and `'OTHER'` |
| `PRA` | `'Unknown'` / `NaN` | `'Unknown'` | 1,557 | Sentinel string |
| `Beat` | `'Unknown'` / `NaN` | **`'own'`** | **1,557** | **String-slicing bug:** `"Unknown"[4:]` → `'own'` |
| `Sector` | `'Unknown'` / `NaN` | **`'w'`** *(lowercase!)* | **1,557** | **String-slicing bug:** `"Unknown"[5]` → `'w'` |

Additionally, **`1,542` of these `1,557` rows** (matching the exact `NaN` count in `Police District Name`) also have **Null Island `(0.0, 0.0)`** coordinates.

### 5.2 `State != 'MD'` vs. Valid Montgomery County GPS Coordinates

- Out of **367 non-null rows** where `State != 'MD'`, **255 rows (`69.5%`)** have valid non-zero GPS coordinates located **strictly inside Montgomery County, Maryland** (mostly the 224 rows where `State == '16'`, plus border entries tagged `'DC'` or `'VA'`).
- This confirms those `State` values are **data-entry errors**, not out-of-state incidents.

### 5.3 `Block Address` vs. `Address Number` Discrepancy

- `Block Address` is null on `39,804` rows; `Address Number` is null on `39,661` rows.
- **`143` rows** have a populated `Address Number` while `Block Address` is `NaN` (`0` rows have the reverse).

### 5.4 `Incident ID` vs. `CR Number` Many-to-One Edge Cases

- `Incident ID` always maps to exactly 1 `CR Number` (`0` Incident IDs have >1 CR Number).
- However, **`67` `CR Number`s map to >1 `Incident ID`** (explaining `467,601` unique Incident IDs vs `467,534` unique CR Numbers). Therefore, **`Incident ID`** (not `CR Number`) is the reliable incident-level deduplication key.

### 5.5 `Location` String vs. `Latitude` / `Longitude` Consistency

- After stripping the 4 leading spaces from `Location`, **0 rows** are unparseable and **0 rows** disagree with `Latitude`/`Longitude` beyond `1e-4` degrees (rounding to 4 decimal places). `Location` is **100% redundant** with `Latitude` and `Longitude` and can be dropped in the cleaned dataset.

### 5.6 Verified Clean Referential Mappings (0 Violations)

The following hierarchical mappings were verified to be **100% consistent** across all `508,106` rows:
- `Offence Code` (360) → `NIBRS Code` (54): **0 conflicts**
- `Offence Code` (360) → `Crime Name3` (360): **0 conflicts** (strict 1:1)
- `NIBRS Code` (54) → `Crime Name1` (4): **0 conflicts**
- `NIBRS Code` (54) → `Crime Name2` (54): **0 conflicts** (strict 1:1)
- `Beat` (60) → `Sector` (16): **0 conflicts**
- `Beat` (60) → `Police District Number` (8): **0 conflicts**
- `Police District Number` → `Police District Name`: Strict 1:1 for all 7 valid districts (`1D`–`6D`, `TPPD`); conflict exists only on `'Unknown'` (`NaN` vs `'OTHER'`).

---

## 6. Categorical Columns Deep Audit

### 6.1 Categorical Cardinality & Health Matrix

| Column | Unique Values | Nulls | Top Category (Share) | Key Data Quality / Analytical Issues |
| :--- | :---: | :---: | :--- | :--- |
| `Crime Name1` | **4** | 0 | `Crime Against Property` (48.46%) | Contains **`Crime Against Not a Crime`** (`6,158` rows = 1.21%: Runaway `6,143` + Justifiable Homicide `15`). |
| `NIBRS Code` | **54** | 0 | `90Z` (23.86%) | `90Z` (`121,221` rows) is a massive catch-all (`All Other Offenses`) dominated by non-criminal calls (`POLICE INFORMATION`, `MENTAL ILLNESS`, `LOST PROPERTY`, `SUDDEN DEATH`, `MISSING PERSON`). |
| `Crime Name2` | **54** | 0 | `All Other Offenses` (23.86%) | 1:1 with `NIBRS Code`; long tail down to 1 record (`Operating/Promoting/Assisting Gambling`: 1). |
| `Crime Name3` | **360** | 0 | `LARCENY - FROM AUTO` (8.13%) | 1:1 with `Offence Code`; high granularity, some truncated descriptions (`COMM SEX OFF - TRANSPORT FEMALE INTERSTATE FOR IMM`). |
| `Offence Code` | **360** | 0 | `2305` / `9108` etc. | Mixed format: 358 numeric 4-digit codes + **2 alphabetic codes** (`FTAS`: 5, `NSUP`: 1). |
| `Agency` | **8** | 0 | `MCPD` (85.50%) | Contains cryptic/corrupted codes: **`P`** (3 rows) and **`OTHR`** (4 rows). Cross-district overlaps occur legitimately (e.g., `MCPD` & `RCPD` both operate in `ROCKVILLE`). |
| `Police District Name` | **8** | 1,542 | `SILVER SPRING` (20.93%) | `1,542` `NaN`s + `15` `'OTHER'` rows. Must not be conflated with USPS `City`. |
| `Police District Number` | **8** | 0 | `3D` (20.93%) | Cleanest district key (`1D`–`6D`, `TPPD`), plus `'Unknown'` (`1,557`). |
| `Sector` | **16** | 0 | `A` (9.75%) | 15 valid uppercase letters (`A–T`), plus **1 corrupted lowercase `'w'`** (`1,557` rows). |
| `Beat` | **60** | 0 | `3G1` (6.44%) | 55 standard `[1-6][A-Z][0-9]` beats + 3 Takoma Park beats (`8T1–8T3`, `14,949` rows) + **`'own'`** (`1,557`, ETL bug) + **`'-PG'`** (`1` row, border artifact). |
| `PRA` | **808** | 9 | `702` (1.76%) | High cardinality; contains `'Unknown'` (`1,557`), `'000'` (`2`), and **`'1A3'`** (`1` row — a Beat code in PRA!). |
| `Place` | **100** | 0 | `Residence - Single Family` (10.32%) | Contains **`Other/Unknown`** (`40,895`, 8.05%), deprecated **`School/College - DO NOT USE`** (`6,433`, 1.27%), and hyphen-spacing inconsistencies (`Residence -Townhouse/Duplex`). |
| `City` | **314** | 37 | `SILVER SPRING` (34.56%) | Heavily polluted: **236 cities have ≤5 rows** (typos), plus abbreviations (`TP`: 538, `MCG`: 387) and invalid entries (`0`, `MARYLAND`). |
| `State` | **12** | 9,509 | `MD` (98.06%) | Polluted with county code `'16'` (224), single digits (`0, 7, 15, 17`), `'MC'`, and misassigned `DC`/`VA`. |
| `Street Prefix` | **4** | 485,545 | `N` (1.55%) | Clean valid compass directions (`N`, `E`, `W`, `S`), 95.56% null. |
| `Street Suffix` | **6** | 501,176 | `W` (0.77%) | Clean valid directions (`W`, `E`, `N`, `S`, `NW`, `NE`), 98.64% null. |
| `Street Type` | **35** | 1,856 | `RD` (24.80%) | Non-standard USPS abbreviations: `BLV` (28,169 vs `BLVD`), `LA` (26,838) coexisting with `LN` (1), `PIK` (12,938), `PKW` (4,595), rare/obscure codes (`CLS`, `FAR`, `OV`). |

### 6.2 Key Low-Cardinality Distributions

#### `Crime Name1` (4 Categories — 0% Null)
| Category | Count | Share (%) | Analytical Note |
| :--- | :---: | :---: | :--- |
| `Crime Against Property` | 246,236 | **48.46%** | Largest criminal category (larceny, vandalism, auto theft, burglary, fraud) |
| `Crime Against Society` | 202,327 | **39.82%** | Includes **121,221 `90Z` (`All Other Offenses`)** — many are non-criminal service calls! |
| `Crime Against Person` | 53,385 | **10.51%** | Assaults, sex offences, homicide, kidnapping |
| `Crime Against Not a Crime` | 6,158 | **1.21%** | `Runaway` (6,143) and `Justifiable Homicide` (15) — flag/separate in crime-rate analysis |

#### `Agency` (8 Categories — 0% Null)
| Agency | Count | Share (%) | Status |
| :--- | :---: | :---: | :--- |
| `MCPD` | 434,446 | 85.50% | Valid (Montgomery County Police Dept.) |
| `RCPD` | 28,878 | 5.68% | Valid (Rockville City Police Dept.) |
| `GPD` | 28,541 | 5.62% | Valid (Gaithersburg Police Dept.) |
| `TPPD` | 14,841 | 2.92% | Valid (Takoma Park Police Dept.) |
| `MCFM` | 1,237 | 0.24% | Valid (Montgomery County Fire Marshal) |
| `MCSO` | 156 | 0.03% | Valid (Montgomery County Sheriff's Office) |
| `OTHR` | 4 | 0.001% | Sentinel / Other (all in Rockville district, Drug/Narcotic Violations) |
| `P` | 3 | 0.001% | Invalid / Truncated code (investigate or group into `OTHR`) |

#### `Police District Number` / `Police District Name`
| District Number | District Name | Count | Share (%) |
| :---: | :--- | :---: | :---: |
| `3D` | `SILVER SPRING` | 106,353 | 20.93% |
| `4D` | `WHEATON` | 93,816 | 18.46% |
| `6D` | `MONTGOMERY VILLAGE` | 85,293 | 16.79% |
| `2D` | `BETHESDA` | 72,723 | 14.31% |
| `1D` | `ROCKVILLE` | 69,433 | 13.67% |
| `5D` | `GERMANTOWN` | 63,982 | 12.59% |
| `TPPD` | `TAKOMA PARK` | 14,949 | 2.94% |
| `Unknown` | `NaN` (1,542) / `OTHER` (15) | 1,557 | 0.31% |

---

## 7. Prioritised Remediation Roadmap for Cleaning Pipeline

| Priority | Target Column(s) | Recommended Cleaning Action |
| :---: | :--- | :--- |
| **P0 (Critical)** | `Latitude`, `Longitude` | Replace `0.0` (Null Island, `24,648` rows) with `NaN` and add a boolean flag `has_valid_coords` so spatial charts never plot `(0, 0)`. |
| **P0 (Critical)** | `Dispatch Date / Time`, `Start_Date_Time`, `End_Date_Time` | Parse all 3 to `datetime64[ns]`. Flag `is_negative_duration` (`8,418` rows where `Start > End`), `is_midnight_start` (`21,760` rows), and `is_full_year` (`2017–2025` vs partial `2016`/`2026`). Do **not** impute `Dispatch` for 2016–Q1 2017. |
| **P0 (Critical)** | `Police District Name`, `Beat`, `Sector`, `PRA` | Fix the `1,557`-row ETL slicing bug: replace `Beat == 'own'` and `Sector == 'w'` with `'Unknown'` (or `NaN`), unify `Police District Name` (`NaN` + `'OTHER'` → `'Unknown'`), and flag `Beat == '-PG'` (1) and `PRA == '1A3'` (1). |
| **P1 (High)** | `Incident ID`, `Crime Name1`, `NIBRS Code` | Preserve offence-level grain, but document incident-level deduplication via `Incident ID` (`467,601` incidents). Add boolean flags `is_not_a_crime` (`Crime Name1 == 'Crime Against Not a Crime'`) and `is_90z_other` (`NIBRS Code == '90Z'`) for sensitivity analysis. |
| **P1 (High)** | `State`, `Zip Code`, `City` | Standardise `State` (correct `'16'`, `'MC'`, single-digit codes, and in-county coordinates to `'MD'`). Cast `Zip Code` to 5-digit string and nullify `<10000` invalid zips (`19` rows). Normalize `City` abbreviations (`TP` → `TAKOMA PARK`) and collapse typos via a curated lookup table. |
| **P1 (High)** | `Place` | Standardise hyphen spacing (`Residence -Townhouse/Duplex` → `Residence - Townhouse/Duplex`) and map/document deprecated `'School/College - DO NOT USE'` (`6,433` rows) alongside active school categories; create grouped `Place_Category` (Residence, Street, Parking, Retail, School, etc.). |
| **P2 (Medium)** | `Location`, `Block Address`, `Street Prefix`, `Street Suffix` | Drop redundant `Location` (100% derivable from `Latitude`/`Longitude`, plus 4 leading spaces). Collapse double spaces in `Block Address`. Drop or keep `Street Prefix` (95.56% null) and `Street Suffix` (98.64% null) only if full address reconstruction is needed. |
| **P2 (Medium)** | `Address Number`, `Agency`, `Offence Code`, `CR Number` | Cast `Address Number` to nullable `Int64` (flag `== 0` and `> 50,000`). Keep `Offence Code`, `CR Number`, and `PRA` as `str`. Group `Agency == 'P'` (3) into `'OTHR'` or flag as unknown. |
