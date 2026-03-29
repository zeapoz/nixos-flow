#!/usr/bin/env bash
#
# Toggle voice dictation using whisper-stream.
# First run: starts recording.
# Second run: stops recording and copies result to clipboard.

MODEL="$HOME/.local/share/whisper/ggml-base.en.bin"
PID_FILE="/tmp/voice-dictation.pid"
TMP_FILE="/tmp/voice-dictation.txt"

if [ ! -f "$MODEL" ]; then
	notify-send -u critical "Voice Dictation" "Model not found. Run: whisper-cpp-download-ggml-model base.en ~/.local/share/whisper/"
	exit 1
fi

# If already running, stop it and copy to clipboard
if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
	kill "$(cat "$PID_FILE")" 2>/dev/null
	wait "$(cat "$PID_FILE")" 2>/dev/null || true
	notify-send "Voice Dictation" "Stopped and copied to clipboard."
	sleep 0.5

	sed 's/\[[^]]*\]//g' "$TMP_FILE" | wl-copy
	rm -f "$TMP_FILE"
	rm -f "$PID_FILE"
	exit 0
fi

notify-send "Voice Dictation" "Listening... (press Super+X again to stop)"

rm -f "$TMP_FILE"

whisper-stream \
	-m "$MODEL" \
	--step 60000 \
	-f "$TMP_FILE" &
STREAM_PID=$!
echo "$STREAM_PID" >"$PID_FILE"

wait "$STREAM_PID"
rm -f "$PID_FILE"
