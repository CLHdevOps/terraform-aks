provider "azurerm" {
  tenant_id       = "__TenantId__"
  subscription_id = "__DeployToSubscriptionID__"
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

provider "azurerm" {
  alias                      = "ent-shared-dev"
  tenant_id                  = "__TenantId__"
  subscription_id            = "2cae3cb5-b083-4bcf-bc5b-c7ca97a261f6"
  skip_provider_registration = "true"
  features {}
}

provider "azurerm" {
  alias                      = "prod"
  tenant_id                  = "__TenantId__"
  subscription_id            = "d85a6196-cb96-46f4-837e-38bc0872955f"
  skip_provider_registration = "true"
  features {}
}

provider "azurerm" {
  alias                      = "dev"
  tenant_id                  = "__TenantId__"
  subscription_id            = "4b2cad93-a78d-48fd-a220-754603bc86b9"
  skip_provider_registration = "true"
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.10"
    }

    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2"
    }
  }
}
