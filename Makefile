PROJECT_NAME := $(shell basename $(PWD))
VERSION := $(shell git describe --tags --always --dirty 2>/dev/null || echo "dev")

.DEFAULT_GOAL := help

.PHONY: help
help: ## このヘルプを表示
	@awk 'BEGIN {FS = ":.*## "}; /^##/ { printf "\n\033[33m%s\033[0m\n", substr($$0, 4) } \
		/^[a-zA-Z_-]+:.*##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

## セットアップ関連

.PHONY: setup
setup: ## プロジェクトディレクトリの作成
	mkdir -p docs tests scripts tmp

.PHONY: setup-claudecode
setup-claudecode: ## ClaudeCodeとツールのセットアップ
	@./scripts/setup-claudecode.sh

.PHONY: setup-diagrams
setup-diagrams: ## plantumlのセットアップ
	docker build -f container/plantuml/Dockerfile -t plantuml:latest .
	mkdir -p ~/.local/bin
	cp scripts/plantuml ~/.local/bin/plantuml
	chmod +x ~/.local/bin/plantuml

.PHONY: setup-all
setup-all: setup setup-claudecode setup-diagrams ## 全てのセットアップを実行

## その他

.PHONY: clean
clean: ## 一時ファイルとログを削除
	rm -rf tmp/* logs/*

.PHONY: status
status: ## プロジェクトの状態を表示
	@echo "Project: $(PROJECT_NAME)"
	@echo "Version: $(VERSION)"
	@git status --short
