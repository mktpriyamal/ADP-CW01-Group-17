# CI7340 Coursework 1 — Analysis Notebooks

## Contents
Thirteen hypothesis notebooks, the supplied cleaned incident-level dataset, and this guide.

## Run
1. Extract the folder.
2. Install dependencies: `pip install pandas numpy matplotlib seaborn scipy statsmodels`.
3. Open any notebook in Jupyter.
4. Run cells from top to bottom.

Each notebook reads `cleaned_crime_data.csv` from the bundle root. It creates a
folder with the same name as the notebook (without `.ipynb`) and writes its
figures (300 DPI) and compact analytical CSV tables there.

## Data handling
The notebooks use the supplied pre-cleaned incident-level dataset directly.
They do not perform another data-cleaning pipeline or mutate the source file.
Question-specific filters are analytical subsets only. The loader derives a
small number of analysis fields when absent (for example full-year flags and
non-negative dispatch intervals); it does not drop or rewrite source records.

## Coursework mapping
The notebooks provide two question-linked visualisations per hypothesis,
supporting descriptive statistics, interpretation, and limitations. The full
coursework report must still include the broader dataset description, initial
quality assessment, method comparisons, references, and synthesis across all
10 research questions.
