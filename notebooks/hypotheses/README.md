# Dedicated Research Hypotheses Testing Notebooks (CI7340 Group 17)
## Master Cleaned Dataset Analysis — Montgomery County Crime Incidents

This directory contains **16 dedicated, presentation-ready Jupyter notebooks**—encompassing the complete suite of original and newly added research hypotheses developed and verified under the **Judgmental Hypothesis Framework**.

Each notebook is completely self-contained, pre-executed with active outputs and high-resolution visualisations, providing:
1. **Targeted Data Filtering (Before vs. After):** Complete visibility into raw vs. cleaned/filtered record counts.
2. **Fact-by-Fact Empirical Verification:** Direct Python calculations verifying every assertion in the framework.
3. **Before vs. After Visualisations:** High-resolution figures saved directly to `figures/`.
4. **Critical Judgment (Positive vs. Negative Evidence):** In-depth criminological evaluation of supporting vs. challenging factors, alternative explanations, and confounders.
5. **Statistical Hypothesis Testing:** Formal inferential tests adhering strictly to $\alpha = 0.05$ decision criteria.
6. **Final Presentation Conclusion:** Clear decision (Reject / Fail to Reject $H_0$), executive takeaways, and operational recommendations.

---

### 📑 Master 16 Notebooks Index & Mapping Dashboard

| Notebook | Hypothesis & Focus | Framework Category | Statistical Test ($\alpha = 0.05$) | Target Figures | Decision |
| :--- | :--- | :---: | :--- | :---: | :---: |
| [01_H1_COVID_Macro_Shifts.ipynb](01_H1_COVID_Macro_Shifts.ipynb) | **H1 (RQ1):** Temporal Trends & COVID-19 Trajectory | **External Event and Impact Analysis** | Welch's ANOVA ($F = 78.43, p = 3.9 \times 10^{-20}$) | Fig 1 & Fig 2 | **REJECT $H_0$** |
| [02_H2_Seasonality_DayOfWeek.ipynb](02_H2_Seasonality_DayOfWeek.ipynb) | **H2 (RQ2):** Seasonal & Day-of-Week Cycles | **Temporal based hypothesis** | 2-Way Factorial ANOVA ($p < 10^{-50}$) | Fig 3 & Fig 4 | **REJECT $H_0$** |
| [03_H3_Diurnal_Rhythms_Heaping.ipynb](03_H3_Diurnal_Rhythms_Heaping.ipynb) | **H3 (RQ3):** Diurnal Curves & Timestamp Heaping | **Temporal based hypothesis** | Uniformity $\chi^2$ ($p < 10^{-300}$), Two-Sample KS | Fig 5 & Fig 6 | **REJECT $H_0$** |
| [04_H4_Substantive_vs_90Z_Workload.ipynb](04_H4_Substantive_vs_90Z_Workload.ipynb) | **H4 (RQ4):** Substantive Crime vs. 90Z Workload | **Incedent based hypothesis** | Binomial Test / Pearson $r$ ($p < 0.001$) | Fig 7 & Fig 8 | **REJECT $H_0$** |
| [05_H5_MultiOffence_Escalation.ipynb](05_H5_MultiOffence_Escalation.ipynb) | **H5 (RQ5):** Multi-Offence Co-occurrence under NIBRS | **Incedent based hypothesis** | Pearson $\chi^2$ Independence ($\chi^2 = 36,929.58, p < 10^{-300}$) | Fig 9 & Fig 10 | **REJECT $H_0$** |
| [06_H6_Victim_Burden_Premises.ipynb](06_H6_Victim_Burden_Premises.ipynb) | **H6 (RQ6):** Victim Burden & Premise Vulnerability | **Incedent based hypothesis** | Kruskal-Wallis Non-Parametric Test ($p < 10^{-100}$) | Fig 11 & Fig 12 | **REJECT $H_0$** |
| [07_H7_District_Crime_Mix.ipynb](07_H7_District_Crime_Mix.ipynb) | **H7 (RQ7):** District Workload & Urban Crime Mix | **Geo location based hypothesis** | Pearson $\chi^2$ Contingency ($p < 10^{-300}$) | Fig 13 & Fig 14 | **REJECT $H_0$** |
| [08_H8_Micro_Spatial_Hotspots.ipynb](08_H8_Micro_Spatial_Hotspots.ipynb) | **H8 (RQ8):** Micro-Spatial Hotspots (Pareto Law) | **Geo location based hypothesis** | Lorenz Curve / Gini Coefficient (Spatial Gini = 0.584) | Fig 15 & Fig 16 | **REJECT $H_0$** |
| [09_H9_MultiAgency_Specialisation.ipynb](09_H9_MultiAgency_Specialisation.ipynb) | **H9 (RQ9):** Multi-Agency Statutory Specialisation | **Crime Duration and Operational Analysis** | Contingency Chi-Square ($p < 10^{-300}$) | Fig 17 & Fig 18 | **REJECT $H_0$** |
| [10_H10_Dispatch_Response_Lags.ipynb](10_H10_Dispatch_Response_Lags.ipynb) | **H10 (RQ10):** CAD Dispatch Operational Delay Lags | **Crime Duration and Operational Analysis** | Mann-Whitney $U$ / Kruskal-Wallis ($p < 10^{-300}$) | Fig 19 & Fig 20 | **REJECT $H_0$** |
| [11_H11_Central_vs_Outer_Crime_Density.ipynb](11_H11_Central_vs_Outer_Crime_Density.ipynb) | **H11 (RQ11):** Outer vs. Central Crime Density | **Geo location based hypothesis** | One-Way ANOVA ($F = 62.48, p = 3.8 \times 10^{-5}$), Kruskal | Fig 11A & Fig 11B | **REJECT $H_0$** |
| [12_H16_STL_Seasonal_Decomposition.ipynb](12_H16_STL_Seasonal_Decomposition.ipynb) | **H16 (RQ16):** Recurring Seasonal Patterns (STL) | **Temporal based hypothesis** | One-Way ANOVA on detrended series ($F = 31.42, p < 10^{-20}$) | Fig 16A & Fig 16B | **REJECT $H_0$** |
| [13_H26_Geographical_Trends_Over_Time.ipynb](13_H26_Geographical_Trends_Over_Time.ipynb) | **H26 (RQ2.5):** Geographical Crime Trends Over Time | **Spatial and Geographical hypothesis** | Pearson $\chi^2$ Homogeneity ($\chi^2 = 1,399.27, p < 10^{-200}$) | Fig 26A & Fig 26B | **REJECT $H_0$** |
| [14_H28_Person_vs_Property_Temporal.ipynb](14_H28_Person_vs_Property_Temporal.ipynb) | **H28 (RQ3.2):** Crimes Against Persons vs. Property | **Crime Type and Classification hypothesis** | Kolmogorov-Smirnov ($p = 2.42 \times 10^{-132}$), $\chi^2$ DOW ($p < 10^{-100}$) | Fig 28A & Fig 28B | **REJECT $H_0$** |
| [15_H31_Public_Holidays_Crime_Frequency.ipynb](15_H31_Public_Holidays_Crime_Frequency.ipynb) | **H31 (RQ4.3):** Public Holidays and Crime Frequency | **External Event and Impact Analysis** | Welch's Two-Sample $t$ ($t = -3.15, p = 0.00215$) | Fig 31 & Fig 32 | **REJECT $H_0$** |
| [16_H39_Dispatch_Interval_By_District.ipynb](16_H39_Dispatch_Interval_By_District.ipynb) | **H39 (RQ5.3):** Dispatch Interval Across Police Districts | **Crime Duration and Operational Analysis** | Kruskal-Wallis Non-Parametric ($H = 5,982.53, p < 10^{-300}$) | Fig 39A & Fig 39B | **REJECT $H_0$** |

---

### ⚖️ Statistical Significance Standards & Type I Error Control ($\alpha = 0.05$)

All 16 hypotheses adhere strictly to the formal hypothesis testing criteria:
1. **Significance Level ($\alpha = 0.05$):** Pre-set *a priori* decision threshold set at 5%.
2. **Type I Error Risk (False-Positive Control):** Capped at 5%—meaning there is at most a 5% probability of falsely rejecting a true null hypothesis (finding an effect that does not exist in reality).
3. **$p$-Value Cutoff Decision Rule:**
   - **$p < 0.05$:** Reject the Null Hypothesis ($H_0$), accept Alternative Hypothesis ($H_1$).
   - **$p \ge 0.05$:** Fail to reject the Null Hypothesis ($H_0$).
4. **Large-Sample Dual-Criterion Rule ($N = 508,106$):** Because large administrative samples can produce minute $p$-values ($p < 0.001$) even for trivial differences, all hypotheses pair the $p < 0.05$ cutoff with **substantive criminological effect sizes** (Lift $> 2.0$, Cramér's $V \ge 0.05$, Spatial Density Disparity $> 4\times$, Volume changes $> 8\%$) to prevent false positives and large-sample artifacts.

---

### 📂 Directory Organization & Shared Resources

- **Active Executed Notebooks (`./`):** All 16 notebooks listed above are pre-executed with cell outputs, statistics, and inline plots.
- **Figures Directory (`../../figures/`):** Contains all publication-quality, 300-DPI charts generated across all notebooks.
- **Master Parquet Dataset (`../../data/processed/cleaned_crime_data.parquet`):** High-speed columnar store (26.69 MB) enabling sub-second load times across all notebooks.
