// Copyright AudioKit. All Rights Reserved.

#include "SoundpipeDSPBase.h"
#include "ParameterRamper.h"
#include "Soundpipe.h"

enum TalkboxParameter : AUParameterAddress {
    TalkboxParameterQuality,
};

class TalkboxDSP : public SoundpipeDSPBase {
private:
    sp_talkbox *talkboxL;
    sp_talkbox *talkboxR;
    ParameterRamper qualityRamp{1.0};

public:
    TalkboxDSP() {
        inputBufferLists.resize(2);  // Set up for two input streams
        parameters[TalkboxParameterQuality] = &qualityRamp;
    }

    void init(int channelCount, double sampleRate) override {
        SoundpipeDSPBase::init(channelCount, sampleRate);
        sp_talkbox_create(&talkboxL);
        sp_talkbox_init(sp, talkboxL);
        sp_talkbox_create(&talkboxR);
        sp_talkbox_init(sp, talkboxR);
    }

    void deinit() override {
        SoundpipeDSPBase::deinit();
        sp_talkbox_destroy(&talkboxL);
        sp_talkbox_destroy(&talkboxR);
    }

    void reset() override {
        SoundpipeDSPBase::reset();
        if (!isInitialized) return;
        sp_talkbox_init(sp, talkboxL);
        sp_talkbox_init(sp, talkboxR);
    }

    void process(FrameRange range) override {
        for (int i : range) {
            float sourceIn = inputSample(0, i);       // mono voice modulator (mic left channel)
            float excitationIn = input2Sample(0, i);  // mono carrier (sawtooth, left channel only)
            float outSample;

            float quality = qualityRamp.getAndStep();
            talkboxL->quality = quality;

            sp_talkbox_compute(sp, talkboxL, &sourceIn, &excitationIn, &outSample);

            // Output the same mono signal to both channels
            outputSample(0, i) = outSample;
            outputSample(1, i) = outSample;
        }
    }
};

AK_REGISTER_DSP(TalkboxDSP, "tbox")
AK_REGISTER_PARAMETER(TalkboxParameterQuality)
