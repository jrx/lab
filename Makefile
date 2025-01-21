# Check if env variable is set
ifndef env
$(error env is not set. Please set it to the desired environment)
endif

ifndef app
$(error app is not set. Please set it to the desired application)
endif

# Variables
BACKEND_CONFIG := path=$(env)/terraform.tfstate
VAR_FILE := $(env).tfvars

# Phony targets
.PHONY: init plan apply fmt help

# Default target
.DEFAULT_GOAL := help

# Targets
init:
	@echo "Initializing Terraform..."
	terraform -chdir=$(app) \
		init \
		-reconfigure \
		-backend-config=$(BACKEND_CONFIG)

plan:
	@echo "Planning Terraform changes..."
	terraform -chdir=$(app) \
		plan \
		-var-file=$(VAR_FILE)

apply:
	@echo "Planning Terraform changes..."
	terraform -chdir=$(app) \
		apply -auto-approve \
		-var-file=$(VAR_FILE)

fmt:
	@echo "Planning Terraform changes..."
	terraform -chdir=$(app) \
		fmt -recursive \
	&& terraform -chdir=$(app) \
		validate

help:
	@echo "Available targets:"
	@echo "  init   - Initialize Terraform"
	@echo "  plan   - Plan Terraform changes"
	@echo "  apply  - Apply Terraform changes"
	@echo "  fmt    - Format and validate Terraform configuration files"
	@echo "  help   - Show this help message"
	@echo ""
	@echo "Usage: make <target> env=<environment> app=<application>"
	@echo "Example: make plan env=dev"