PROJECT_NAME := $(shell basename $(PWD))
VERSION := $(shell git describe --tags --always --dirty 2>/dev/null || echo "dev")

.DEFAULT_GOAL := help

.PHONY: help
help: ## このヘルプを表示
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup: ## プロジェクトディレクトリの作成
	mkdir -p bin src docs tests config scripts logs tmp

.PHONY: setup-claudecode
setup-claudecode: ## ClaudeCodeとツールのセットアップ
	@./scripts/setup-claudecode.sh

.PHONY: setup-all
setup-all: setup setup-claudecode ## 全てのセットアップを実行

.PHONY: clean
clean: ## 一時ファイルとログを削除
	rm -rf tmp/* logs/*

.PHONY: status
status: ## プロジェクトの状態を表示
	@echo "Project: $(PROJECT_NAME)"
	@echo "Version: $(VERSION)"
	@git status --short