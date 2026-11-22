# CI7340 Applied Data Programming — Coursework 1 (Group 17)

**Module:** CI7340 Applied Data Programming (Kingston University, 2026/2027)  
**Assessment:** Research Report and Visualisation (40% of module grade)  
**Dataset:** Montgomery County, USA Founded Crime Statistics (NIBRS / CJIS UCR, 1 July 2016 – 10 Sept 2026)

## Team Members (Group 17 — Remote)
| Member | Role | Owned Sections | RQs & Visualisations | Marks |
| :--- | :--- | :--- | :--- | :---: |
| **Thisara** | Data Engineering Lead & Technical Coordinator | Initial Data Quality (15), Descriptive Statistics (5), RQs 4–6 (12) | RQs 4–6 (6 charts — Crime Types, Offences & Victims) | 32 |
| **Sachithra** | Project Coordinator & Report Integration Lead | Introduction (10), Dataset Description (10), RQs 1–3 (12) | RQs 1–3 (6 charts — Temporal & Trend Patterns) | 32 |
| **Kavindu** | EDA Strategy Lead & Visual QA Lead | Introduction to EDA (15), RQs 7–10 (16), Conclusion & IEEE Refs (5) | RQs 7–10 (8 charts — Spatial, Location & Operational) | 36 |

Full task checklists, remote execution timeline, and marking rubric checklist are in [docs/Group_Work_Plan.md](docs/Group_Work_Plan.md).  
**Start Here (Domain Onboarding):**
- **English Domain Brief (Visual Guide):** [docs/Dataset_Domain_Brief.md](docs/Dataset_Domain_Brief.md)
- **Sinhala Guides (සිංහලෙන්):** [Dataset Domain Knowledge](docs/Dataset_Domain_Knowledge_Sinhala.md) | [Dataset Profile](docs/Dataset_Profile_Sinhala.md) | [Assignment Explanation](docs/Assignment_Explanation_Sinhala.md)

---

## Allowed Libraries (Group 17 Standard)
All analysis, cleaning, and visualisations strictly use **only**:
- `numpy`
- `pandas`
- `matplotlib`
- `seaborn`
- `geopandas`

## Collaborative Data Cleaning Workflow
1. **Individual Analysis & Cleaning:** Each member works independently in their own notebook:
   - `notebooks/cleaning_and_analysis_thisara.ipynb`
   - `notebooks/cleaning_and_analysis_sachithra.ipynb`
   - `notebooks/cleaning_and_analysis_kavindu.ipynb`
2. **Team Review & Merge:** All 3 members review each other's cleaning methods and results together, then merge the best decisions into one unified final cleaning pipeline and frozen dataset (`data/processed/cleaned_crime_data.csv.gz`).
3. **Reference Files (Keep Untouched):** `notebooks/00_data_cleaning_thisara.ipynb` and all guides in `docs/` remain untouched as shared reference material.

---

## Project Structure
```text
ADP-CW01-Group-17/
├── data/
│   ├── raw/
│   │   └── dataset_coursework1.csv.gz       # Included in Git (31 MB compressed)
│   └── processed/
│       └── cleaned_crime_data.csv.gz        # Final merged & frozen dataset (after 3-way review)
├── notebooks/
│   ├── cleaning_and_analysis_thisara.ipynb      # Thisara's individual analysis & cleaning
│   ├── cleaning_and_analysis_sachithra.ipynb    # Sachithra's individual analysis & cleaning
│   ├── cleaning_and_analysis_kavindu.ipynb      # Kavindu's individual analysis & cleaning
│   ├── 00_data_cleaning_thisara.ipynb           # Reference template (unchanged)
│   ├── 01_rq1_to_rq3_sachithra.ipynb            # RQs 1–3 (6 visualisations)
│   ├── 02_stats_rq4_to_rq6_thisara.ipynb        # Descriptive stats + RQs 4–6 (6 visualisations)
│   └── 03_eda_rq7_to_rq10_kavindu.ipynb         # EDA checks + RQs 7–10 (8 visualisations)
├── utils/
│   └── viz_style.py                         # Shared palette, fonts, paths & 300 DPI save_fig()
├── figures/                                 # All 20 final PNGs (fig01_rq1_a.png .. fig20_rq10_b.png)
├── docs/
│   └── Group_Work_Plan.md                   # Detailed team plan, checklists & schedule
├── report/
│   └── drafts/                              # Section drafts, tables & final PDF export
├── requirements.txt
└── README.md
```

---

## Quickstart Setup (All Members)

### 1. Clone & Create Virtual Environment
```bash
git clone https://github.com/mktpriyamal/ADP-CW01-Group-17.git
cd ADP-CW01-Group-17

python -m venv .venv
# Linux / macOS:
source .venv/bin/activate
# Windows (PowerShell):
# .venv\Scripts\Activate.ps1

pip install -r requirements.txt
```

### 2. Dataset Included Ready-to-Use
- The raw dataset is already included in the repo as **`data/raw/dataset_coursework1.csv.gz`** (31 MB compressed, since GitHub blocks uncompressed files >100 MB).
- `pandas.read_csv(RAW_DATA_PATH)` reads `.csv.gz` natively without unzipping!
- Once **Thisara** freezes the cleaned dataset in Phase 2, pull the latest `main` (or download from Drive) for `data/processed/cleaned_crime_data.parquet`.

### 3. Use Shared Chart Styling in Every Notebook
Every notebook already imports `utils/viz_style.py`:
```python
import sys
from pathlib import Path
sys.path.append(str(Path("..").resolve()))

from utils.viz_style import apply_style, save_fig, CLEAN_DATA_PATH
apply_style()
```

---

## Remote Git Workflow (Avoid Merge Conflicts)
1. **Always pull before starting work:**
   ```bash
   git checkout main
   git pull origin main
   ```
2. **Work on your own branch** (one branch per member):
   - `thisara/data-cleaning-and-rq4-6`
   - `sachithra/rq1-3-temporal`
   - `kavindu/eda-and-rq7-10`
   ```bash
   git checkout -b <your-name>/<feature>
   ```
3. **Only edit your own notebook and figure files** so merges are always conflict-free.
4. **Commit & push regularly**, then open a Pull Request (or merge into `main` after checking with the team):
   ```bash
   git add notebooks/<your-notebook>.ipynb figures/fig*.png
   git commit -m "Add RQ1 visualisations and interpretations"
   git push -u origin <your-name>/<feature>
   ```
