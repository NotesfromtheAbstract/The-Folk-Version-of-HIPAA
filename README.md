# The Folk Version

**Notes from the Abstract** — Andrew R. Crocker, 2026

*Most Americans have never read HIPAA. The people who cite it haven't either.*

## About

This repository contains the R code and rendered visualizations accompanying "The Folk Version," published on [Notes from the Abstract](https://andrewrcrocker.substack.com).

The piece examines how the Health Insurance Portability and Accountability Act's Privacy Rule permits information sharing in circumstances most providers are trained to refuse, and how the penalty structure, compliance training culture, and state-level overlays (particularly Texas HB 300) create a rational incentive for silence over judgment.

## Contents

```
R/
  01_two_out_of_three.R       — OCR complaint outcomes (eligible vs. ineligible)
  02_silence_no_penalty.R     — Federal HIPAA penalty tiers vs. penalty for refusal
  03_stacking_effect.R        — Federal HIPAA vs. Texas HB 300 penalty comparison

output/
  two_out_of_three.png        — Rendered chart (1456px wide, Substack-optimized)
  silence_no_penalty.png      — Rendered chart
  stacking_effect.png         — Rendered chart

The_Folk_Version.md           — Article draft
```

## Data Sources

- **OCR Enforcement Highlights**: HHS Office for Civil Rights. https://www.hhs.gov/hipaa/for-professionals/compliance-enforcement/data/enforcement-highlights/index.html
- **Federal penalty tiers**: 45 CFR § 160.404, inflation-adjusted as of January 28, 2026.
- **Texas HB 300 penalties**: Texas Health and Safety Code, Chapter 181, as amended by HB 300, 82nd Texas Legislature.
- **OCR staffing and enforcement trends**: HIPAA Journal, "State of HIPAA: 2025 Predictions." https://www.hipaajournal.com/state-of-hipaa/

## Requirements

- R (≥ 4.0)
- ggplot2
- scales

All charts use a custom `theme_1950s()` function defined within each script.

## License

See LICENSE file. Code is provided for transparency and reproducibility. Rendered visualizations may not be republished without permission.
