#!/usr/bin/env bash
# Auto-populate GitHub Labels, Issues, and Project #2 for Group 17
# Prerequisites:
#   1. Install GitHub CLI: https://cli.github.com/
#   2. Authenticate with repo + project scopes:
#        gh auth login --scopes "repo,project"
#   3. Run from repo root:
#        bash scripts/setup_github_project.sh

set -euo pipefail

REPO="mktpriyamal/ADP-CW01-Group-17"
PROJECT_OWNER="mktpriyamal"
PROJECT_NUMBER="2"

echo "==> Creating labels in $REPO ..."
gh label create "owner:thisara"   --repo "$REPO" --color "1B4F72" --description "Owned by Thisara"   --force
gh label create "owner:sachithra" --repo "$REPO" --color "117864" --description "Owned by Sachithra" --force
gh label create "owner:kavindu"   --repo "$REPO" --color "7D3C98" --description "Owned by Kavindu"   --force
gh label create "owner:all"       --repo "$REPO" --color "D35400" --description "Shared team task"   --force

gh label create "phase-1:kickoff"     --repo "$REPO" --color "EDEDED" --force
gh label create "phase-2:data-freeze" --repo "$REPO" --color "FBCA04" --force
gh label create "phase-3:analysis"    --repo "$REPO" --color "0E8A16" --force
gh label create "phase-4:integration" --repo "$REPO" --color "1D76DB" --force
gh label create "phase-5:submission"  --repo "$REPO" --color "B60205" --force

create_and_add() {
  local title="$1"
  local body="$2"
  local labels="$3"

  echo "Creating: $title"
  local url
  url=$(gh issue create --repo "$REPO" --title "$title" --body "$body" --label "$labels")
  gh project item-add "$PROJECT_NUMBER" --owner "$PROJECT_OWNER" --url "$url" >/dev/null
  echo "  -> Added to Project #$PROJECT_NUMBER: $url"
}

echo "==> Creating 18 issues and adding them to Project #$PROJECT_NUMBER ..."

# Phase 1
create_and_add "[Admin] Obtain group approval from Dr. Farzana Rahman" \
  "Email Dr. Farzana Rahman with Group 17 member names and KU IDs (Thisara, Sachithra, Kavindu) to obtain formal group approval before starting the report." \
  "owner:sachithra,phase-1:kickoff"

create_and_add "[Kickoff] Finalise Problem Statement, Scope & 10 Research Questions" \
  "Hold 60-min kickoff call to agree on Problem Statement, justified Scope, and all 10 Research Questions (RQs 1-3 Sachithra, RQs 4-6 Thisara, RQs 7-10 Kavindu)." \
  "owner:all,phase-1:kickoff"

create_and_add "[Setup] Upload raw CSV to shared Drive & verify local environments" \
  "Upload dataset_coursework1.csv to shared Drive. All 3 members clone ADP-CW01-Group-17, create .venv, install requirements.txt, and place CSV in data/raw/." \
  "owner:thisara,phase-1:kickoff"

# Phase 2
create_and_add "[Data] Initial Data Quality Audit & Method Comparison (15 marks)" \
  "Complete Python quality audit in notebooks/00_data_cleaning_thisara.ipynb: missing values %, duplicates, date/coordinate anomalies, compare cleaning methods, quantify % affected, and write ~800 words." \
  "owner:thisara,phase-2:data-freeze"

create_and_add "[Milestone] Freeze cleaned_crime_data.parquet & share with team" \
  "Export final cleaned dataset to data/processed/cleaned_crime_data.parquet, upload to shared Drive, and confirm with Sachithra & Kavindu. Unblocks Phase 3." \
  "owner:thisara,phase-2:data-freeze"

create_and_add "[Report] Draft Introduction, Problem Statement, 10 RQs & Workflow Diagram (10 marks)" \
  "Write Introduction (~650 words): data science context, problem statement, scope, 10 RQs, and end-to-end workflow diagram/table." \
  "owner:sachithra,phase-2:data-freeze"

create_and_add "[Report] Draft Dataset Description — NIBRS/UCR & Incident/Offence/Victim (10 marks)" \
  "Write Dataset Description (~500 words): provenance, format, structured nature, columns/dtypes table, incident vs. offence vs. victim distinctions, and recording limitations." \
  "owner:sachithra,phase-2:data-freeze"

create_and_add "[Report] Draft Introduction to EDA & Visualisation Technique Comparisons (15 marks)" \
  "Write Introduction to EDA (~700 words): EDA strategy, revisiting post-cleaning data quality, further transformations, and justifying visualisation technique selections." \
  "owner:kavindu,phase-2:data-freeze"

# Phase 3
create_and_add "[Analysis] Descriptive Statistics Tables & Interpretation (5 marks)" \
  "Generate statistical summaries in notebooks/02_stats_rq4_to_rq6_thisara.ipynb and write ~350 words explaining suitability and contribution to RQs." \
  "owner:thisara,phase-3:analysis"

create_and_add "[Visuals] RQs 1-3: Temporal & Trend Patterns — 6 Charts (12 marks)" \
  "Build 6 high-res (300 DPI) visualisations (fig01_rq1_a.png to fig06_rq3_b.png) in notebooks/01_rq1_to_rq3_sachithra.ipynb using utils/viz_style.py + ~450 words interpretation." \
  "owner:sachithra,phase-3:analysis"

create_and_add "[Visuals] RQs 4-6: Crime Types, Offences & Victims — 6 Charts (12 marks)" \
  "Build 6 high-res (300 DPI) visualisations (fig07_rq4_a.png to fig12_rq6_b.png) in notebooks/02_stats_rq4_to_rq6_thisara.ipynb using utils/viz_style.py + ~450 words interpretation." \
  "owner:thisara,phase-3:analysis"

create_and_add "[Visuals] RQs 7-10: Spatial, Location & Operational Patterns — 8 Charts (16 marks)" \
  "Build 8 high-res (300 DPI) visualisations (fig13_rq7_a.png to fig20_rq10_b.png) in notebooks/03_eda_rq7_to_rq10_kavindu.ipynb using utils/viz_style.py + ~600 words interpretation." \
  "owner:kavindu,phase-3:analysis"

# Phase 4
create_and_add "[Report] Write Conclusion, Limitations, IEEE References & GAI Declaration (5 marks)" \
  "Synthesise all 10 RQs (~350 words), state limitations, format all books/journals in IEEE style, and include Acknowledgement of Generative AI (GAI) Contribution if used." \
  "owner:kavindu,phase-4:integration"

create_and_add "[Report] Merge all sections & 20 figures into Kingston Template" \
  "Combine all sections and 20 figures into the official coursework template, add cover page with all KU IDs, and verify word count is within 4,000-5,000 words." \
  "owner:sachithra,phase-4:integration"

create_and_add "[Review] Peer-Review Swap (Sachithra -> Thisara -> Kavindu -> Sachithra)" \
  "Each member reviews one teammate's sections for analytical accuracy, consistent numbers, tone, grammar, and rubric alignment." \
  "owner:all,phase-4:integration"

# Phase 5
create_and_add "[QA] Visual & Citation Audit across all 20 Figures and IEEE References" \
  "Verify all 20 figures are numbered (Figure 1-20), legible, linked to their exact RQ, and every in-text citation matches the IEEE reference list." \
  "owner:kavindu,phase-5:submission"

create_and_add "[QA] Canvas Originality Report Check & Similarity Fixes" \
  "Upload draft report to Canvas, review Originality Report, and rewrite/cite any flagged passages." \
  "owner:sachithra,phase-5:submission"

create_and_add "[Submit] Export Final PDF & Submit on Canvas before Deadline" \
  "All 3 members approve final PDF; Sachithra submits final PDF via Canvas and accepts Academic Integrity Declaration." \
  "owner:sachithra,phase-5:submission"

echo "==> Done! View your board at: https://github.com/users/$PROJECT_OWNER/projects/$PROJECT_NUMBER/views/1"
