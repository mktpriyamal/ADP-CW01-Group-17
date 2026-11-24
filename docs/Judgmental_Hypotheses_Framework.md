# CI7340 Applied Data Programming — Coursework 1 (Group 17)
# Judgmental Research Hypotheses Framework: Complete Master 16 Hypotheses

**Module:** CI7340 Applied Data Programming (Kingston University, 2026/2027)  
**Project:** Research Report and Visualisation — Montgomery County Crime Analysis  
**Framework Standard:** `Judgmental_Hypothesis_Builder` (Skill v1.0 / Principal Research Scientist Standard)  
**Data Foundation:** Master Cleaned Dataset (`cleaned_crime_data.parquet` / `cleaned_crime_data.csv.gz` | `508,106` offence records | `467,601` unique incidents | `56` audited columns | 1 July 2016 – 14 September 2026)  
**Team Alignment:** Complete 16 Research Questions (Original 10 + Newly Added 6)

---

## 1. Executive Overview: Master 16 Hypotheses Dashboard

The comprehensive research suite comprises **16 formal, fact-anchored research hypotheses**, rigorously categorized across 6 domain pillars:

| # | Hypothesis / RQ & Focus | Framework Category | Primary Variable ($X \rightarrow Y$) | Expected Visualisation 1 (A) | Expected Visualisation 2 (B) | Statistical Test ($\alpha = 0.05$) | Formal Decision |
| :-: | :--- | :---: | :--- | :--- | :--- | :--- | :---: |
| **H1** | **RQ1:** Temporal Trends & COVID-19 Trajectory | **External Event and Impact Analysis** | Era $\rightarrow$ Monthly Incident Volume | Annual Trend Line (`2017–2025` Full Years) | Pre vs. During vs. Post-COVID Bar / Area Mix | Welch's ANOVA ($p < 0.05$) | **REJECT $H_0$** |
| **H2** | **RQ2:** Seasonal & Day-of-Week Cycles | **Temporal based hypothesis** | Month & DayOfWeek $\rightarrow$ Incident Rate | Monthly Crime Heatmap by Offence Family | Day-of-Week Incident Distribution Bar Chart | 2-Way Factorial ANOVA ($p < 0.05$) | **REJECT $H_0$** |
| **H3** | **RQ3:** Diurnal Curves & Timestamp Heaping | **Temporal based hypothesis** | Hour $\rightarrow$ Hourly Rate & Heaping | 24-Hour Diurnal Line Chart (Pre/Post Filter) | Midnight Heaping Artifact Sensitivity Plot | Kolmogorov-Smirnov / $\chi^2$ ($p < 0.05$) | **REJECT $H_0$** |
| **H4** | **RQ4:** Substantive Crime vs. 90Z Workload | **Incedent based hypothesis** | Offence Classification $\rightarrow$ Police Burden | Non-Criminal 90Z vs. Substantive Donut Chart | 90Z Non-Criminal Sub-Service Breakdown | Binomial Test / Pearson $r$ ($p < 0.05$) | **REJECT $H_0$** |
| **H5** | **RQ5:** Multi-Offence Co-occurrence under NIBRS | **Incedent based hypothesis** | Incident Complexity $\rightarrow$ Escalation | Offence Count per Incident Distribution | Top Co-occurring Offence Pairs Matrix | Chi-Square Independence ($p < 0.05$) | **REJECT $H_0$** |
| **H6** | **RQ6:** Victim Burden & Premise Vulnerability | **Incedent based hypothesis** | Premise Category $\rightarrow$ Victims per Incident | Victims per Incident Boxplot by Premise | Multi-Victim Incident Share Across Locations | Kruskal-Wallis Non-Parametric ($p < 0.05$) | **REJECT $H_0$** |
| **H7** | **RQ7:** District Workload & Urban Crime Mix | **Geo location based hypothesis** | Police District $\rightarrow$ Caseload & Crime Mix | Total Incident Volume by District Bar Chart | Crime Category Breakdown by District Stacked Bar | Pearson $\chi^2$ Contingency ($p < 0.05$) | **REJECT $H_0$** |
| **H8** | **RQ8:** Micro-Spatial Hotspots (Pareto Law) | **Geo location based hypothesis** | Police Reporting Area $\rightarrow$ Cumulative Crime | Lorenz Curve of Spatial Crime Concentration | Top 15 Micro-Spatial Hotspot PRAs Bar Chart | Lorenz Curve / Gini (Spatial Gini $\ge 0.50$) | **REJECT $H_0$** |
| **H9** | **RQ9:** Multi-Agency Statutory Specialisation | **Crime Duration and Operational Analysis** | Responding Agency $\rightarrow$ Crime Mix | Caseload Share by Agency Donut Chart | Crime Against Society/Property/Person by Agency | Contingency Chi-Square ($p < 0.05$) | **REJECT $H_0$** |
| **H10** | **RQ10:** Operational CAD Dispatch Response Lags | **Crime Duration and Operational Analysis** | Crime Category $\rightarrow$ Dispatch Delay Mins | Median & IQR Dispatch Delay by Category (Log) | Empirical Cumulative Distribution (ECDF) | Mann-Whitney $U$ / Kruskal ($p < 0.05$) | **REJECT $H_0$** |
| **H11** | **RQ11:** Outer vs. Central Crime Density | **Geo location based hypothesis** | Zone (Central / Transition / Outer) $\rightarrow$ Density | 1 km Grid / District Incident Density Map | Incident Density (Crimes/km²) Boxplot | One-Way ANOVA / Kruskal ($p < 0.05$) | **REJECT $H_0$** |
| **H16** | **RQ16:** Recurring Seasonal Patterns (STL) | **Temporal based hypothesis** | Time (Month) $\rightarrow$ Incident Count | STL Decomposition Plot (Trend, Seasonal, Resid) | Monthly Seasonal Subseries Plot (May vs Feb) | STL LOESS / ANOVA ($p < 0.05$) | **REJECT $H_0$** |
| **H26** | **RQ2.5:** Geographical Crime Trends Over Time | **Spatial and Geographical hypothesis** | Year $\rightarrow$ District Geographic Mix | District Caseload Share Trend Lines (`2017–2025`) | 100% Stacked Spatial Share Shift Chart | $\chi^2$ Test of Spatial Homogeneity ($p < 0.05$) | **REJECT $H_0$** |
| **H28** | **RQ3.2:** Crimes Against Persons vs. Property | **Crime Type and Classification hypothesis** | Crime Category $\rightarrow$ Diurnal & Weekly Pattern | Hourly Diurnal Curve Comparison (Person vs Prop) | Weekend vs. Weekday Share Bar Chart | Two-Sample KS / $\chi^2$ DOW ($p < 0.05$) | **REJECT $H_0$** |
| **H31** | **RQ4.3:** Public Holidays and Crime Frequency | **External Event and Impact Analysis** | Holiday Status (Yes/No) $\rightarrow$ Daily Incidents | Daily Crime Rate Boxplot (Holidays vs Normal) | Holiday Specific Deviation Bar Chart | Welch's Two-Sample $t$-test ($p < 0.05$) | **REJECT $H_0$** |
| **H39** | **RQ5.3:** Dispatch Interval Across Police Districts | **Crime Duration and Operational Analysis** | Police District $\rightarrow$ Start-to-Dispatch Lag | District Dispatch Delay Medians & Spread (Log) | District Response Latency Violin / Boxplot | Kruskal-Wallis Test ($p < 0.05$) | **REJECT $H_0$** |

---

## 2. Detailed Hypotheses Deep-Dive

---

### Hypothesis 1: Temporal Trends & COVID-19 Trajectory (H1 — RQ1)
* **Framework Category:** `External Event and Impact Analysis`
* **Lead Member:** Sachithra | **Linked Visualisations:** `fig01_rq1_annual_trend.png` & `fig02_rq1_covid_mix.png`
* **Dedicated Notebook:** [01_H1_COVID_Macro_Shifts.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/01_H1_COVID_Macro_Shifts.ipynb)

#### 1. Foundational Facts
* Pre-COVID (2017–2019) mean annual crime incidence stood at **56,876 offences/year**.
* During COVID Lockdowns (2020–2021), annual crime fell by **18.7%** to **46,243 offences/year**.
* Post-COVID Recovery (2022–2025) stabilized at **48,978 offences/year** (13.9% below pre-pandemic baseline).
* Welch's ANOVA on monthly volumes across eras: $F = 78.43, p = 3.9 \times 10^{-20} < 0.05$.

#### 2. Causal Mechanism
Under Routine Activity Theory, stay-at-home directives increased residential guardianship and halted commercial commuting. Proactive police stops (DUI, drug enforcement) were curtailed, suppressing Crime Against Society. Re-opening spurred commercial retail theft and auto larceny.

#### 3. Formal Hypotheses
* **Null Hypothesis ($H_0$):** Mean monthly crime incidence is identical across pre-COVID, lockdown, and recovery eras ($H_0: \mu_{\text{pre}} = \mu_{\text{during}} = \mu_{\text{post}}$).
* **Alternative Hypothesis ($H_1$):** COVID-19 induced a statistically significant structural suppression in monthly crime volumes ($p < 0.05$).

---

### Hypothesis 2: Seasonal & Day-of-Week Cycles (H2 — RQ2)
* **Framework Category:** `Temporal based hypothesis`
* **Lead Member:** Sachithra | **Linked Visualisations:** `fig03_rq2_monthly_heatmap.png` & `fig04_rq2_day_of_week.png`
* **Dedicated Notebook:** [02_H2_Seasonality_DayOfWeek.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/02_H2_Seasonality_DayOfWeek.ipynb)

#### 1. Foundational Facts
* May is the annual peak month with **44,792 offences** (+12.3% above monthly mean).
* February is the annual trough with **36,547 offences** (-8.4% below monthly mean).
* Friday is the weekly peak day with **80,412 offences** (15.8% of weekly caseload).
* 2-Way Factorial ANOVA on Month and Day of Week: $p < 10^{-50} < 0.05$.

---

### Hypothesis 3: Diurnal Rhythms vs. Administrative Timestamp Heaping (H3 — RQ3)
* **Framework Category:** `Temporal based hypothesis`
* **Lead Member:** Sachithra | **Linked Visualisations:** `fig05_rq3_diurnal_curve.png` & `fig06_rq3_midnight_artifact.png`
* **Dedicated Notebook:** [03_H3_Diurnal_Rhythms_Heaping.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/03_H3_Diurnal_Rhythms_Heaping.ipynb)

#### 1. Foundational Facts
* Midnight (00:00) contains **42,912 records (8.44% of total dataset)**, a **2.03x surge** over 23:00 (21,114 records).
* This spike represents an administrative default heaping artifact for crimes with unknown exact start times.
* The true behavioural peak occurs at **17:00 (5.63%)** during the evening commute (Uniformity $\chi^2, p < 10^{-300} < 0.05$).

---

### Hypothesis 4: Substantive Crime vs. Non-Criminal Service Workload (H4 — RQ4)
* **Framework Category:** `Incedent based hypothesis`
* **Lead Member:** Thisara | **Linked Visualisations:** `fig07_rq4_workload_split.png` & `fig08_rq4_service_breakdown.png`
* **Dedicated Notebook:** [04_H4_Substantive_vs_90Z_Workload.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/04_H4_Substantive_vs_90Z_Workload.ipynb)

#### 1. Foundational Facts
* Non-criminal service calls and civil disputes classified under NIBRS code `90Z` account for **21.6% of police records (109,751 offences)**.
* Substantive criminal offences account for **78.4% (398,355 offences)**.
* Binomial test: $p < 0.001 < 0.05$. Over one-fifth of police operational capacity is consumed by non-criminal service tasks.

---

### Hypothesis 5: Multi-Offence Co-occurrence under NIBRS (H5 — RQ5)
* **Framework Category:** `Incedent based hypothesis`
* **Lead Member:** Thisara | **Linked Visualisations:** `fig09_rq5_offence_count_dist.png` & `fig10_rq5_cooccurrence_matrix.png`
* **Dedicated Notebook:** [05_H5_MultiOffence_Escalation.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/05_H5_MultiOffence_Escalation.ipynb)

#### 1. Foundational Facts
* **93.3% of incidents (436,271)** involve a single offence code; **6.7% (31,330)** are multi-offence complex escalations.
* Strongest co-occurring pairs: Theft + Credit Card Fraud (Lift = 4.82), Assault + Destruction of Property (Lift = 3.94).
* Pearson $\chi^2$ Test of Independence: $\chi^2 = 36,929.58, p < 10^{-300} < 0.05$.

---

### Hypothesis 6: Victim Burden & Environmental Premise Vulnerability (H6 — RQ6)
* **Framework Category:** `Incedent based hypothesis`
* **Lead Member:** Thisara | **Linked Visualisations:** `fig11_rq6_victim_boxplot.png` & `fig12_rq6_multivictim_premises.png`
* **Dedicated Notebook:** [06_H6_Victim_Burden_Premises.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/06_H6_Victim_Burden_Premises.ipynb)

#### 1. Foundational Facts
* **94.1% of incidents** involve a single victim.
* Incidents with 2 or more victims concentrate disproportionately in **Residential Premises (58.4%)** and Commercial Parking Lots (21.2%).
* Kruskal-Wallis Non-Parametric Test: $p < 10^{-100} < 0.05$.

---

### Hypothesis 7: Command District Workload & Urban-Suburban Crime Mix (H7 — RQ7)
* **Framework Category:** `Geo location based hypothesis`
* **Lead Member:** Kavindu | **Linked Visualisations:** `fig13_rq7_district_volume.png` & `fig14_rq7_district_crime_mix.png`
* **Dedicated Notebook:** [07_H7_District_Crime_Mix.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/07_H7_District_Crime_Mix.ipynb)

#### 1. Foundational Facts
* Core urban districts 3D Silver Spring (109,218 offences) and 4D Wheaton (94,112 offences) account for **40.0% of all county crime**.
* 3D exhibits highest violent robbery/assault rates, while 2D Bethesda dominates in larceny and retail shoplifting.
* Pearson $\chi^2$ Contingency: $p < 10^{-300} < 0.05$, Cramér's $V = 0.082$.

---

### Hypothesis 8: Micro-Spatial Crime Concentration / Hotspot Law (H8 — RQ8)
* **Framework Category:** `Geo location based hypothesis`
* **Lead Member:** Kavindu | **Linked Visualisations:** `fig15_rq8_lorenz_curve.png` & `fig16_rq8_top_pras_hotspots.png`
* **Dedicated Notebook:** [08_H8_Micro_Spatial_Hotspots.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/08_H8_Micro_Spatial_Hotspots.ipynb)

#### 1. Foundational Facts
* In alignment with Weisburd's Law of Crime Concentration, the **top 1.2% of Police Reporting Areas (PRAs) generate 24.8% of all county crime**.
* Spatial Gini Coefficient = **0.584**, confirming intense micro-spatial concentration ($p < 0.001 < 0.05$).

---

### Hypothesis 9: Multi-Agency Jurisdictional Specialisation (H9 — RQ9)
* **Framework Category:** `Crime Duration and Operational Analysis`
* **Lead Member:** Kavindu | **Linked Visualisations:** `fig17_rq9_agency_volume.png` & `fig18_rq9_agency_crime_mix.png`
* **Dedicated Notebook:** [09_H9_MultiAgency_Specialisation.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/09_H9_MultiAgency_Specialisation.ipynb)

#### 1. Foundational Facts
* MCPD handles **94.8% of all county incidents**.
* Municipal agencies demonstrate sharp statutory specialisation: Takoma Park (TPPD) handles high-density urban domestic disputes; Rockville (RCPD) enforces commercial corridor larceny and traffic ($\chi^2, p < 10^{-300} < 0.05$).

---

### Hypothesis 10: Operational CAD Dispatch Response Lags (H10 — RQ10)
* **Framework Category:** `Crime Duration and Operational Analysis`
* **Lead Member:** Kavindu | **Linked Visualisations:** `fig19_rq10_dispatch_delay_medians.png` & `fig20_rq10_dispatch_ecdf.png`
* **Dedicated Notebook:** [10_H10_Dispatch_Response_Lags.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/10_H10_Dispatch_Response_Lags.ipynb)

#### 1. Foundational Facts
* Overall median CAD dispatch delay is **15.6 minutes**.
* By crime type: violent in-progress Person crimes have a median delay of **4.1 minutes (IQR 1.2 – 12.4)**, whereas cold Property crimes have a median delay of **64.2 minutes (IQR 18.2 – 240.5)**.
* Mann-Whitney $U$ test: $p < 10^{-300} < 0.05$.

---

### Hypothesis 11: Outer vs. Central Crime Density (H11 — RQ11)
* **Framework Category:** `Geo location based hypothesis`
* **Linked Visualisations:** `fig11_rq11_density_map.png` & `fig11_rq11_zone_density_boxplot.png`
* **Dedicated Notebook:** [11_H11_Central_vs_Outer_Crime_Density.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/11_H11_Central_vs_Outer_Crime_Density.ipynb)

#### 1. Foundational Facts
* Consistent with Burgess's Concentric Zone Model, the Central Core (3D, 2D, 4D, TPPD) exhibits crime density between **545.6 and 2,541.5 crimes/km²**.
* The Outer Zone (5D Germantown) has a crime density of only **146.5 crimes/km²** (a **$4.6\times$ to $17.3\times$ disparity**).
* One-Way ANOVA: $F = 62.48, p = 3.84 \times 10^{-5} < 0.05$.

---

### Hypothesis 16: Recurring Seasonal Patterns in Crime Trends (H16 — RQ16)
* **Framework Category:** `Temporal based hypothesis` (Exploratory – Time-Series Decomposition)
* **Linked Visualisations:** `fig16_rq16_stl_decomposition.png` & `fig16_rq16_seasonal_subseries.png`
* **Dedicated Notebook:** [12_H16_STL_Seasonal_Decomposition.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/12_H16_STL_Seasonal_Decomposition.ipynb)

#### 1. Foundational Facts
* STL decomposition on monthly counts reveals a recurring seasonal amplitude of **988.57 crimes**.
* February represents the annual trough (**-674.67 crimes** below trend), and May represents the crest (**+313.90 crimes** above trend).
* Detrended series ANOVA: $F = 31.42, p < 10^{-20} < 0.05$.

---

### Hypothesis 26: Geographical Crime Trends Over Time (H26 — RQ2.5)
* **Framework Category:** `Spatial and Geographical hypothesis`
* **Linked Visualisations:** `fig26_rq2_5_spatial_trend_lines.png` & `fig26_rq2_5_district_share_shift.png`
* **Dedicated Notebook:** [13_H26_Geographical_Trends_Over_Time.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/13_H26_Geographical_Trends_Over_Time.ipynb)

#### 1. Foundational Facts
* Between 2017 and 2025, geographic crime share shifted substantially ($\chi^2 = 1,399.27, p < 10^{-200} < 0.05$).
* 2D Bethesda increased its county share from $13.04\%$ to $16.08\%$ (**+23.3% relative expansion**).
* 4D Wheaton contracted its county share from $19.71\%$ to $16.99\%$ (**-13.8% relative drop**).

---

### Hypothesis 28: Crimes Against Persons vs. Property Crimes (H28 — RQ3.2)
* **Framework Category:** `Crime Type and Classification hypothesis`
* **Linked Visualisations:** `fig28_rq3_2_diurnal_comparison.png` & `fig28_rq3_2_dow_comparison.png`
* **Dedicated Notebook:** [14_H28_Person_vs_Property_Temporal.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/14_H28_Person_vs_Property_Temporal.ipynb)

#### 1. Foundational Facts
* **Nighttime concentration (20:00–03:00):** Person crimes exhibit a **30.03%** nighttime share vs. **23.35%** for Property crimes (Two-Sample KS test: $KS = 0.0635, p = 2.42 \times 10^{-132} < 0.05$).
* **Weekend concentration:** Person crimes register **30.30%** on weekends (Sat/Sun) vs. **25.01%** for Property crimes ($\chi^2 = 619.19, p < 10^{-100} < 0.05$).

---

### Hypothesis 31: Public Holidays and Crime Frequency (H31 — RQ4.3)
* **Framework Category:** `External Event and Impact Analysis`
* **Linked Visualisations:** `fig31_rq4_3_holiday_comparison.png` & `fig32_rq4_3_holiday_specific.png`
* **Dedicated Notebook:** [15_H31_Public_Holidays_Crime_Frequency.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/15_H31_Public_Holidays_Crime_Frequency.ipynb)

#### 1. Foundational Facts
* Non-holiday days (3,192 days) average **136.60 crimes/day**.
* US Federal Public Holidays (95 days) average **125.21 crimes/day** (**8.34% reduction**).
* Welch's Two-Sample $t$-test: $t = -3.1526, p = 0.00215 < 0.05$.

---

### Hypothesis 39: Dispatch Interval Across Police Districts (H39 — RQ5.3)
* **Framework Category:** `Crime Duration and Operational Analysis`
* **Linked Visualisations:** `fig39_rq5_3_district_dispatch_medians.png` & `fig39_rq5_3_dispatch_violin.png`
* **Dedicated Notebook:** [16_H39_Dispatch_Interval_By_District.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/16_H39_Dispatch_Interval_By_District.ipynb)

#### 1. Foundational Facts
* Dispatch latency diverges massively across districts (Kruskal-Wallis $H = 5,982.53, p < 10^{-300} < 0.05$).
* 2D Bethesda has a median delay of **118.35 minutes (~2 hours)**, while 6D Montgomery Village registers **0.98 minutes** and TPPD registers **0.97 minutes** (a **>120-fold divergence**).

---

## 3. Methodological Guardrails & Statistical Standards ($\alpha = 0.05$)

1. **Significance Level ($\alpha = 0.05$):** Pre-set decision threshold applied across all 16 tests.
2. **Type I Error Risk Control:** Capped strictly at 5% probability of false rejection.
3. **Big Data Effect Size Dual Criterion ($N \approx 508,000$):** In addition to $p < 0.05$, all findings satisfy substantive practical thresholds (Drops $> 8\%$, Ratio $> 2.0$, Spatial Gini $\ge 0.50$, Cramér's $V \ge 0.05$).
