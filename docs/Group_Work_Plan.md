# CI7340 Applied Data Programming — Group Coursework Plan

**Assessment:** Research Report and Visualisation (40% of module grade)  
**Dataset:** Montgomery County, USA Crime Statistics (`dataset_coursework1.csv`, 1 July 2016 – 10 Sept 2026)  
**Team Members (Remote / Work From Home):**
- **Thisara** *(Data Engineering Lead & Technical Coordinator)*
- **Sachithra** *(Project Coordinator & Report Integration Lead)*
- **Kavindu** *(EDA Strategy Lead & Quality Assurance Lead)*

---

## 1. Assignment Requirements at a Glance

| Parameter | Requirement |
| :--- | :--- |
| **Deliverable** | 1 group report (**PDF preferred**, `.docx` accepted) via Canvas using the provided coursework template |
| **Cover Page** | Report title + full names & KU IDs of all 3 members |
| **Word Limit** | **4,000 – 5,000 words** (±10% tolerance: 3,600–5,500 words). **Target: ~4,700–4,850 words** |
| **Analysis Tool** | Python (Jupyter Notebooks used for analysis; notebook is not mandatory and cannot replace the report) |
| **Research Questions** | **10 Research Questions (RQs)**, each supported by **2 visualisations** = **20 visualisations total** |
| **Referencing** | Consistent style — **IEEE preferred** (include books, journals, and official sources) |
| **Group Approval** | Must inform Dr. Farzana Rahman and get team approval before starting |
| **Generative AI Policy** | Category 2 (Default): Core RQs, analysis, interpretations, and 20 visuals must be our own. If GAI is used for permitted tasks (grammar, structure, research support), include an **Acknowledgement of Generative AI (GAI) Contribution** section at the end |
| **Dataset Domain Note** | NIBRS/UCR founded crime reports — **one incident can have multiple offences, and each offence can have multiple victims** (must be explained clearly in the report) |

---

## 2. Work Division Summary (Balanced by Marks, Coding & Words)

| Member | Owned Report Sections | Assigned RQs & Charts | Marks | Target Words | Remote Support Role |
| :--- | :--- | :--- | :---: | :---: | :--- |
| **Thisara** | • Initial Data Quality Assessment (15)<br>• Descriptive Statistics (5)<br>• Data Visualisation: RQs 4–6 (12) | **RQs 4–6**<br>(6 visualisations)<br>*Crime Types, Offence & Victim Patterns* | **32** | ~1,600 | Builds & freezes the **single master cleaned dataset** + shared chart-styling script (`viz_style.py`) |
| **Sachithra** | • Introduction (10)<br>• Dataset Description (10)<br>• Data Visualisation: RQs 1–3 (12) | **RQs 1–3**<br>(6 visualisations)<br>*Temporal & Trend Patterns* | **32** | ~1,600 | Gets module leader approval, manages master report template, word count, Canvas similarity check & final PDF |
| **Kavindu** | • Introduction to EDA (15)<br>• Data Visualisation: RQs 7–10 (16)<br>• Conclusion & References (5) | **RQs 7–10**<br>(8 visualisations)<br>*Spatial, Location & Operational Patterns* | **36** | ~1,650 | Peer-reviews all 20 charts for visual consistency/accuracy & manages IEEE reference list |
| **Total** | **All Required Sections** | **10 RQs / 20 Visualisations** | **100** | **~4,850** | **Full End-to-End Coverage** |

> **Why this split is fair:** Kavindu handles 1 extra RQ (2 extra charts), while Thisara handles the heavy upfront Python data-cleaning & wrangling pipeline, and Sachithra handles final report compilation, formatting, and submission QA.

---

## 3. Detailed Member Checklists

### Thisara — Data Engineering Lead (32 Marks | ~1,600 Words)
- [ ] **Initial Data Quality Assessment (15 marks, ~800 words):**
  - Audit missing values, duplicates, noise, outliers, and inconsistencies across all columns in Python.
  - Compare multiple cleaning & missing-data handling methods (e.g., drop vs. imputation vs. domain-rule fill) with Python code/output evidence and justify final choices.
  - Quantify the exact proportion (%) of records or noise affected at each step.
  - Document data wrangling: feature extraction (dates/times), aggregations, and constructing analytical datasets.
  - **Milestone:** Export and freeze `cleaned_crime_data.parquet` (and/or `.csv`) + `viz_style.py` for Sachithra and Kavindu.
- [ ] **Descriptive Statistics (5 marks, ~350 words):**
  - Produce clean statistical summary tables (numerical & categorical) on the cleaned dataset.
  - Justify why each statistical metric is suitable and how it supports the 10 RQs.
- [ ] **Visualisations for RQs 4–6 (12 marks, ~450 words):**
  - Create **6 high-resolution charts** (2 per RQ) using the shared style script.
  - Write concise, evidence-based interpretations linked directly to each RQ.
- [ ] **Contribution to Conclusion:** Share 3–4 bullet points of key findings & data quality limitations with Kavindu.

### Sachithra — Project Coordinator (32 Marks | ~1,600 Words)
- [ ] **Admin:** Email Dr. Farzana Rahman for group approval (include all 3 names & KU IDs).
- [ ] **Introduction (10 marks, ~650 words):**
  - Introduce Montgomery County crime dataset in a data science context.
  - Define a focused **problem statement**, **justified scope**, and proposed methodology.
  - Present the agreed **10 Research Questions** clearly.
  - Include a **workflow diagram/figure or summary table** illustrating the end-to-end pipeline.
- [ ] **Dataset Description (10 marks, ~500 words):**
  - Explain data provenance/source (Montgomery County Police Dept / NIBRS / CJIS UCR), file format, structured nature, row/column count, and data types (summary table).
  - Critically explain **incident vs. offence vs. victim** distinctions and preliminary-report recording limitations.
- [ ] **Visualisations for RQs 1–3 (12 marks, ~450 words):**
  - Create **6 high-resolution charts** (2 per RQ) using the frozen cleaned dataset & shared style script.
  - Write concise, evidence-based interpretations linked directly to each RQ.
- [ ] **Report Assembly & Submission:** Merge all sections into the Kingston template, verify word count (4,000–5,000), check Canvas Originality Report, and export the final PDF.
- [ ] **Contribution to Conclusion:** Share 3–4 bullet points of key findings & limitations with Kavindu.

### Kavindu — EDA Strategy & QA Lead (36 Marks | ~1,650 Words)
- [ ] **Introduction to EDA (15 marks, ~700 words):**
  - Explain EDA objectives and strategy in relation to our problem statement.
  - Revisit data quality post-cleaning and assess further transformation needs (e.g., binning, log scaling, grouping, incident-level vs. offence-level views).
  - Compare EDA approaches and visualisation techniques (e.g., bar/line charts, heatmaps, boxplots, spatial plots) and rigorously justify why our chosen techniques fit each RQ.
- [ ] **Visualisations for RQs 7–10 (16 marks, ~600 words):**
  - Create **8 high-resolution charts** (2 per RQ) using the frozen cleaned dataset & shared style script.
  - Write concise, evidence-based interpretations linked directly to each RQ.
- [ ] **Conclusion & References (5 marks, ~350 words):**
  - Synthesise findings across all 10 RQs into a cohesive conclusion answering the problem statement.
  - Clearly acknowledge dataset, analytical, and methodological limitations.
  - Compile and format all external citations (books, journals, official docs) in **IEEE style**.
  - Draft the **Acknowledgement of Generative AI (GAI) Contribution** section (if applicable).
- [ ] **Visual QA Check:** Review all 20 figures for consistent font sizes, colour palette, clear titles, axis labels, units, and figure numbering (`Figure 1` – `Figure 20`).

---

## 4. Remote Execution Timeline (Extended Deadline: Friday, 27 Nov 2026, 23:59)

| Phase | Calendar Date | Key Activities | Deliverable / Exit Gate |
| :--- | :--- | :--- | :--- |
| **Phase 1: Kickoff & Alignment** | **Sun, 22 Nov** *(Today)* | • **Done:** Dataset Domain Brief + raw `.csv.gz` pushed to GitHub<br>• Agree on Problem Statement, Scope & all **10 RQs** (60-min call)<br>• All 3 clone repo & verify `.venv`; Sachithra emails module leader for approval | Approved 10 RQs list & all 3 local environments verified |
| **Phase 2: Data Freeze & Early Drafting** | **Mon, 23 Nov** *(Data Freeze)* | • **Thisara:** Completes Python data quality audit & pushes frozen `cleaned_crime_data.parquet` to GitHub by Mon evening<br>• **Sachithra:** Drafts Introduction, Workflow Diagram & Dataset Description<br>• **Kavindu:** Drafts Introduction to EDA, Chart Comparisons & collects IEEE sources | **DATA FREEZE (Mon 23 Nov evening)** — no one edits raw data separately after this |
| **Phase 3: Parallel Analysis & Visuals** | **Tue 24 – Wed 25 Nov** | • All 3 work independently on their assigned RQs using the frozen dataset:<br>  - Sachithra: RQs 1–3 (6 charts)<br>  - Thisara: Descriptive Stats (Tue) + RQs 4–6 (6 charts)<br>  - Kavindu: RQs 7–10 (8 charts)<br>• Daily evening sync on WhatsApp/Discord (*Done / Next / Blocked*) | All **20 PNG figures (300 DPI)** + interpretations pushed to GitHub by Wed night |
| **Phase 4: Integration & Cross-Review** | **Thu, 26 Nov** | • Paste all sections & 20 figures into Kingston report template<br>• Sachithra & Thisara send conclusion bullets to Kavindu<br>• Kavindu writes Conclusion, Limitations, IEEE References & GAI Declaration<br>• **Peer-Review Swap:** Sachithra → Thisara → Kavindu → Sachithra | Complete draft inside **4,000–5,000 words** with unified tone & style |
| **Phase 5: Final QA & Submission** | **Fri, 27 Nov** *(Deadline 23:59)* | • Kavindu completes 20-chart QA & IEEE citation check (morning)<br>• Sachithra uploads draft to Canvas to inspect **Originality Report** (afternoon)<br>• Fix any similarity/formatting issues, export **PDF**, and submit before 23:59 | **Final PDF submitted on Canvas before 27 Nov 23:59** |

---

## 5. Remote Collaboration Rules & Workspace Setup

### Shared Tools
- **Code & Data:** GitHub repository (for `.ipynb` notebooks and `viz_style.py`) + Shared Google Drive / OneDrive (for the 185 MB raw CSV and frozen `.parquet` file — *do not commit large CSVs to Git*).
- **Report Writing:** Microsoft Word Online (OneDrive) or Google Docs using the official Kingston template so all 3 can edit and comment live.
- **Communication:** WhatsApp / Discord / MS Teams for quick async updates + 3 short scheduled calls (Day 1 Kickoff, Day 3 Data Freeze, Day 8 Final Review).

### Repository / Folder Structure
```text
ci7340-group-assignment/
├── data/
│   ├── raw/
│   │   └── dataset_coursework1.csv          # Shared via Drive (read-only)
│   └── processed/
│       └── cleaned_crime_data.parquet       # Frozen by Thisara in Phase 2
├── notebooks/
│   ├── 00_data_cleaning_thisara.ipynb       # Master cleaning & quality audit
│   ├── 01_rq1_to_rq3_sachithra.ipynb        # Temporal analysis (6 charts)
│   ├── 02_stats_rq4_to_rq6_thisara.ipynb    # Descriptive stats + Crime/Victim (6 charts)
│   └── 03_eda_rq7_to_rq10_kavindu.ipynb     # Spatial/Operational analysis (8 charts)
├── utils/
│   └── viz_style.py                         # Shared palette, fonts, figure size, 300 DPI
└── figures/
    ├── fig01_rq1_a.png ... fig06_rq3_b.png  # Sachithra
    ├── fig07_rq4_a.png ... fig12_rq6_b.png  # Thisara
    └── fig13_rq7_a.png ... fig20_rq10_b.png # Kavindu
```

### Mandatory Consistency Rules (Prevents Remote Merge Issues)
1. **Single Source of Truth:** Every chart and statistic must be generated from `cleaned_crime_data.parquet` (never from personal copies of the raw CSV).
2. **One Notebook Per Member:** Never edit the same `.ipynb` file simultaneously.
3. **Uniform Chart Export:** All 20 figures must use `viz_style.py`, be exported as `.png` at **300 DPI**, and include a clear title, labelled axes with units, readable legend, and no overlapping text.
4. **Word Budget Discipline:** Stay within each member's ~1,600-word allocation so the combined report stays cleanly inside **4,000–5,000 words**.

---

## 6. Final Pre-Submission Checklist (Targeting Distinction 70%+)

- [ ] Cover page has Report Title, all 3 member names, and KU IDs, using the provided coursework template.
- [ ] Word count is strictly within **4,000–5,000 words** (±10%).
- [ ] Problem statement, scope, workflow diagram, and all **10 RQs** are clearly stated in the Introduction.
- [ ] Dataset description explicitly explains **incident vs. offence vs. victim** relationships and UCR/NIBRS limitations.
- [ ] Data quality assessment compares Python methods and quantifies the **% of records/noise affected**.
- [ ] EDA section revisits data quality post-cleaning and justifies transformations and visualisation choices.
- [ ] Descriptive statistics are accurate and explicitly linked to the RQs.
- [ ] All **20 visualisations** (exactly 2 per RQ) are numbered, legible, linked to their RQ, and critically interpreted with data evidence.
- [ ] Conclusion synthesises answers to all 10 RQs and states clear limitations.
- [ ] All external sources (books & journals) are consistently cited in **IEEE format**.
- [ ] **Acknowledgement of Generative AI (GAI) Contribution** section is included (if any AI tools were used).
- [ ] Canvas **Originality Report** checked and final file submitted as **PDF**.
