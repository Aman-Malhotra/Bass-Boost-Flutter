package com.amanmalhotra.bassboost;

import android.app.Activity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * BassBoostPlugin
 */
public class BassBoostPlugin implements MethodCallHandler {

    MethodChannel channel;
    Activity activity;
    private int audioSesionId;
    BassClass bass;

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "bass_boost");
        channel.setMethodCallHandler(new BassBoostPlugin(registrar.activity(), channel));
    }

    BassBoostPlugin(Activity activity, MethodChannel methodChannel) {
        this.activity = activity;
        this.channel = methodChannel;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("initAudioSessionId")) {
            int i = call.argument("audioSessionId");
            initAudioSessionId(i);
        } else if (call.method.equals("setEnabled")) {
            boolean b = call.argument("enable");
            setEnabled(b);
        } else if (call.method.equals("getEnabled")) {
            result.success(getEnabled());
        } else if (call.method.equals("setStrength")) {
            int i = call.argument("strength");
            short s = ((short) i);
            setStrength(s);
        } else if (call.method.equals("getStrength")) {
            result.success(getStrength());
        } else {
            result.notImplemented();
        }
    }

    public void initAudioSessionId(int i) {
       this.audioSesionId = i;
    }

    public void initBass() {
        if (bass == null) bass = new BassClass(audioSesionId);
    }

    public void setEnabled(boolean b) {
        initBass();
        bass.setEnabled(b);
    }

    public boolean getEnabled() {
        initBass();
        return bass.getEnabled();
    }

    public void setStrength(short s) {
        initBass();
        if (s >= 0 && s <= 1000) bass.setStrength(s);
    }

    public short getStrength() {
        return bass.getStrength();
    }
}
