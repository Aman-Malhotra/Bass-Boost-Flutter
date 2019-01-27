package com.amanmalhotra.bassboost;

import android.media.audiofx.BassBoost;
import android.util.Log;

public class BassClass {
    final BassBoost bassBoost;

    BassClass(int sessionId) {
        bassBoost = new BassBoost(0, sessionId);
        Log.d("Bass Boost", "Initialized BassBoost");
    }

    void setEnabled(boolean b) {
        bassBoost.setEnabled(b);
    }
    boolean getEnabled() {
        return bassBoost.getEnabled();
    }
    void setStrength(short s) {
        bassBoost.setStrength(s);
    }

    short getStrength() {
        return bassBoost.getRoundedStrength();
    }

}
