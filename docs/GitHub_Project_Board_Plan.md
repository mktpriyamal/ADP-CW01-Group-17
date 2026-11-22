# GitHub Project Board Plan — Group 17 (`ADP-CW01-Group-17`)

**GitHub Project URL:** https://github.com/users/mktpriyamal/projects/2/views/1  
**Linked Repository:** https://github.com/mktpriyamal/ADP-CW01-Group-17  
**Extended Submission Deadline:** **Friday, 27 November 2026 at 23:59** *(All 19 issues have Start & Target dates set for the 22–27 Nov sprint)*

---

## 1. Recommended Board Setup (in Project #2)

### Status Columns (Kanban Board View)
1. **Backlog** — Planned tasks not yet started
2. **Ready** — Unblocked and ready to pick up
3. **In Progress** — Actively being worked on
4. **In Review** — PR opened / waiting on teammate peer review
5. **Done** — Merged into `main` or pasted & verified in master report

### Custom Fields to Add in Project Settings
| Field Name | Type | Options / Values |
| :--- | :--- | :--- |
| **Member** | Single select | `Thisara`, `Sachithra`, `Kavindu`, `All` |
| **Phase** | Single select | `Phase 1: Kickoff`, `Phase 2: Data Freeze`, `Phase 3: Analysis & Visuals`, `Phase 4: Integration`, `Phase 5: QA & Submit` |
| **Marks** | Number | Rubric mark weight (e.g., `10`, `15`, `12`, `16`, `5`) |
| **Target Words** | Number | Word budget for that section |

### Useful Views to Create
- **View 1 (Board):** Group by `Status` (daily Kanban tracking)
- **View 2 (Table — By Member):** Group by `Member`, show `Status`, `Phase`, `Marks`, `Target Words`
- **View 3 (Table — By Phase):** Group by `Phase`, sort by `Status`

---

## 2. All 19 Project Issues (Mapped to Rubric, Priority, Size & Live Status)

### Phase 1: Kickoff & Alignment (Day 1)
| # | Issue Title | Member | Marks | Priority / Size | Current Status | Key Acceptance Criteria |
| :-: | :--- | :--- | :-: | :-: | :-: | :--- |
| 19 | `[Domain] Dataset Domain Knowledge Brief & Visual Guide (5,000+ words)` | Thisara | — | `P0` / `L` | **Done** | `docs/Dataset_Domain_Brief.md` (7,169 words) + 6 custom infographics/charts + 4 Mermaid diagrams pushed to `main` |
| 1 | `[Admin] Obtain group approval from Dr. Farzana Rahman` | Sachithra | — | `P0` / `XS` | **Ready** | Email sent with all 3 names & KU IDs; approval confirmed |
| 2 | `[Kickoff] Finalise Problem Statement, Scope & 10 Research Questions` | All | — | `P0` / `M` | **Ready** | All 3 agree on Problem Statement, Scope & 10 RQs (1–3 Sachithra, 4–6 Thisara, 7–10 Kavindu) |
| 3 | `[Setup] Upload raw CSV to shared Drive & verify local environments` | Thisara | — | `P0` / `S` | **In progress** | Raw CSV shared via Drive; all 3 clone repo & run `pip install -r requirements.txt` |

### Phase 2: Data Freeze & Early Drafting (Days 2–3)
| # | Issue Title | Member | Marks | Key Acceptance Criteria |
| :-: | :--- | :--- | :-: | :--- |
| 4 | `[Data] Initial Data Quality Audit & Method Comparison (Python)` | Thisara | 15 | Missing values %, duplicates, date/coord anomalies, compare cleaning methods in `00_data_cleaning_thisara.ipynb` |
| 5 | `[Milestone] Freeze cleaned_crime_data.parquet & share with team` | Thisara | — | Clean dataset exported to Parquet, verified with team, uploaded to shared Drive (**Unblocks Phase 3**) |
| 6 | `[Report] Draft Introduction, Problem Statement, 10 RQs & Workflow Diagram` | Sachithra | 10 | ~650 words + end-to-end workflow diagram/table |
| 7 | `[Report] Draft Dataset Description (NIBRS/UCR & Incident/Offence/Victim)` | Sachithra | 10 | ~500 words + column/dtype summary table + recording limitations |
| 8 | `[Report] Draft Introduction to EDA & Visualisation Technique Comparisons` | Kavindu | 15 | ~700 words: EDA strategy, post-cleaning quality review, justified transformations & chart comparisons |

### Phase 3: Parallel Analysis & 20 Visualisations (Days 4–6)
| # | Issue Title | Member | Marks | Key Acceptance Criteria |
| :-: | :--- | :--- | :-: | :--- |
| 9 | `[Analysis] Descriptive Statistics Tables & Interpretation` | Thisara | 5 | ~350 words + summary tables linked to RQs in `02_stats_rq4_to_rq6_thisara.ipynb` |
| 10 | `[Visuals] RQs 1–3: Temporal & Trend Patterns (6 Charts)` | Sachithra | 12 | `fig01_rq1_a.png`..`fig06_rq3_b.png` (300 DPI) + ~450 words interpretation |
| 11 | `[Visuals] RQs 4–6: Crime Types, Offences & Victims (6 Charts)` | Thisara | 12 | `fig07_rq4_a.png`..`fig12_rq6_b.png` (300 DPI) + ~450 words interpretation |
| 12 | `[Visuals] RQs 7–10: Spatial, Location & Operational Patterns (8 Charts)` | Kavindu | 16 | `fig13_rq7_a.png`..`fig20_rq10_b.png` (300 DPI) + ~600 words interpretation |

### Phase 4: Integration & Cross-Review (Days 7–8)
| # | Issue Title | Member | Marks | Key Acceptance Criteria |
| :-: | :--- | :--- | :-: | :--- |
| 13 | `[Report] Write Conclusion, Limitations, IEEE References & GAI Declaration` | Kavindu | 5 | ~350 words synthesising all 10 RQs + consistent IEEE references (books/journals) + GAI acknowledgement |
| 14 | `[Report] Merge all sections & 20 figures into Kingston Template` | Sachithra | — | Unified formatting, cover page with KU IDs, word count verified within 4,000–5,000 words |
| 15 | `[Review] Peer-Review Swap (Sachithra -> Thisara -> Kavindu -> Sachithra)` | All | — | Every member reviews one teammate's sections for accuracy, flow, and grammar |

### Phase 5: Final QA & Submission (Day 9)
| # | Issue Title | Member | Marks | Key Acceptance Criteria |
| :-: | :--- | :--- | :-: | :--- |
| 16 | `[QA] Visual & Citation Audit across all 20 Figures and IEEE References` | Kavindu | — | All 20 figures numbered (`Figure 1`–`20`), legible, linked to RQs; all citations match reference list |
| 17 | `[QA] Canvas Originality Report Check & Similarity Fixes` | Sachithra | — | Draft uploaded to Canvas, similarity report reviewed & any issues resolved |
| 18 | `[Submit] Export Final PDF & Submit on Canvas before Deadline` | Sachithra | — | Final PDF checked by all 3 members and submitted on Canvas |

---

## 3. One-Command Automation (Populate Project #2 Automatically)

Once you install GitHub CLI (`gh`) and log in with project permissions:
```bash
gh auth login --scopes "repo,project"
bash scripts/setup_github_project.sh
```
This script automatically creates all labels, opens all **18 issues** in `mktpriyamal/ADP-CW01-Group-17`, and adds every issue directly to your GitHub Project (`https://github.com/users/mktpriyamal/projects/2/views/1`).
