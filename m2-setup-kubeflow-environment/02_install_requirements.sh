#!/bin/bash

echo "Installing kubectl..."
brew install kubectl
echo "Successfully installed kubectl"

echo "Installing kpt..."
brew tap GoogleContainerTools/kpt https://github.com/GoogleContainerTools/kpt.git
brew install kpt
echo "Successfully installed kpt"

echo "Installing kustomize..."
brew install akiyamasho/homebrew-kustomize/kustomize
echo "Successfully installed kustomize"

echo "Installing yq v3..."
brew install yq@3
echo 'export PATH="/usr/local/opt/yq@3/bin:$PATH"' >> ~/.zshrc
echo "Successfully installed yq version 3"
