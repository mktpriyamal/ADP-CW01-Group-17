#!/usr/bin/env python3
"""
Master Builder for 10 Dedicated Hypothesis Notebooks (CI7340 Group 17)
Generates and executes all 10 notebooks in notebooks/hypotheses/
"""

import sys
import os
import json
from pathlib import Path
import nbformat
from nbclient import NotebookClient

REPO_ROOT = Path(__file__).resolve().parent.parent
OUTPUT_DIR = REPO_ROOT / "notebooks" / "hypotheses"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
FIGURES_DIR = REPO_ROOT / "figures"
FIGURES_DIR.mkdir(parents=True, exist_ok=True)

def make_nb(cells):
    nb = nbformat.v4.new_notebook()
    for c_type, c_content in cells:
        if c_type == "md":
            nb.cells.append(nbformat.v4.new_markdown_cell(c_content))
        elif c_type == "code":
            nb.cells.append(nbformat.v4.new_code_cell(c_content))
    nb.metadata = {
        "kernelspec": {
            "display_name": "Python 3 (.venv)",
            "language": "python",
            "name": "python3"
        },
        "language_info": {
            "name": "python",
            "version": "3.10"
        }
    }
    return nb

def execute_and_save(nb, filepath: Path):
    print(f"\n--- Executing {filepath.name} ---")
    client = NotebookClient(nb, timeout=600, kernel_name="python3")
    client.execute()
    with open(filepath, "w", encoding="utf-8") as f:
        nbformat.write(nb, f)
    print(f"Successfully saved and executed: {filepath.name}")

print("Base setup loaded.")
