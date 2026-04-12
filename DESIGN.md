# Design System Document

## 1. Overview & Creative North Star: "The Silent Guardian"

This design system is built upon the concept of **The Silent Guardian**. In the world of high-end fintech, luxury is not loud; it is the absence of noise. We move away from the frantic "dashboard" aesthetic of traditional banking and toward an editorial, contemplative experience.

The visual language breaks the standard "grid-and-border" template by utilizing **Tonal Architecture**. Instead of lines, we use light. Instead of boxes, we use depth. The layout is intentionally spacious, allowing the typography to command the screen, while the RTL-first logic ensures a natural, rhythmic flow for Arabic-speaking users. We are building a "Digital Vault" that feels quietly confident, premium, and inherently secure.

---

## 2. Colors & Surface Logic

Our palette is anchored in the deep shadows of the midnight sea, punctuated by high-performance emerald and gold.

### The "No-Line" Rule
**Explicit Instruction:** Designers are prohibited from using 1-pixel solid borders to section content. Boundaries must be defined solely through background color shifts or subtle tonal transitions. A section is defined by its relationship to the `surface` tokens, not by a stroke.

### Surface Hierarchy & Nesting
We treat the UI as a series of physical layers—stacked sheets of fine, dark paper. 
- **Base Layer:** `background` (#061423)
- **Primary Surface:** `surface-container-low` (#0f1c2c) for secondary groupings.
- **Elevated Surface:** `surface-container-highest` (#283646) for the most critical interactive cards.
- **Nesting:** To create depth, place a `surface-container-lowest` element inside a `surface-container-low` section. This "recessed" look implies stability and containment.

### Signature Accents
- **Primary (Emerald):** Use `#00C896` sparingly. It is a beacon for growth and positive action.
- **Secondary (Gold):** Use `#F5C842` for premium features, rewards, or high-value insights.
- **Danger:** Use `#FF4D4D` strictly for spending or critical alerts.

---

## 3. Typography: Editorial Authority

We use a dual-typeface system to balance modern precision with geometric warmth. For RTL layouts, ensure line-height is increased by 15-20% to accommodate Arabic script diacritics.

*   **Display & Headlines (Plus Jakarta Sans):** These are our "Voice." Used for large balances and section headers. Its geometric nature provides the "Quietly Confident" vibe.
*   **Body & Labels (Inter):** Our "Workhorse." Inter provides maximum legibility at small sizes for transaction details and fine print.

| Role | Token | Font | Size | Weight |
| :--- | :--- | :--- | :--- | :--- |
| Large Balance | `display-lg` | Plus Jakarta Sans | 3.5rem | 700 |
| Section Header | `headline-sm` | Plus Jakarta Sans | 1.5rem | 600 |
| Action Text | `title-md` | Inter | 1.125rem | 500 |
| Body Text | `body-md` | Inter | 0.875rem | 400 |
| Micro Data | `label-sm` | Inter | 0.6875rem | 500 |

---

## 4. Elevation & Depth: Tonal Layering

We reject traditional shadows in favor of **Ambient Luminance**.

*   **The Layering Principle:** Depth is achieved by "stacking" surface tiers. A `surface-container-highest` card on a `surface` background creates a natural lift.
*   **The "Ghost Border":** If a container lacks contrast against its parent, use the `outline-variant` token (#3c4a43) at **15% opacity**. This creates a "whisper" of an edge that is felt rather than seen.
*   **Glassmorphism:** For floating navigation bars or modal overlays, use `surface-bright` at 60% opacity with a **24px Backdrop Blur**. This integrates the element into the environment rather than making it look "pasted on."
*   **Ambient Shadows:** When a card must float (e.g., a dragged state), use a shadow with a 40px blur, 0px offset, and 6% opacity of the `on-surface` color.

---

## 5. Components

### Buttons
- **Primary:** Background `primary-container` (#00c896), Text `on-primary-container` (#004d38). Radius: 14px. No shadow.
- **Secondary:** Background `surface-container-highest`, Text `primary`. Used for secondary actions.
- **Ghost:** No background. Text `primary`. Used for low-priority navigation.

### Cards & Lists
- **The Divider Rule:** Forbid the use of divider lines. Separate list items using 12px of vertical white space or by alternating background tones (`surface-container-low` vs `surface-container-lowest`).
- **Radius:** All cards must use a **20px corner radius** to soften the dark-mode aesthetic.

### Input Fields
- **State:** Resting inputs use `surface-container-highest`.
- **Interaction:** On focus, the background remains the same, but a "Ghost Border" (20% opacity `primary`) appears.
- **RTL:** Labels and icons must be mirrored. Helper text must align to the right.

### Custom Component: The "Growth Glow"
For savings goals, instead of a standard progress bar, use a 4px tall track (`surface-variant`) with a `primary` fill that has a subtle outer glow (4px blur, `primary` color at 30% opacity).

---

## 6. Do's and Don'ts

### Do
*   **Do** embrace asymmetry. In RTL, use a larger right-side margin (e.g., 32px) for headlines to create an editorial feel.
*   **Do** use "Negative Space" as a functional tool. If a screen feels cluttered, increase the spacing between containers rather than adding lines.
*   **Do** ensure all icons are "stroke-based" and match the weight of the Inter body text for visual harmony.

### Don't
*   **Don't** use 100% white (#FFFFFF). Use `on-surface` (#d6e4f9) for text to prevent eye strain in dark mode.
*   **Don't** use standard "Material Design" ripples. Use a simple opacity shift (10% lighter) for tap states to maintain the premium vibe.
*   **Don't** ever use a gradient for a background. Depth is created through surface steps, not color ramps.
*   **Don't** center-align long-form Arabic text. Always right-align for legibility and "Silent Guardian" authority.