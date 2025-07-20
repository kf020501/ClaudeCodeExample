#!/bin/bash

# ClaudeCodeとツールのセットアップスクリプト

echo "Setting up curl, Node.js, ClaudeCode and tools..."

# curl のインストール
if command -v curl >/dev/null 2>&1; then
    echo "curl is already installed"
else
    echo "Installing curl..."
    if command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update && sudo apt-get install -y curl
    elif command -v yum >/dev/null 2>&1; then
        sudo yum install -y curl
    else
        echo "Unsupported OS. Please install curl manually."
        exit 1
    fi
fi

# Node.js のインストール
if command -v node >/dev/null 2>&1; then
    echo "Node.js is already installed"
else
    echo "Installing Node.js..."
    if command -v apt-get >/dev/null 2>&1; then
        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt-get install -y nodejs
    elif command -v yum >/dev/null 2>&1; then
        curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash - && sudo yum install -y nodejs
    else
        echo "Unsupported OS. Please install Node.js manually."
        exit 1
    fi
fi

# ClaudeCode のインストール
if command -v claude >/dev/null 2>&1; then
    echo "ClaudeCode is already installed"
else
    echo "Installing ClaudeCode..."
    curl -fsSL https://claude.ai/install.sh | sh
fi

# tree のインストール
if command -v tree >/dev/null 2>&1; then
    echo "tree is already installed"
else
    echo "Installing tree..."
    if command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update && sudo apt-get install -y tree
    elif command -v yum >/dev/null 2>&1; then
        sudo yum install -y tree
    else
        echo "Unsupported OS. Please install tree manually."
        exit 1
    fi
fi

echo "Setup completed successfully!"