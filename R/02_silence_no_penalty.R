# ============================================================================
# "Silence Has No Penalty Schedule"
# HIPAA Penalty Tiers for Disclosure vs. Refusal
#
# Notes from the Abstract — "The Folk Version"
# Andrew R. Crocker, 2026
#
# © 2026 Andrew R. Crocker. All rights reserved.
# This code is provided for transparency and reproducibility.
# You may not republish the rendered output without permission.
# ============================================================================

library(ggplot2)
library(scales)

# --- Data ---
# Source: HHS, inflation-adjusted civil monetary penalties as of January 28, 2026.
# Annual caps per OCR's 2019 enforcement discretion interpretation.
# These are the numbers that drive compliance behavior.

penalty_data <- data.frame(
  tier = c(
    "Tier 4: Willful neglect,\nnot corrected",
    "Tier 3: Willful neglect,\ncorrected",
    "Tier 2: Reasonable cause",
    "Tier 1: Did not know",
    "Refusing to share information\nthe Privacy Rule permits"
  ),
  cap = c(2190294, 365052, 146053, 36506, 0),
  bar_color = c("#C0392B", "#C0392B", "#C0392B", "#C0392B", "#E6DECA")
)

penalty_data$tier <- factor(penalty_data$tier, levels = rev(penalty_data$tier))

# --- Theme ---
theme_1950s <- function() {
  theme_minimal(base_family = "Arial", base_size = 14) +
    theme(
      plot.background = element_rect(fill = "#FAF5E9", color = NA),
      panel.background = element_rect(fill = "#FAF5E9", color = NA),
      panel.grid.major = element_line(color = "#E6DECA", linewidth = 0.6),
      panel.grid.minor = element_blank(),
      axis.title = element_text(face = "bold", color = "#3A3A3A"),
      axis.text = element_text(color = "#4A4A4A"),
      plot.title = element_text(face = "bold", size = 20, color = "#3A3A3A"),
      plot.subtitle = element_text(size = 13, color = "#5A5A5A"),
      plot.margin = margin(15, 15, 15, 15),
      legend.position = "none"
    )
}

fmt <- function(x) ifelse(x == 0, "$0",
                   ifelse(x >= 1000000, paste0("$", format(round(x/1000000, 2), nsmall = 2), "M"),
                   paste0("$", format(x, big.mark = ","))))

# --- Plot ---
p <- ggplot(penalty_data, aes(x = cap, y = tier, fill = bar_color)) +
  geom_col(width = 0.6) +
  scale_fill_identity() +
  geom_text(
    aes(label = fmt(cap)),
    hjust = ifelse(penalty_data$cap > 200000, 1.1, -0.1),
    color = ifelse(penalty_data$cap > 200000, "white",
            ifelse(penalty_data$cap == 0, "#B0A68E", "#C0392B")),
    size = ifelse(penalty_data$cap == 0, 8, 5),
    fontface = "bold"
  ) +
  scale_x_continuous(
    labels = label_dollar(scale = 0.000001, suffix = "M"),
    expand = expansion(mult = c(0.01, 0.08)),
    breaks = c(0, 500000, 1000000, 1500000, 2000000)
  ) +
  labs(
    title = "Silence Has No Penalty Schedule",
    subtitle = paste0(
      "Annual penalty caps by tier of culpability under federal HIPAA (inflation-adjusted, 2026).\n",
      "These are the numbers compliance officers train their staff on.\n",
      "There is no corresponding penalty for withholding information a provider is permitted to share."
    ),
    x = NULL,
    y = NULL,
    caption = "Source: 45 CFR 160.404; HHS inflation-adjusted amounts, January 28, 2026.\nAnnual caps reflect OCR enforcement discretion (2019). | Notes from the Abstract, 2026."
  ) +
  theme_1950s() +
  theme(
    panel.grid.major.y = element_blank(),
    axis.text.y = element_text(size = 12, lineheight = 1.1),
    plot.caption = element_text(size = 9, color = "#7A7A7A", hjust = 0, lineheight = 1.2)
  )

ggsave(
  "output/silence_no_penalty.png",
  plot = p,
  width = 1456 / 100,
  height = 8.19,
  dpi = 100,
  bg = "#FAF5E9"
)

cat("Chart 2 saved: output/silence_no_penalty.png\n")
