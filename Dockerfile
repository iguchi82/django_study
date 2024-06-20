# ベースイメージとして公式のPythonイメージを使用
FROM python:3.9-slim

# 作業ディレクトリを作成
WORKDIR /app

# システムの依存関係をインストール（必要に応じて追加）
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# ローカルのrequirements.txtをコンテナの/appディレクトリにコピー
COPY requirements.txt /app/

# Pythonの依存関係をインストール
RUN pip install --no-cache-dir -r requirements.txt

# アプリケーションのコードをすべてコンテナにコピー
COPY . /app/

# ポート8000を公開
EXPOSE 8000

# アプリケーションを起動するためのコマンド
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
