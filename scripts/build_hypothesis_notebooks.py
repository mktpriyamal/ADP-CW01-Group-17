#!/usr/bin/env python3
"""
Hypothesis Notebooks Generator for CI7340 Coursework 1 (Group 17)
Builds 10 dedicated presentation-grade Jupyter notebooks in notebooks/hypotheses/
Each notebook tests, evaluates, visualises, judges (positive/negative), and concludes a single hypothesis.
"""

import json
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
OUTPUT_DIR = REPO_ROOT / "notebooks" / "hypotheses"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

def make_cell(cell_type: str, source: str):
    lines = [line + "\n" for line in source.split("\n")]
    if lines and lines[-1] == "\n":
        lines[-1] = ""
    # Strip empty string at end if any
    while lines and lines[-1] == "":
        lines.pop()
    lines = [l if l.endswith("\n") else l + "\n" for l in lines]
    
    cell = {
        "cell_type": cell_type,
        "metadata": {},
        "source": lines
    }
    if cell_type == "code":
        cell["execution_count": None]
        cell["outputs"] = []
    return cell

def build_notebook(cells, filepath: Path):
    nb = {
        "cells": cells,
        "metadata": {
            "kernelspec": {
                "display_name": "Python 3 (.venv)",
                "language": "python",
                "name": "python3"
            },
            "language_info": {
                "name": "python",
                "version": "3.10"
            }
        },
        "nbformat": 4,
        "nbformat_minor": 5
    }
    with open(filepath, "w", encoding="utf-8") as f:
        json.dump(nb, f, indent=1)
    print(f"Generated: {filepath.name}")

print("Generator script template ready.")
