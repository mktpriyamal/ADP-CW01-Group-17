# AI Skill: Fact-Based Judgmental Hypothesis Generation

## 1. Skill Metadata
* **Skill Name:** `Judgmental_Hypothesis_Builder`
* **Version:** 1.0
* **Primary Function:** Formulate rigorous, testable, and logically sound research hypotheses grounded in empirical facts, domain expertise, and critical judgment.
* **Domain:** Scientific Research, Business Intelligence, Data Science, Strategic Decision-Making.

## 2. Core Principles
Unlike random guessing, a **Judgmental Fact-Based Hypothesis** relies on two strict pillars:
1. **Empirical Facts:** Verified data, historical trends, established scientific laws, or peer-reviewed literature.
2. **Critical Judgment:** Logical deduction, identification of hidden anomalies, weighing conflicting evidence, and predicting causal mechanisms.

## 3. Cognitive Execution Pipeline
When this skill is invoked, the AI must execute the following 5-step pipeline internally before generating a response:

1. **Fact Extraction & Anomaly Detection:**
    * Scan the input data/context to isolate undeniable facts.
    * Discard noise, anecdotal claims, and unverified correlations.
    * Highlight contradictions or anomalies (e.g., *"Fact A and Fact B are both true, yet they contradict expected outcomes"*).
2. **Variable Isolation:**
    * **Independent Variable ($X$):** The root cause or intervention being manipulated.
    * **Dependent Variable ($Y$):** The measurable outcome or effect.
    * **Confounding Variables ($Z$):** External factors that must be controlled to ensure validity.
3. **Causal Mechanism Reasoning (The "Why"):**
    * Apply domain logic to explain *how* $X$ influences $Y$.
    * *Logic Formula:* Because of $[Fact\ 1]$ and $[Fact\ 2]$, manipulating $[Variable\ X]$ will trigger $[Mechanism\ M]$, resulting in $[Outcome\ Y]$.
4. **Dual-Hypothesis Formulation:**
    * Formulate a baseline **Null Hypothesis ($H_0$)** stating no statistically significant relationship exists.
    * Formulate a directional **Alternative Hypothesis ($H_1$)** predicting the specific outcome based on judgment.
5. **Falsifiability & Stress-Testing:**
    * Define the exact metrics, statistical thresholds (e.g., $p < 0.05$), and experimental conditions required to prove $H_1$ wrong.

## 4. Strict Output Rules
* **Zero Baseless Guessing:** Every claim must anchor to a known fact, logical axiom, or provided data point.
* **Required Output Sections:**
    1. `Foundational Facts`
    2. `Judgmental Synthesis`
    3. `Variables (IV, DV, Control)`
    4. `Null Hypothesis (H0)`
    5. `Alternative Hypothesis (H1)`
    6. `Falsification Criteria`
    7. `Evidence Strength Score (1-10)`