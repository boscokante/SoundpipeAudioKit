// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

#pragma once

#import "SoundpipeDSPBase.h"

// Analysis
#import "PitchTracker.h"

// Custom interop
CF_EXTERN_C_BEGIN
void akCombFilterReverbSetLoopDuration(DSPRef dsp, float duration);
void akConvolutionSetPartitionLength(DSPRef dsp, int length);
void akFlatFrequencyResponseSetLoopDuration(DSPRef dsp, float duration);
void akVariableDelaySetMaximumTime(DSPRef dsp, float maximumTime);
void akPhaseLockedVocoderSetMincerSize(DSPRef dspRef, int size);

// PitchCorrect state getters
float akPitchCorrectGetDetectedFreq(DSPRef dsp);
bool akPitchCorrectGetCorrectionActive(DSPRef dsp);
float akPitchCorrectGetNearestScaleFreq(DSPRef dsp);
float akPitchCorrectGetCorrectionCents(DSPRef dsp);
CF_EXTERN_C_END
