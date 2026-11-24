"""
Shared visualisation styling and export utilities for CI7340 Group 17.
Import and call `apply_style()` at the top of every notebook so all 20
visualisations share a uniform academic report look.
"""

import os
os.environ.setdefault("MPLCONFIGDIR", "/tmp/matplotlib")

from pathlib import Path
import matplotlib.pyplot as plt
import seaborn as sns

# Project paths (resolved relative to repo root)
REPO_ROOT = Path(__file__).resolve().parent.parent
_RAW_CSV = REPO_ROOT / "data" / "raw" / "dataset_coursework1.csv"
_RAW_GZ = REPO_ROOT / "data" / "raw" / "dataset_coursework1.csv.gz"
RAW_DATA_PATH = _RAW_CSV if _RAW_CSV.exists() else _RAW_GZ
_CLEAN_PQ = REPO_ROOT / "data" / "processed" / "cleaned_crime_data.parquet"
_CLEAN_GZ = REPO_ROOT / "data" / "processed" / "cleaned_crime_data.csv.gz"
CLEAN_DATA_PATH = _CLEAN_PQ if _CLEAN_PQ.exists() else _CLEAN_GZ
FIGURES_DIR = REPO_ROOT / "figures"

# Colorblind-safe academic palette (Okabe-Ito inspired)
PALETTE = [
    "#1B4F72",  # Deep Navy (Primary)
    "#D35400",  # Burnt Orange (Highlight)
    "#117864",  # Teal
    "#7D3C98",  # Purple
    "#B7950B",  # Ochre / Gold
    "#2E86C1",  # Sky Blue
    "#C0392B",  # Crimson
    "#566573",  # Slate Grey
]


def apply_style() -> None:
    """Apply consistent Matplotlib & Seaborn styling across all notebooks."""
    sns.set_theme(style="whitegrid", context="paper")
    sns.set_palette(PALETTE)
    plt.rcParams.update(
        {
            "figure.figsize": (10, 5.5),
            "figure.dpi": 120,
            "savefig.dpi": 300,
            "savefig.bbox": "tight",
            "axes.titlesize": 13,
            "axes.titleweight": "bold",
            "axes.labelsize": 11,
            "axes.edgecolor": "#CCCCCC",
            "axes.linewidth": 0.8,
            "axes.spines.top": False,
            "axes.spines.right": False,
            "xtick.labelsize": 9.5,
            "ytick.labelsize": 9.5,
            "legend.fontsize": 9.5,
            "legend.frameon": True,
            "legend.framealpha": 0.9,
            "grid.alpha": 0.35,
            "font.sans-serif": ["DejaVu Sans", "Arial", "Helvetica"],
        }
    )


def save_fig(fig: plt.Figure, filename: str, dpi: int = 300) -> Path:
    """Save a figure cleanly to the repo's figures/ directory as high-res PNG."""
    FIGURES_DIR.mkdir(parents=True, exist_ok=True)
    out_path = FIGURES_DIR / filename
    fig.savefig(out_path, dpi=dpi, bbox_inches="tight", facecolor="white")
    return out_path


def load_clean_data(low_memory: bool = False):
    """Load the master cleaned dataset with correct datatypes."""
    import pandas as pd
    if _CLEAN_PQ.exists():
        return pd.read_parquet(_CLEAN_PQ)
    elif _CLEAN_GZ.exists():
        parse_dates = ["Start_Date_Time", "End_Date_Time", "Dispatch Date / Time"]
        return pd.read_csv(_CLEAN_GZ, parse_dates=parse_dates, low_memory=low_memory)
    else:
        raise FileNotFoundError(f"Cleaned dataset not found at {_CLEAN_PQ} or {_CLEAN_GZ}")

    print(f"Saved figure -> {out_path}")
    return out_path
