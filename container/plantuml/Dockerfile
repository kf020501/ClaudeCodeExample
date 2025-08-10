FROM ubuntu:22.04

# PlantUML直接実行用のシンプルなコンテナ
RUN apt-get update && \
    apt-get install -y \
    openjdk-11-jre-headless \
    wget \
    graphviz \
    fonts-noto-cjk \
    locales \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen ja_JP.UTF-8

# PlantUMLをダウンロード
WORKDIR /opt/plantuml
RUN wget -O plantuml.jar https://github.com/plantuml/plantuml/releases/download/v1.2024.5/plantuml-1.2024.5.jar

# 作業ディレクトリ
WORKDIR /work

# 日本語フォント設定
ENV LANG=ja_JP.UTF-8
ENV LC_ALL=ja_JP.UTF-8

# PlantUML実行
ENTRYPOINT ["java", "-Dfile.encoding=UTF-8", "-jar", "/opt/plantuml/plantuml.jar"]