---
name: Ethereal Glass
colors:
  surface: '#f9f9fe'
  surface-dim: '#d9dade'
  surface-bright: '#f9f9fe'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f3f3f8'
  surface-container: '#ededf2'
  surface-container-high: '#e8e8ed'
  surface-container-highest: '#e2e2e7'
  on-surface: '#1a1c1f'
  on-surface-variant: '#414755'
  inverse-surface: '#2e3034'
  inverse-on-surface: '#f0f0f5'
  outline: '#717786'
  outline-variant: '#c1c6d7'
  surface-tint: '#005bc1'
  primary: '#0058bc'
  on-primary: '#ffffff'
  primary-container: '#0070eb'
  on-primary-container: '#fefcff'
  inverse-primary: '#adc6ff'
  secondary: '#4c4aca'
  on-secondary: '#ffffff'
  secondary-container: '#6664e4'
  on-secondary-container: '#fffbff'
  tertiary: '#9e3d00'
  on-tertiary: '#ffffff'
  tertiary-container: '#c64f00'
  on-tertiary-container: '#fffbff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d8e2ff'
  primary-fixed-dim: '#adc6ff'
  on-primary-fixed: '#001a41'
  on-primary-fixed-variant: '#004493'
  secondary-fixed: '#e2dfff'
  secondary-fixed-dim: '#c2c1ff'
  on-secondary-fixed: '#0c006a'
  on-secondary-fixed-variant: '#3631b4'
  tertiary-fixed: '#ffdbcc'
  tertiary-fixed-dim: '#ffb595'
  on-tertiary-fixed: '#351000'
  on-tertiary-fixed-variant: '#7c2e00'
  background: '#f9f9fe'
  on-background: '#1a1c1f'
  surface-variant: '#e2e2e7'
typography:
  display:
    fontFamily: Inter
    fontSize: 40px
    fontWeight: '700'
    lineHeight: 48px
    letterSpacing: -0.02em
  h1:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 38px
    letterSpacing: -0.02em
  h2:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 30px
    letterSpacing: -0.01em
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 26px
    letterSpacing: '0'
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: '0'
  label-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
    letterSpacing: 0.01em
  label-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.02em
rounded:
  sm: 0.5rem
  DEFAULT: 1rem
  md: 1.5rem
  lg: 2rem
  xl: 3rem
  full: 9999px
spacing:
  unit: 8px
  margin-page: 24px
  gutter: 16px
  container-padding: 20px
---

## Brand & Style

The design system is centered on a vision of "Ethereal Minimalism," imagining a future iteration of mobile interfaces where the physical device disappears, leaving only content suspended in light. It targets a premium audience that values clarity, technological sophistication, and a sense of calm. 

The aesthetic is driven by high-transparency layers, organic motion, and a feeling of weightlessness. By utilizing a heavy glassmorphism approach, the design system creates a sense of depth and spatial awareness without relying on traditional skuomorphic shadows. The emotional response is intended to be one of "digital serenity"—uncluttered, responsive, and breathable.

## Colors

The palette is light and airy, dominated by varying opacities of white and extremely desaturated neutrals. Vivid colors are reserved for functional states and subtle accents rather than structural elements.

- **Primary & Secondary:** Used sparingly for focal points and high-priority interactions.
- **Glass Base:** A highly transparent white is used for all containers, designed to sit over dynamic, soft-gradient backgrounds.
- **Status Accents:** Active or "Downloaded" states utilize a vibrant, glowing mint green. Inactive or "Not Downloaded" states use a soft, luminous rose red. These colors should possess an inner glow rather than a flat fill.
- **Backgrounds:** This design system relies on a mesh-gradient background (soft pastels like lavender, sky blue, and peach) to provide the "color" that bleeds through the frosted glass elements.

## Typography

The typography system utilizes **Inter** for its neutral, high-legibility characteristics, which balance the highly expressive glass visual style. 

- **Hierarchy:** Established through significant weight shifts (Bold for headers vs. Regular for body) rather than just size changes.
- **Tight Kerning:** Large headlines use slightly negative letter spacing to mimic the "squished" premium look of modern editorial mobile apps.
- **Readability:** On glass surfaces, text must maintain a high contrast ratio. Use "Vibrant" labels (a technique where text color is slightly tinted by the background) only for secondary information.

## Layout & Spacing

The layout philosophy follows a **fluid grid** model optimized for edge-to-edge content. It prioritizes generous margins and "breathability" to ensure the glass elements do not feel cluttered.

- **Grid:** A standard 4-column mobile grid with 24px side margins.
- **Rhythm:** An 8px linear scale guides all spacing decisions.
- **Safe Areas:** All frosted headers and tab bars must respect hardware safe areas, extending the blur effect into the status bar and home indicator regions for a seamless, "liquid" appearance.

## Elevation & Depth

Elevation in the design system is defined by **optical density** and **blur intensity** rather than drop shadows.

- **The Glass Stack:**
  - **Level 1 (Base):** Subtle background blur (20px) with 40% white opacity. Used for large cards.
  - **Level 2 (Navigation):** High background blur (40px) with 60% white opacity. Used for Top Nav Bars and Bottom Tab Bars.
  - **Level 3 (Overlay):** Maximum blur (60px) with a fine 1px inner white border to simulate light catching the edge of the glass. Used for Modals and Menus.
- **Shadows:** If used, shadows must be "Ambient Glows"—extremely diffused (blur > 30px) and tinted with the primary or status color, rather than black or gray.

## Shapes

The design system uses a "Hyper-Rounded" language to evoke a friendly, futuristic hardware-software integration. 

- **Squircle Logic:** All containers should utilize a continuous corner curve (squircle) rather than a simple radius where possible.
- **Hierarchy of Curves:** Large layout containers use the maximum radius (rounded-xl/32px+), while interactive components like buttons use pill-shapes (fully rounded ends) to distinguish them as touch targets.
- **Nested Corners:** Ensure inner element radii are mathematically adjusted (outer radius minus padding) to maintain concentric harmony.

## Components

- **Glass Cards:** Feature a `backdrop-filter: blur(20px)`, a `1px` semi-transparent white border, and no traditional shadow. Content inside should be padded by at least `20px`.
- **Interactive Buttons:** Use a solid white or primary color fill with a subtle "Outer Glow" effect in the color of the button. On press, the button should shrink slightly (scale 0.96).
- **Status Indicators:** Small, circular dots or thin rings that emit a `10px` soft blur "glow" of the same color (Green for active, Red for inactive). 
- **Navigation Bars:** Floating glass islands that do not touch the screen edges, appearing to hover over the content.
- **Icons:** Use thin-stroke (1.5pt) line icons with rounded terminals. For active states, icons can transition into a "duotone" soft-fill style.
- **Input Fields:** Minimalist glass troughs with a `2px` bottom border that glows when focused.