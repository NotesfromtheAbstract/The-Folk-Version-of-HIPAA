# ============================================================================
# "The Stacking Effect"
# Federal HIPAA vs. Texas HB 300 Penalty Structures
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
# Federal: 45 CFR 160.404, inflation-adjusted as of January 28, 2026.
#   Using annual caps (OCR enforcement discretion, 2019) for Tiers 1-3;
#   Tier 4 annual cap equals per-violation max.
# Texas: Texas Health and Safety Code, Chapter 181, as amended by HB 300.
#   Texas uses per-violation amounts; Tier 4 is pattern-or-practice cap.

penalties <- data.frame(
  framework = c(
    rep("Federal HIPAA", 4),
    rep("Texas HB 300", 4)
  ),
  tier_short = rep(c("Tier 1\nLowest\nculpability", "Tier 2", "Tier 3",
                      "Tier 4\nHighest\nculpability"), 2),
  amount = c(
    36506, 146053, 365052, 2190294,
    5000, 25000, 250000, 1500000
  )
)

penalties$tier_short <- factor(penalties$tier_short,
  levels = c("Tier 1\nLowest\nculpability", "Tier 2", "Tier 3",
             "Tier 4\nHighest\nculpability"))
penalties$framework <- factor(penalties$framework,
  levels = c("Federal HIPAA", "Texas HB 300"))

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

fmt <- function(x) {
  ifelse(x >= 1000000,
    paste0("$", format(round(x / 1000000, 2), nsmall = 2), "M"),
    paste0("$", format(x, big.mark = ",")))
}

# --- Plot ---
p <- ggplot(penalties, aes(x = tier_short, y = amount, fill = framework)) +
  geom_col(position = position_dodge(width = 0.7), width = 0.6) +
  geom_text(
    aes(label = fmt(amount), group = framework),
    position = position_dodge(width = 0.7),
    vjust = -0.5,
    size = 3.6,
    fontface = "bold",
    color = "#3A3A3A"
  ) +
  scale_fill_manual(
    values = c("Federal HIPAA" = "#2471A3", "Texas HB 300" = "#C0392B")
  ) +
  scale_y_continuous(
    labels = label_dollar(scale = 0.000001, suffix = "M", prefix = "$"),
    expand = expansion(mult = c(0, 0.18)),
    breaks = c(0, 500000, 1000000, 1500000, 2000000)
  ) +
  # Legend placed top-left, above the bars
  annotate("rect", xmin = 0.55, xmax = 0.7, ymin = 2050000, ymax = 2150000, fill = "#2471A3") +
  annotate("text", x = 0.75, y = 2100000, label = "Federal HIPAA (annual caps)",
           hjust = 0, size = 3.8, color = "#3A3A3A") +
  annotate("rect", xmin = 0.55, xmax = 0.7, ymin = 1850000, ymax = 1950000, fill = "#C0392B") +
  annotate("text", x = 0.75, y = 1900000, label = "Texas HB 300 (per violation / pattern cap)",
           hjust = 0, size = 3.8, color = "#3A3A3A") +
  labs(
    title = "The Stacking Effect",
    subtitle = paste0(
      "A single disclosure event at a Texas hospital faces both penalty schedules.\n",
      "Federal amounts are annual caps (OCR enforcement discretion, 2019).\n",
      "Texas amounts are per-violation penalties; Tier 4 is the pattern-or-practice cap."
    ),
    x = NULL,
    y = NULL,
    caption = paste0(
      "Federal: 45 CFR 160.404, inflation-adjusted January 28, 2026. ",
      "Texas: Health and Safety Code Ch. 181 (HB 300). | Notes from the Abstract, 2026."
    )
  ) +
  theme_1950s() +
  theme(
    panel.grid.major.x = element_blank(),
    axis.text.x = element_text(size = 10, lineheight = 1.1),
    plot.caption = element_text(size = 9, color = "#7A7A7A", hjust = 0)
  )

ggsave(
  "output/stacking_effect.png",
  plot = p,
  width = 1456 / 100,
  height = 8.19,
  dpi = 100,
  bg = "#FAF5E9"
)

cat("Chart 3 saved: output/stacking_effect.png\n")
