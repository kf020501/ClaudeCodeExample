PROJECT_NAME := $(shell basename $(PWD))
VERSION := $(shell git describe --tags --always --dirty 2>/dev/null || echo "dev")

.DEFAULT_GOAL := help

.PHONY: help
help: ## このヘルプを表示
	@grep -E '^[a-zA-Z0-9_.-]+:.*## ' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS=":.*## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup: ## プロジェクトディレクトリの作成
	mkdir -p bin src docs tests config scripts logs tmp

.PHONY: setup-claudecode
setup-claudecode: ## ClaudeCodeとツールのセットアップ
	@./scripts/setup-claudecode.sh

.PHONY: setup-diagrams
setup-diagrams: ## plantumlのセットアップ
	docker build -f container/plantuml/Dockerfile -t plantuml:latest .

.PHONY: setup-all
setup-all: setup setup-claudecode setup-diagrams ## 全てのセットアップを実行

.PHONY: diagrams
diagrams: ## PlantUMLで全ての図を生成
	docker run --rm -v "$$(pwd):/work" plantuml -tsvg "docs/diagrams/*.puml"

.PHONY: clean
clean: ## 一時ファイルとログを削除
	rm -rf tmp/* logs/*

.PHONY: status
status: ## プロジェクトの状態を表示
	@echo "Project: $(PROJECT_NAME)"
	@echo "Version: $(VERSION)"
	@git status --short
