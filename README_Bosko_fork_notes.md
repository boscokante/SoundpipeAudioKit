# Talkbox Sibilance Handling Update

**Commit Date:** July 9, 2025

**Subject:** `feat(talkbox): Implement sibilance handling and update struct`

### Description

This commit improves the realism of the `sp_talkbox` module by introducing proper handling for sibilant (unvoiced) sounds.

Previously, unvoiced consonants like 's', 'f', and 'sh' were processed with the pitched carrier signal, resulting in an unnatural, tonal quality. This update addresses the issue by detecting these sounds and replacing the carrier with white noise.

### File Changes

1.  **`talkbox.c` - Unvoiced Sound Detection:**
    *   An unvoiced sound detector was added, which analyzes the input signal's Root Mean Square (RMS) and Zero-Crossing Rate (ZCR).
    *   A simple white noise generator was implemented.
    *   Logic was added to smoothly crossfade between the synthesizer carrier and the white noise when unvoiced sounds are detected, ensuring a natural transition.

2.  **`Soundpipe.h` - Struct Definition Update:**
    *   The `sp_talkbox` struct has been updated with five new members to support the new sibilance handling logic: `zcr_smooth`, `rms_smooth`, `last_src`, `noise_mix`, and `noise_seed`. This synchronizes the header definition with the implementation in the C module.