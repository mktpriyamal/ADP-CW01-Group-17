
**Refinements to Option A**

1. **Convert float to string carefully.** Going straight from `float64` to `str` gives `"20850.0"`. Convert to nullable integer first, then pad:
   `df['Zip Code'] = df['Zip Code'].astype('Int64').astype('string').str.zfill(5)`
   Do the invalid check (`< 10000`) on the numeric value before this step.

2. **Keep missing values as `NaN`/`<NA>`, not `'Unknown'`.** A string `'Unknown'` can be mistaken for a real category in groupby counts and charts. If you want it displayed, apply the label only at plotting time.

3. **Add two flags, not one:**
    - `is_zip_missing`: True for the 3,474 nulls plus the 19 invalid values, so you can always see how many rows had no usable zip.
    - `is_md_zip`: True for Maryland zips (20588, 20601–20799, 20812–21930), False for valid-looking zips outside the state.

4. **Investigate the 130 non-MD zips before deciding.** Check their `Latitude`/`Longitude`. If the coordinates fall inside the county, the zip is probably a data entry error, so set it to `NaN` as well. If the coordinates are near the border, they're likely genuine DC/VA zips, so keep them with `is_md_zip = False`.

5. **Cross-check zip against `City` or `Police District Number`.** A quick crosstab will show whether certain zips consistently map to the wrong district, which tells you if the errors are random or systematic.

6. **Document it.** In your methodology, record the counts at each step (3,474 nulls, 19 invalid, 130 non-MD) and the decision for each. That makes the cleaning reproducible and easy for a marker to follow.

**Summary:** Option A plus these refinements gives you a clean, low-risk column with no invented data and a clear audit trail.