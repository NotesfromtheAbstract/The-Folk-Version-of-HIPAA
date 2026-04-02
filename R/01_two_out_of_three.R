# ============================================================================
# "Two Out of Three"
# OCR HIPAA Complaint Outcomes, April 2003–Present
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
# Source: HHS Office for Civil Rights, Enforcement Highlights
# https://www.hhs.gov/hipaa/for-professionals/compliance-enforcement/data/enforcement-highlights/index.html

complaints <- data.frame(
  category = c(
    "Not eligible for enforcement\n(entity not covered by HIPAA,\nactivity not a violation,\nor complaint untimely/withdrawn)",
    "Resolved with corrective action\nor technical assistance",
    "Remaining resolved cases"
  ),
  count = c(255953, 31191, 87177),
  fill_color = c("#C0392B", "#2471A3", "#B0A68E")
)

# Order factor for plotting
complaints$category <- factor(complaints$category, levels = rev(complaints$category))

total_complaints <- sum(complaints$count)  # 374,321

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

# --- Plot ---
p <- ggplot(complaints, aes(x = count, y = category, fill = fill_color)) +
  geom_col(width = 0.65) +
  geom_text(
    aes(label = format(count, big.mark = ",")),
    hjust = -0.1,
    size = 5,
    fontface = "bold",
    color = "#3A3A3A"
  ) +
  scale_fill_identity() +
  scale_x_continuous(
    labels = comma,
    expand = expansion(mult = c(0, 0.25))
  ) +
  labs(
    title = "Two Out of Three",
    subtitle = paste0(
      "Of ", format(total_complaints, big.mark = ","),
      " HIPAA complaints received by OCR since April 2003,\n",
      "roughly two-thirds described something the law does not govern or does not prohibit."
    ),
    x = NULL,
    y = NULL,
    caption = "Source: HHS Office for Civil Rights, Enforcement Highlights. | Notes from the Abstract, 2026."
  ) +
  theme_1950s() +
  theme(
    panel.grid.major.y = element_blank(),
    axis.text.y = element_text(size = 11, lineheight = 1.1),
    plot.caption = element_text(size = 9, color = "#7A7A7A", hjust = 0)
  )

ggsave(
  "output/two_out_of_three.png",
  plot = p,
  width = 1456 / 100,
  height = 8.19,
  dpi = 100,
  bg = "#FAF5E9"
)

cat("Chart 1 saved: output/two_out_of_three.png\n")
