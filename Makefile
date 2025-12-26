COLOR_GREEN := \033[0;32m
COLOR_BLUE := \033[0;34m
COLOR_RESET := \033[0m

.PHONY: help bootstrap bs install i generate g build_runner br l10n l

help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@echo "  bootstrap (bs)      Install dependencies and generate code"
	@echo "  install (i)         Install dependencies"
	@echo "  generate (g)        Generate all code (build_runner and l10n)"
	@echo "  build_runner (br)   Run build_runner"
	@echo "  l10n (l)            Generate localization files"

bootstrap: install generate
	@echo ""
	@echo "$(COLOR_GREEN)✓ Bootstrap complete$(COLOR_RESET)"
bs: bootstrap

install:
	@echo ""
	@echo "$(COLOR_BLUE)flutter pub get$(COLOR_RESET)"
	@flutter pub get
	@echo ""
	@echo "$(COLOR_GREEN)✓ Install complete$(COLOR_RESET)"
i: install

generate: build_runner l10n
	@echo ""
	@echo "$(COLOR_GREEN)✓ Generate complete$(COLOR_RESET)"
g: generate

build_runner:
	@echo ""
	@echo "$(COLOR_BLUE)cd forui && dart run build_runner build --delete-conflicting-outputs$(COLOR_RESET)"
	@cd forui && dart run build_runner build --delete-conflicting-outputs
	@echo ""
	@echo "$(COLOR_BLUE)cd forui_assets && dart run build_runner build --delete-conflicting-outputs$(COLOR_RESET)"
	@cd forui_assets && dart run build_runner build --delete-conflicting-outputs
	@echo ""
	@echo "$(COLOR_BLUE)cd samples && dart run build_runner build --delete-conflicting-outputs$(COLOR_RESET)"
	@cd samples && dart run build_runner build --delete-conflicting-outputs
	@echo ""
	@echo "$(COLOR_GREEN)✓ Build runner complete$(COLOR_RESET)"
br: build_runner

l10n:
	@echo ""
	@echo "$(COLOR_BLUE)cd forui && flutter gen-l10n$(COLOR_RESET)"
	@cd forui && flutter gen-l10n
	@echo "$(COLOR_GREEN)✓ l10n complete$(COLOR_RESET)"
l: l10n
