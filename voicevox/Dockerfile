FROM voicevox/voicevox_engine:cpu-ubuntu20.04-latest

# コンテナ内のポートを開放
EXPOSE 50021

# コンテナ起動時に実行するコマンド
CMD ["exec gosu user /opt/python/bin/python3 ./run.py --voicelib_dir /opt/voicevox_core/ --runtime_dir /opt/onnxruntime/lib --host 0.0.0.0"]
