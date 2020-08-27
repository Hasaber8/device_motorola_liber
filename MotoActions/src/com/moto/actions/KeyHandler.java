/*
 * Copyright (C) 2020 OmniROM Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.moto.actions;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.provider.Settings;
import android.util.Log;
import android.view.KeyEvent;

import com.android.internal.util.omni.DeviceKeyHandler;

public class KeyHandler implements DeviceKeyHandler {
    private static final String TAG = KeyHandler.class.getSimpleName();

    private static final int FPS_DTAP_SCAN_CODE = 622;
    private static final String FPS_DTAP_SETTINGS = "sidefps_gesture_enabled";
    private static final String DTAP_INTENT = "com.motorola.sidefps.doubletap";
    private static final String DTAP_COMPONENT = "com.motorola.motofpstouch";
    private static final String DTAP_SERVICE = "com.motorola.motoedgeassistant.FpsGestureDetectionService";

    private final Context mContext;

    public KeyHandler(Context context) {
        mContext = context;
    }

    public boolean handleKeyEvent(KeyEvent event) {
        int scanCode = event.getScanCode();
        boolean fpsGestureEnable = Settings.Global.getInt(mContext.getContentResolver(), FPS_DTAP_SETTINGS, 0) != 0;

        if (scanCode != FPS_DTAP_SCAN_CODE || !fpsGestureEnable || event.getAction() != KeyEvent.ACTION_UP) {
            return false;
        }

        Intent intent = new Intent(DTAP_INTENT);
        intent.setComponent(new ComponentName(DTAP_COMPONENT, DTAP_SERVICE));
        mContext.startForegroundService(intent);

        return true;
    }

    public boolean canHandleKeyEvent(KeyEvent event) {
        int scanCode = event.getScanCode();
        boolean fpsGestureEnable = Settings.Global.getInt(mContext.getContentResolver(), FPS_DTAP_SETTINGS, 0) != 0;

        if (scanCode == FPS_DTAP_SCAN_CODE && fpsGestureEnable) {
            return true;
        }
        return false;
    }

    public boolean isCameraLaunchEvent(KeyEvent event) {
        return false;
    }

    public boolean isWakeEvent(KeyEvent event) {
        return false;
    }

    public boolean isDisabledKeyEvent(KeyEvent event) {
        return false;
    }

    public Intent isActivityLaunchEvent(KeyEvent event) {
        return null;
    }
}
