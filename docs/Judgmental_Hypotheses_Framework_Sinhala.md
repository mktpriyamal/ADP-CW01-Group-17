# CI7340 Applied Data Programming — Coursework 1 (Group 17)
# විනිශ්චයාත්මක පර්යේෂණ උපකල්පන රාමුව (Judgmental Hypotheses Framework) — සම්පූර්ණ උපකල්පන 16 (සරල සිංහලෙන්)

**Module:** CI7340 Applied Data Programming (Kingston University, 2026/2027)  
**Project:** Research Report and Visualisation — Montgomery County Crime Analysis  
**Framework Standard:** `Judgmental_Hypothesis_Builder` (Skill v1.0 / Principal Research Scientist Standard)  
**Data Foundation:** Master Cleaned Dataset (`cleaned_crime_data.parquet` / `cleaned_crime_data.csv.gz` | `508,106` offence records | `467,601` unique incidents | `56` audited columns | 2016 July 1 – 2026 September 14)  
**Team Alignment:** Group 17 සම්පූර්ණ පර්යේෂණ ප්‍රශ්න 16 (Original 10 + Newly Added 6)

---

## 1. Executive Overview: Master 16 Hypotheses Dashboard

කණ්ඩායම විසින් විශ්ලේෂණය කර තහවුරු කරන ලද **සම්පූර්ණ පර්යේෂණ උපකල්පන 16** පහත දැක්වේ. මෙහිදී පෙර තිබූ මුල් උපකල්පන 10 සහ අලුතින් සාකච්ඡා කර එකතු කරන ලද උපකල්පන 6 යන සියල්ලම නියමිත කාණ්ඩ යටතේ විධිමත්ව පෙළගස්වා ඇත:

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

## 2. උපකල්පන 16 පිළිබඳ සවිස්තරාත්මක විග්‍රහය (Detailed 16 Hypotheses Deep-Dive)

---

### Hypothesis 1: Temporal Trends & COVID-19 Trajectory (H1 — RQ1)
* **Framework Category:** `External Event and Impact Analysis`
* **Lead Member:** Sachithra | **Linked Visualisations:** `fig01_rq1_annual_trend.png` & `fig02_rq1_covid_mix.png`
* **Dedicated Notebook:** [01_H1_COVID_Macro_Shifts.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/01_H1_COVID_Macro_Shifts.ipynb)

#### 1. Foundational Facts (දත්ත වල සාක්ෂි)
* Pre-COVID (2017–2019) සාමාන්‍ය වාර්ෂික අපරාධ ප්‍රමාණය **56,876** කි.
* COVID Lockdown (2020–2021) සමයේ සාමාන්‍ය වාර්ෂික අපරාධ ප්‍රමාණය **46,243** දක්වා **18.7% කින් කඩා වැටුණි**.
* Post-COVID Recovery (2022–2025) සාමාන්‍ය වාර්ෂික අගය **48,978** ක් වූ අතර එය පූර්ව-වසංගත මට්ටමට වඩා 13.9% ක අඩුවෙන් ස්ථාවර විය.
* මාසික විචලනයන් මත Welch's ANOVA පරීක්ෂාව: $F = 78.43, p = 3.9 \times 10^{-20} < 0.05$.

#### 2. Causal Mechanism (හේතු-ඵල සම්බන්ධතාවය සරලව)
Routine Activity Theory ට අනුව මිනිසුන් නිවෙස් තුළ සිරවීමෙන් නිවාස සඳහා Capable Guardianship ඉහළ ගිය අතර, මාර්ගස්ථ Proactive පොලිස් පරීක්ෂා (DUI, මත්ද්‍රව්‍ය) සීමා වීමෙන් Society crimes පහත වැටුණි. ආර්ථිකය විවෘත වූ පසු වෙළඳසැල් සොරකම් (Retail Larceny) සහ වාහන සොරකම් නැවත ඉහළ ගියේය.

#### 3. Formal Hypotheses
* **Null Hypothesis ($H_0$):** පූර්ව, වසංගත සහ පසු-වසංගත යුගයන් අතර මාසික අපරාධ පරිමාවේ කිසිදු statistically significant වෙනසක් නොමැත ($H_0: \mu_{\text{pre}} = \mu_{\text{during}} = \mu_{\text{post}}$).
* **Alternative Hypothesis ($H_1$):** COVID-19 සාර්ව-සමාජ කම්පනය මඟින් මාසික අපරාධ පරිමාවේ statistically significant කඩාවැටීමක් ඇති කර ඇත ($p < 0.05$).

---

### Hypothesis 2: Seasonal & Day-of-Week Cycles (H2 — RQ2)
* **Framework Category:** `Temporal based hypothesis`
* **Lead Member:** Sachithra | **Linked Visualisations:** `fig03_rq2_monthly_heatmap.png` & `fig04_rq2_day_of_week.png`
* **Dedicated Notebook:** [02_H2_Seasonality_DayOfWeek.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/02_H2_Seasonality_DayOfWeek.ipynb)

#### 1. Foundational Facts (දත්ත වල සාක්ෂි)
* මැයි මාසය අපරාධ **44,792** ක් සමඟින් වාර්ෂික උපරිමය සටහන් කරයි (සාමාන්‍ය මාසික මට්ටමට වඩා +12.3%).
* පෙබරවාරි මාසය අපරාධ **36,547** ක් සමඟින් වාර්ෂික අවමය සටහන් කරයි (-8.4%).
* සතියේ දින අතරින් **සිකුරාදා (Friday)** දින අපරාධ **80,412** ක් (සතිපතා මුළු එකතුවෙන් 15.8%) වාර්තා වෙමින් උපරිමය ගනී.
* 2-Way Factorial ANOVA (Month & Day-of-Week): $p < 10^{-50} < 0.05$.

#### 2. Causal Mechanism (හේතු-ඵල සම්බන්ධතාවය සරලව)
උණුසුම් ගිම්හාන කාලගුණය එළිමහන් මිනිස් ගැවසීම වැඩි කරන අතර, සිකුරාදා සවස මත්පැන් පානය, සමාජගතවීම් සහ වාණිජ සාප්පු සවාරි උපරිම වීම අපරාධ අවස්ථා ඉහළ නංවයි.

---

### Hypothesis 3: Diurnal Rhythms vs. Administrative Timestamp Heaping (H3 — RQ3)
* **Framework Category:** `Temporal based hypothesis`
* **Lead Member:** Sachithra | **Linked Visualisations:** `fig05_rq3_diurnal_curve.png` & `fig06_rq3_midnight_artifact.png`
* **Dedicated Notebook:** [03_H3_Diurnal_Rhythms_Heaping.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/03_H3_Diurnal_Rhythms_Heaping.ipynb)

#### 1. Foundational Facts (දත්ත වල සාක්ෂි)
* මධ්‍යම රාත්‍රී 00:00 පැයෙහි අපරාධ **42,912** ක් (මුළු අපරාධ වලින් 8.44%) ලියාපදිංචි වී ඇත. මෙය පෙර පැය 23:00 මෙන් **2.03 ගුණයක අස්වාභාවික වැඩිවීමකි**.
* මෙය සැබෑ අපරාධ වැඩිවීමක් නොව නිශ්චිත අපරාධ වේලාව නොදන්නා විට පොලිස් නිලධාරීන් විසින් යොදන Administrative Default Heaping Artifact එකකි.
* සැබෑ ස්වභාවික දෛනික උපරිමය සවස **17:00 (5.63%)** ට යෙදේ (Uniformity $\chi^2, p < 10^{-300} < 0.05$).

---

### Hypothesis 4: Substantive Crime vs. Non-Criminal Service Workload (H4 — RQ4)
* **Framework Category:** `Incedent based hypothesis`
* **Lead Member:** Thisara | **Linked Visualisations:** `fig07_rq4_workload_split.png` & `fig08_rq4_service_breakdown.png`
* **Dedicated Notebook:** [04_H4_Substantive_vs_90Z_Workload.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/04_H4_Substantive_vs_90Z_Workload.ipynb)

#### 1. Foundational Facts (දත්ත වල සාක්ෂි)
* පොලිස් දෙපාර්තමේන්තුවේ මුළු සටහන් වලින් **21.6% ක්ම (අපරාධ 109,751 ක්)** NIBRS කේතය `90Z` වන "All Other Offenses" ගණයට අයත් non-criminal service calls වේ.
* සැබෑ අපරාධ (Substantive crimes) ප්‍රමාණය **78.4% (අපරාධ 398,355)** කි.
* Binomial test: $p < 0.001 < 0.05$. පොලිස් නිලධාරීන්ගේ කාලයෙන් 1/5 කට වැඩි ප්‍රමාණයක් අපරාධ නොවන සිවිල් ආරවුල් සහ සේවා ඇමතුම් සඳහා වැය වේ.

---

### Hypothesis 5: Multi-Offence Co-occurrence under NIBRS (H5 — RQ5)
* **Framework Category:** `Incedent based hypothesis`
* **Lead Member:** Thisara | **Linked Visualisations:** `fig09_rq5_offence_count_dist.png` & `fig10_rq5_cooccurrence_matrix.png`
* **Dedicated Notebook:** [05_H5_MultiOffence_Escalation.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/05_H5_MultiOffence_Escalation.ipynb)

#### 1. Foundational Facts (දත්ත වල සාක්ෂි)
* සිද්ධි වලින් **93.3% ක්ම (436,271)** තනි වරදකට (Single offence) සීමා වන අතර, **6.7% ක් (31,330)** බහුවිධ වැරදි සහිත සංකීර්ණ සිදුවීම් (Multi-offence) වේ.
* ප්‍රධාන සම-සිදුවීම් යුගල (Co-occurring pairs): Theft + Credit Card Fraud (Lift = 4.82), Assault + Destruction of Property (Lift = 3.94).
* Pearson $\chi^2$ Test of Independence: $\chi^2 = 36,929.58, p < 10^{-300} < 0.05$.

---

### Hypothesis 6: Victim Burden & Environmental Premise Vulnerability (H6 — RQ6)
* **Framework Category:** `Incedent based hypothesis`
* **Lead Member:** Thisara | **Linked Visualisations:** `fig11_rq6_victim_boxplot.png` & `fig12_rq6_multivictim_premises.png`
* **Dedicated Notebook:** [06_H6_Victim_Burden_Premises.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/06_H6_Victim_Burden_Premises.ipynb)

#### 1. Foundational Facts (දත්ත වල සාක්ෂි)
* සිද්ධි වලින් **94.1% කටම** සිටින්නේ තනි වින්දිතයෙකු (1 victim) පමණි.
* වින්දිතයන් 2 හෝ ඊට වැඩි බහු-වින්දිත සිදුවීම් (Multi-victim incidents) ප්‍රධාන වශයෙන් කේන්ද්‍රගත වන්නේ **නේවාසික පරිශ්‍රවලය (Residential Premises - 58.4%)** සහ වාණිජ රථගාල් වලය (Parking Lots - 21.2%).
* Kruskal-Wallis Non-Parametric Test: $p < 10^{-100} < 0.05$.

---

### Hypothesis 7: Command District Workload & Urban-Suburban Crime Mix (H7 — RQ7)
* **Framework Category:** `Geo location based hypothesis`
* **Lead Member:** Kavindu | **Linked Visualisations:** `fig13_rq7_district_volume.png` & `fig14_rq7_district_crime_mix.png`
* **Dedicated Notebook:** [07_H7_District_Crime_Mix.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/07_H7_District_Crime_Mix.ipynb)

#### 1. Foundational Facts (දත්ත වල සාක්ෂි)
* නාගරික කේන්ද්‍රස්ථාන වන 3D Silver Spring (109,218 offences) සහ 4D Wheaton (94,112 offences) මුළු ප්‍රාන්ත අපරාධ වලින් **40.0% ක්ම** දරයි.
* 3D දිස්ත්‍රික්කය තුළ Robbery සහ Assault අනුපාතය උපරිම වන අතර, 2D Bethesda දිස්ත්‍රික්කයේ Shoplifting සහ Larceny ප්‍රමුඛ වේ.
* Pearson $\chi^2$ Test of Contingency: $p < 10^{-300} < 0.05$, Cramér's $V = 0.082$.

---

### Hypothesis 8: Micro-Spatial Crime Concentration / Hotspot Law (H8 — RQ8)
* **Framework Category:** `Geo location based hypothesis`
* **Lead Member:** Kavindu | **Linked Visualisations:** `fig15_rq8_lorenz_curve.png` & `fig16_rq8_top_pras_hotspots.png`
* **Dedicated Notebook:** [08_H8_Micro_Spatial_Hotspots.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/08_H8_Micro_Spatial_Hotspots.ipynb)

#### 1. Foundational Facts (දත්ත වල සාක්ෂි)
* Weisburd ගේ Law of Crime Concentration ට අනුකූලව, පොලිස් වාර්තාකරණ කලාප (PRAs) වලින් **ඉහළම 1.2% ක් තුළ මුළු අපරාධ වලින් 24.8% ක්ම** කේන්ද්‍රගත වේ.
* Spatial Gini Coefficient එක **0.584** ක් වන අතර එය දැඩි අවකාශීය අසමානතාවයක් තහවුරු කරයි ($p < 0.001 < 0.05$).

---

### Hypothesis 9: Multi-Agency Jurisdictional Specialisation (H9 — RQ9)
* **Framework Category:** `Crime Duration and Operational Analysis`
* **Lead Member:** Kavindu | **Linked Visualisations:** `fig17_rq9_agency_volume.png` & `fig18_rq9_agency_crime_mix.png`
* **Dedicated Notebook:** [09_H9_MultiAgency_Specialisation.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/09_H9_MultiAgency_Specialisation.ipynb)

#### 1. Foundational Facts (දත්ත වල සාක්ෂි)
* MCPD ප්‍රාන්ත පොලිසිය මුළු සිද්ධි වලින් **94.8% ක්** මෙහෙයවයි.
* නගර සභා පොලිස් ඒකක (Municipal Police Agencies) නීතිමය වශයෙන් විශේෂිත මෙහෙයුම් පෙන්වයි: Takoma Park (TPPD) අධික ඝනත්ව ගෘහස්ථ ගැටුම් වලටද, Rockville (RCPD) වාණිජ කොරිඩෝවේ රථවාහන හා වෙළඳ සොරකම් වලටද ප්‍රමුඛත්වය දෙයි ($\chi^2, p < 10^{-300} < 0.05$).

---

### Hypothesis 10: Operational CAD Dispatch Response Lags (H10 — RQ10)
* **Framework Category:** `Crime Duration and Operational Analysis`
* **Lead Member:** Kavindu | **Linked Visualisations:** `fig19_rq10_dispatch_delay_medians.png` & `fig20_rq10_dispatch_ecdf.png`
* **Dedicated Notebook:** [10_H10_Dispatch_Response_Lags.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/10_H10_Dispatch_Response_Lags.ipynb)

#### 1. Foundational Facts (දත්ත වල සාක්ෂි)
* සාමාන්‍ය CAD පිටත්කර හැරීමේ ප්‍රමාදය (Median Dispatch Delay) **මිනිත්තු 15.6 කි**.
* නමුත් අපරාධ වර්ගය අනුව මෙය අතිශය විෂමජාතීය වේ: "In-Progress" පුද්ගල ප්‍රචණ්ඩ අපරාධ සඳහා මධ්‍යන්‍ය ප්‍රමාදය **මිනිත්තු 4.1 ක් (IQR 1.2 – 12.4)** වන අතර, "Cold" දේපළ අපරාධ සඳහා මධ්‍යන්‍ය ප්‍රමාදය **මිනිත්තු 64.2 කි (IQR 18.2 – 240.5)**.
* Mann-Whitney $U$ test: $p < 10^{-300} < 0.05$.

---

### Hypothesis 11: Outer vs. Central Crime Density (H11 — RQ11)
* **Framework Category:** `Geo location based hypothesis`
* **Linked Visualisations:** `fig11_rq11_density_map.png` & `fig11_rq11_zone_density_boxplot.png`
* **Dedicated Notebook:** [11_H11_Central_vs_Outer_Crime_Density.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/11_H11_Central_vs_Outer_Crime_Density.ipynb)

#### 1. Foundational Facts (දත්ත වල සාක්ෂි)
* Burgess ගේ Concentric Zone Model ට අනුකූලව, නාගරික මධ්‍යය (Central Core: 3D, 2D, 4D, TPPD) වර්ග කිලෝමීටරයකට **අපරාධ 545.6 සිට 2,541.5 දක්වා** අධික ඝනත්වයක් පෙන්වයි.
* පිටත Up-County (Outer Zone: 5D) හි අපරාධ ඝනත්වය වර්ග කි.මී. ට **අපරාධ 146.5 ක් පමණි** (**$4.6\times$ සිට $17.3\times$ දක්වා දැවැන්ත පරතරයක්**).
* One-Way ANOVA: $F = 62.48, p = 3.84 \times 10^{-5} < 0.05$.

---

### Hypothesis 16: Recurring Seasonal Patterns in Crime Trends (H16 — RQ16)
* **Framework Category:** `Temporal based hypothesis` (Exploratory – Time-Series Decomposition)
* **Linked Visualisations:** `fig16_rq16_stl_decomposition.png` & `fig16_rq16_seasonal_subseries.png`
* **Dedicated Notebook:** [12_H16_STL_Seasonal_Decomposition.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/12_H16_STL_Seasonal_Decomposition.ipynb)

#### 1. Foundational Facts (දත්ත වල සාක්ෂි)
* මාසික අපරාධ දත්ත මත සිදුකරන ලද STL (Seasonal-Trend decomposition using LOESS) විශ්ලේෂණයේදී මාස 12 ක පුනරාවර්තී සෘතුමය විස්තාරය (Seasonal Amplitude) **අපරාධ 988.57 ක්** වේ.
* අවම අගය පෙබරවාරි මාසයේදීද (වාර්ෂික මධ්‍යන්‍යයට වඩා **-674.67 crimes** අඩුය), උපරිම අගය මැයි මාසයේදීද (වාර්ෂික මධ්‍යන්‍යයට වඩා **+313.90 crimes** වැඩිය) සටහන් වේ.
* Detrended series ANOVA: $F = 31.42, p < 10^{-20} < 0.05$.

---

### Hypothesis 26: Geographical Crime Trends Over Time (H26 — RQ2.5)
* **Framework Category:** `Spatial and Geographical hypothesis`
* **Linked Visualisations:** `fig26_rq2_5_spatial_trend_lines.png` & `fig26_rq2_5_district_share_shift.png`
* **Dedicated Notebook:** [13_H26_Geographical_Trends_Over_Time.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/13_H26_Geographical_Trends_Over_Time.ipynb)

#### 1. Foundational Facts (දත්ත වල සාක්ෂි)
* 2017 සිට 2025 දක්වා වසර 9 තුළ පොලිස් දිස්ත්‍රික්ක අතර භූගෝලීය අපරාධ කොටස සැලකිය යුතු ලෙස විතැන් වී ඇත (Pearson $\chi^2 = 1,399.27, p < 10^{-200} < 0.05$).
* 2D Bethesda දිස්ත්‍රික්කයේ අපරාධ කොටස $13.04\%$ සිට $16.08\%$ දක්වා **$+23.3\%$ කින් වර්ධනය විය**.
* 4D Wheaton දිස්ත්‍රික්කයේ අපරාධ කොටස $19.71\%$ සිට $16.99\%$ දක්වා **$-13.8\%$ කින් හැකිළුණි**.

---

### Hypothesis 28: Crimes Against Persons vs. Property Crimes (H28 — RQ3.2)
* **Framework Category:** `Crime Type and Classification hypothesis`
* **Linked Visualisations:** `fig28_rq3_2_diurnal_comparison.png` & `fig28_rq3_2_dow_comparison.png`
* **Dedicated Notebook:** [14_H28_Person_vs_Property_Temporal.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/14_H28_Person_vs_Property_Temporal.ipynb)

#### 1. Foundational Facts (දත්ත වල සාක්ෂි)
* **රාත්‍රී සාන්ද්‍රණය (20:00–03:00):** Person crimes වලින් **30.03% ක්** රාත්‍රියේ සිදුවන අතර Property crimes වලදී එය **23.35% කි** (Two-Sample KS test: $KS = 0.0635, p = 2.42 \times 10^{-132} < 0.05$).
* **සති අන්ත සාන්ද්‍රණය:** Person crimes වලින් **30.30% ක්** සති අන්තයේ (සෙන/ඉරි) සිදුවන අතර Property crimes වලින් **74.99% ක්ම** සිදුවන්නේ සාමාන්‍ය සතියේ වැඩ කරන දිනවලය ($\chi^2 = 619.19, p < 10^{-100} < 0.05$).

---

### Hypothesis 31: Public Holidays and Crime Frequency (H31 — RQ4.3)
* **Framework Category:** `External Event and Impact Analysis`
* **Linked Visualisations:** `fig31_rq4_3_holiday_comparison.png` & `fig32_rq4_3_holiday_specific.png`
* **Dedicated Notebook:** [15_H31_Public_Holidays_Crime_Frequency.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/15_H31_Public_Holidays_Crime_Frequency.ipynb)

#### 1. Foundational Facts (දත්ත වල සාක්ෂි)
* සාමාන්‍ය දිනවල (Non-holidays, දින 3,192) සාමාන්‍ය දෛනික අපරාධ ප්‍රමාණය **දිනකට 136.60 crimes** වේ.
* US Federal Public Holidays වලදී (දින 95) සාමාන්‍ය දෛනික අපරාධ ප්‍රමාණය **දිනකට 125.21 crimes** දක්වා **8.34% කින් පහත වැටේ**.
* Welch's Two-Sample $t$-test: $t = -3.1526, p = 0.00215 < 0.05$.

---

### Hypothesis 39: Dispatch Interval Across Police Districts (H39 — RQ5.3)
* **Framework Category:** `Crime Duration and Operational Analysis`
* **Linked Visualisations:** `fig39_rq5_3_district_dispatch_medians.png` & `fig39_rq5_3_dispatch_violin.png`
* **Dedicated Notebook:** [16_H39_Dispatch_Interval_By_District.ipynb](file:///mnt/D/DOCUMENTS/MSC/Material/Applied%20Data%20Programming/Group-Assignment/ADP-CW01-Group-17/notebooks/hypotheses/16_H39_Dispatch_Interval_By_District.ipynb)

#### 1. Foundational Facts (දත්ත වල සාක්ෂි)
* දිස්ත්‍රික්ක අතර පිටත්කර හැරීමේ ප්‍රමාදයන් අතිශය විෂමජාතීය වේ (Kruskal-Wallis $H = 5,982.53, p < 10^{-300} < 0.05$).
* 2D Bethesda හි මධ්‍යන්‍ය ප්‍රමාදය **මිනිත්තු 118.35 (පැය 2 කට ආසන්න)** වන අතර, 6D හි **මිනිත්තු 0.98** ක් සහ TPPD හි **මිනිත්තු 0.97** ක් පමණි (**120 ගුණයකට වඩා වැඩි මෙහෙයුම් පරතරයක්**).

---

## 3. Methodological Guardrails & Statistical Standards ($\alpha = 0.05$)

1. **Significance Level ($\alpha = 0.05$):** සියලුම උපකල්පන 16 සඳහා formal inferential statistical tests වල තීරණාත්මක සීමාව $\alpha = 0.05$ ලෙස තබා ඇත.
2. **Type I Error Risk (False-Positive Control):** සත්‍ය $H_0$ එකක් වැරදීමකින් ප්‍රතික්ෂේප කිරීමේ අවදානම 5% ක උපරිමයකට සීමා කර ඇත.
3. **Dual-Criterion Rule for Big Data ($N \approx 508,000$):** හුදෙක් $p < 0.05$ වීමෙන් පමණක් නොනැවතී, සැබෑ ප්‍රායෝගික වෙනස්කම් තහවුරු කරන Effect Sizes (Drops $> 8\%$, Ratio $> 2.0$, Gini $\ge 0.50$, Cramér's $V \ge 0.05$) සපුරා ඇත.
