# Completions for scrcpy

function __scrcpy_shortcut_mod_values
    echo lctrl
    echo rctrl
    echo lalt
    echo ralt
    echo lsuper
    echo rsuper
end

function __scrcpy_complete_shortcut_mod
    set -l token (commandline -ct)

    # strip the --shortcut-mod= part if fish left it on the token
    set token (string replace -r '^--shortcut-mod=' '' -- $token)

    set -l prefix ''
    set -l cur $token
    if string match -q '*,*' -- $token
        set prefix (string replace -r '[^,]*$' '' -- $token)
        set cur (string split -r -m1 ',' -- $token)[-1]
    end

    set -l used
    if test -n "$prefix"
        set used (string split ',' -- (string trim -r -c ',' -- $prefix))
    end

    for val in (__scrcpy_shortcut_mod_values)
        if not contains -- $val $used
            echo "$prefix$val"
        end
    end
end

function __scrcpy_audio_codec_completions
    scrcpy --list-encoders 2>/dev/null | awk '/--audio-encoder=/ && !/alias/ { for(i=1; i<=NF; i++) if ($i ~ /^--audio-encoder=/) { split($i, a, "="); print a[2] } }'
end

function __scrcpy_video_codec_completions
    scrcpy --list-encoders 2>/dev/null | awk '/--video-encoder=/ && !/alias/ { for(i=1; i<=NF; i++) if ($i ~ /^--video-encoder=/) { split($i, a, "="); print a[2] } }'
end

# Clear existing completions
complete -c scrcpy -ef

# Global Flags
complete -c scrcpy      -l always-on-top                     -d "Make scrcpy window always on top (above other windows)"
complete -c scrcpy      -l angle                             -x -d "Rotate the video content by a custom angle, in degrees (clockwise)"
complete -c scrcpy      -l audio-bit-rate                    -x -d "Encode the audio at the given bit rate, expressed in bits/s"
complete -c scrcpy      -l audio-buffer                      -x -d "Configure the audio buffering delay (in milliseconds). Default is 50"
complete -c scrcpy      -l audio-codec                       -xa "aac flac opus raw" -d "Select an audio codec (opus, aac, flac or raw). Default is opus"
complete -c scrcpy      -l audio-codec-options               -x -d "Set a list of comma-separated key:type=value options for the device audio encoder"
complete -c scrcpy      -l audio-dup                         -d "Duplicate audio (capture and keep playing on the device)"
complete -c scrcpy      -l audio-encoder                     -xa "(__scrcpy_audio_codec_completions)" -d "Use a specific MediaCodec audio encoder"
complete -c scrcpy      -l audio-source                      -xa "output playback mic mic-unprocessed mic-camcorder mic-voice-recognition mic-voice-communication voice-call voice-call-uplink voice-call-downlink voice-performance" -d "Select the audio source"
complete -c scrcpy      -l audio-output-buffer               -x -d "Configure the size of the SDL audio output buffer (in milliseconds)"
complete -c scrcpy -s b -l video-bit-rate                    -x -d "Encode the video at the given bit rate, expressed in bits/s"
complete -c scrcpy      -l background-color                  -x -d "Set the background color, encoded as hexadecimal color code (#RGB or #RRGGBB)"
complete -c scrcpy      -l camera-ar                         -x -d "Select the camera size by its aspect ratio (+/- 10%)"
complete -c scrcpy      -l camera-facing                     -xa "back external front" -d "Select the device camera by its facing direction"
complete -c scrcpy      -l camera-fps                        -x -d "Specify the camera capture frame rate"
complete -c scrcpy      -l camera-high-speed                 -d "Enable high-speed camera capture mode"
complete -c scrcpy      -l camera-id                         -x -d "Specify the device camera id to mirror"
complete -c scrcpy      -l camera-size                       -x -d "Specify an explicit camera capture size"
complete -c scrcpy      -l camera-torch                      -d "Turn on the camera torch when the camera starts"
complete -c scrcpy      -l camera-zoom                       -x -d "Specify the camera zoom initial value"
complete -c scrcpy      -l capture-orientation               -xa "@0 @90 @180 @270 @flip0 @flip90 @flip180 @flip270" -d "Set the capture video orientation"
complete -c scrcpy      -l crop                              -x -d "Crop the device screen on the server"
complete -c scrcpy -s d -l select-usb                        -d "Use USB device (if there is exactly one, like adb -d)"
complete -c scrcpy      -l disable-screensaver               -d "Disable screensaver while scrcpy is running"
complete -c scrcpy      -l display-id                        -x -d "Specify the device display id to mirror"
complete -c scrcpy      -l display-ime-policy                -xa "fallback hide local" -d "Set the policy for selecting where the IME should be displayed"
complete -c scrcpy      -l display-orientation               -xa "@0 @90 @180 @270 @flip0 @flip90 @flip180 @flip270" -d "Set the initial display orientation"
complete -c scrcpy -s e -l select-tcpip                      -d "Use TCP/IP device (if there is exactly one, like adb -e)"
complete -c scrcpy -s f -l fullscreen                        -d "Start in fullscreen"
complete -c scrcpy      -l force-adb-forward                 -d "Do not attempt to use 'adb reverse' to connect to the device"
complete -c scrcpy -s G                                      -d "Same as -l gamepad=uhid, or -l gamepad=aoa if -l otg is set"
complete -c scrcpy      -l gamepad                           -xa "aoa disabled uhid" -d "Select how to send gamepad inputs to the device"
complete -c scrcpy -s h -l help                              -d "Print this help"
complete -c scrcpy      -l ignore-video-encoder-constraints  -d "Do not consider video encoder capabilities"
complete -c scrcpy -s K                                      -d "Same as -l keyboard=uhid, or -l keyboard=aoa if -l otg is set"
complete -c scrcpy      -l keep-active                       -d "Keep the screen on by simulating user activity"
complete -c scrcpy      -l keyboard                          -xa "disabled sdk uhid aoa" -d "Select how to send keyboard inputs to the device"
complete -c scrcpy      -l kill-adb-on-close                 -d "Kill adb when scrcpy terminates"
complete -c scrcpy      -l legacy-paste                      -d "Inject computer clipboard text as a sequence of key events on Ctrl+v (like MOD+Shift+v)"
complete -c scrcpy      -l list-apps                         -d "List Android apps installed on the device"
complete -c scrcpy      -l list-cameras                      -d "List device cameras"
complete -c scrcpy      -l list-camera-sizes                 -d "List the valid camera capture sizes"
complete -c scrcpy      -l list-displays                     -d "List device displays"
complete -c scrcpy      -l list-encoders                     -d "List video and audio encoders available on the device"
complete -c scrcpy -s m -l max-size                          -x -d "Limit both the width and height of the video"
complete -c scrcpy -s M                                      -d "Same as -l mouse=uhid, or -l mouse=aoa if -l otg is set"
complete -c scrcpy      -l max-fps                           -x -d "Limit the frame rate of screen capture"
complete -c scrcpy      -l min-size-alignment                -x -d "Configure the minimum video size alignment"
complete -c scrcpy      -l mouse                             -xa "aoa disabled sdk uhid" -d "Select how to send mouse inputs to the device"
complete -c scrcpy      -l mouse-bind                        -x -d "Configure bindings of secondary clicks"
complete -c scrcpy -s n -l no-control                        -d "Disable device control (mirror the device in read-only)"
complete -c scrcpy -s N -l no-playback                       -d "Disable video and audio playback on the computer (equivalent to -l no-video-playback"
complete -c scrcpy      -l new-display                       -x -d "Create a new display with the specified resolution and density"
complete -c scrcpy      -l no-audio                          -d "Disable audio forwarding"
complete -c scrcpy      -l no-audio-playback                 -d "Disable audio playback on the computer"
complete -c scrcpy      -l no-cleanup                        -d "Disable restoring the device state on exit(show touches, stay awake and power mode)"
complete -c scrcpy      -l no-clipboard-autosync             -d "Disable automatic synchronization of clipboard"
complete -c scrcpy      -l no-downsize-on-error              -d "Disable automatic tries with a lower definition on MediaCodec error"
complete -c scrcpy      -l no-key-repeat                     -d "Do not forward repeated key events when a key is held down"
complete -c scrcpy      -l no-mipmaps                        -d "Disable the generation of mipmaps for OpenGL 3.0+ or OpenGL ES 2.0+ renderers"
complete -c scrcpy      -l no-mouse-hover                    -d "Do not forward mouse hover (mouse motion without any clicks) events"
complete -c scrcpy      -l no-power-on                       -d "Do not power on the device on start"
complete -c scrcpy      -l no-terminal-title                 -d "Disable terminal title updates"
complete -c scrcpy      -l no-vd-destroy-content             -d "Disable virtual display 'destroy content on removal' flag"
complete -c scrcpy      -l no-vd-system-decorations          -d "Disable virtual display system decorations flag"
complete -c scrcpy      -l no-video                          -d "Disable video forwarding"
complete -c scrcpy      -l no-video-playback                 -d "Disable video playback on the computer"
complete -c scrcpy      -l no-window                         -d "Disable scrcpy window. Implies -l no-video-playback"
complete -c scrcpy      -l no-window-aspect-ratio-lock       -d "Disable window aspect ratio lock"
complete -c scrcpy      -l orientation                       -d "Same as -l display-orientation=value -l record-orientation=value"
complete -c scrcpy      -l otg                               -d "Run in OTG mode: simulate physical keyboard and mouse"
complete -c scrcpy -s p -l port                              -x -d "Set the TCP port (range) used by the client to listen"
complete -c scrcpy      -l pause-on-exit                     -xa "true false if-error" -d "Configure pause on exit"
complete -c scrcpy      -l power-off-on-close                -d "Turn the device screen off when closing scrcpy"
complete -c scrcpy      -l prefer-text                       -d "Inject alpha characters and space as text events instead of key events"
complete -c scrcpy      -l print-fps                         -d "Start FPS counter. It can be started or stopped at any time with MOD+i"
complete -c scrcpy      -l push-target                       -x -d "Set the target directory for pushing files to the device by drag & drop"
complete -c scrcpy -s r -l record                            -r -d "Record screen to file"
complete -c scrcpy      -l raw-key-events                    -d "Inject key events for all input keys, and ignore text events"
complete -c scrcpy      -l record-format                     -xa "mp4 mkv m4a mka opus aac flac wav" -d "Force recording format"
complete -c scrcpy      -l record-orientation                -xa "0 90 180 270" -d "Set the record orientation"
complete -c scrcpy      -l render-driver                     -xa "direct3d opengl opengles2 opengles metal software" -d "Request SDL to use the given render driver (this is just a hint)"
complete -c scrcpy      -l render-fit                        -xa "letterbox stretched unscaled" -d "Set the render-fit mode to configure how the rendering fits the window"
complete -c scrcpy      -l require-audio                     -d "Makes scrcpy fail if audio is enabled but does not work"
complete -c scrcpy -s s -l serial                            -x -d "The device serial number. Mandatory only if several devices are connected to adb"
complete -c scrcpy -s S -l turn-screen-off                   -d "Turn the device screen off immediately"
complete -c scrcpy      -l screen-off-timeout                -x -d "Set the screen off timeout while scrcpy is running (restore the initial value on exit)"
complete -c scrcpy      -l shortcut-mod                      -xa '(__scrcpy_complete_shortcut_mod)' -d 'Shortcut modifier keys'
 complete -c scrcpy      -l shortcut-mod                      -xa "lctrl rctrl lalt ralt lsuper rsuper" -d "Specify the modifiers to use for scrcpy shortcuts"
complete -c scrcpy      -l start-app                         -xa "(adb shell pm list packages | cut -d':' -f2)" -d "Start an Android app, by its exact package name"
complete -c scrcpy -s t -l show-touches                      -d "Enable 'show touches' on start, restore the initial value on exit"
complete -c scrcpy      -l tcpip                             -x -d "Configure and connect the device over TCP/IP"
complete -c scrcpy      -l time-limit                        -x -d "Set the maximum mirroring time, in seconds"
complete -c scrcpy      -l tunnel-host                       -x -d "Set the IP address of the adb tunnel to reach the scrcpy server"
complete -c scrcpy      -l tunnel-port                       -x -d "Set the TCP port of the adb tunnel to reach the scrcpy server"
complete -c scrcpy -s v -l version                           -d "Print the version of scrcpy"
complete -c scrcpy -s V -l verbosity                         -xa "verbose debug info warn error" -d "Set the log level"
complete -c scrcpy      -l v4l2-sink                         -r -d "Output to v4l2loopback device"
complete -c scrcpy      -l v4l2-buffer                       -x -d "Add a buffering delay (in milliseconds) before pushing frames"
complete -c scrcpy      -l video-buffer                      -x -d "Add a buffering delay (in milliseconds) before displaying video frames"
complete -c scrcpy      -l video-codec                       -xa "h264 h265 av1 vp8 vp9" -d "Select a video codec"
complete -c scrcpy      -l video-codec-options               -d "Set a list of comma-separated key:type=value options for the device video encoder"
complete -c scrcpy      -l video-encoder                     -xa "(__scrcpy_video_codec_completions)" -d "Use a specific MediaCodec video encoder"
complete -c scrcpy      -l video-source                      -xa "camera display" -d "Select the video source (display or camera)"
complete -c scrcpy -s w -l stay-awake                        -d "Keep the device on while scrcpy is running, when the device is plugged in"
complete -c scrcpy      -l window-borderless                 -d "Disable window decorations (display borderless window)"
complete -c scrcpy      -l window-title                      -x -d "Set a custom window title"
complete -c scrcpy      -l window-x                          -x -d "Set the initial window horizontal position"
complete -c scrcpy      -l window-y                          -x -d "Set the initial window vertical position"
complete -c scrcpy      -l window-width                      -x -d "Set the initial window width"
complete -c scrcpy      -l window-height                     -x -d "Set the initial window height"
complete -c scrcpy -s x -l flex-display                      -d "Continuously resize the virtual display to match the window"
