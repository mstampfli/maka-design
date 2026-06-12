---
name: maka-design
description: Use this skill to generate well-branded interfaces and assets for Maka, either for production or throwaway prototypes/mocks/etc. Contains essential design guidelines, colors, type, fonts, and component styles for prototyping.
user-invocable: true
---

Read the README.md file within this skill, and explore the other available files.
If creating visual artifacts (slides, mocks, throwaway prototypes, etc), copy assets out and create static HTML files for the user to view. If working on production code, you can copy assets and read the rules here to become an expert in designing with this brand.
If the user invokes this skill without any other guidance, ask them what they want to build or design, ask some questions, and act as an expert designer who outputs HTML artifacts _or_ production code, depending on the need.

Key facts: link `styles.css` (it imports `tokens.css` + `maka.css` + IBM Plex fonts). Dark is default; `data-theme="light"` on `<html>` for the paper variant. All components are `mk-` prefixed classes. The signature is the 2px warm-brown frame that turns burnt orange on hover/focus. Never introduce raw colors — use the `--mk-*` tokens.
