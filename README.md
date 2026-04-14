# 🛡️ Azure DevSecOps Golden Image Factory (Template)

## 📌 Overview
This repository provides a fully automated, Infrastructure-as-Code (IaC) pipeline designed to build, test, and verify strictly hardened Virtual Machine "Golden Images" in Microsoft Azure. 

By shifting security to the left, this DevSecOps factory ensures that any new Ubuntu 22.04 LTS or RHEL 9 infrastructure deployed in your cloud environment adheres to the **CIS (Center for Internet Security) Level 1 Benchmark** by default.

## 🏗️ How It Works
This pipeline utilizes a "Trust but Verify" deployment methodology orchestrated entirely via GitHub Actions:

1. **Provisioning:** HashiCorp Packer authenticates with Azure and spins up an ephemeral, invisible build VM.
2. **Hardening:** Ansible executes official CIS Level 1 playbooks locally on the build VM, applying DevSecOps overrides to maintain cloud hypervisor compatibility (e.g., Azure VM Agent, TrustedLaunch).
3. **Capture:** Packer generalizes the VM and pushes the finalized Golden Image to an Azure Compute Gallery.
4. **Verification:** The CI/CD pipeline deploys a temporary VM from the newly baked image and executes military-grade compliance scans using the **OpenSCAP** engine.
5. **Audit Trail:** HTML compliance reports are securely extracted via SCP, the ephemeral infrastructure is destroyed to save costs, and the audit reports are published as immutable GitHub Releases.

## 🛠️ Technology Stack
* **Cloud:** Microsoft Azure (Compute Galleries, NSGs, Managed Identities)
* **IaC & Image Baking:** HashiCorp Packer
* **Configuration Management:** Ansible 
* **CI/CD Orchestration:** GitHub Actions
* **Compliance Engine:** OpenSCAP

## 🚀 How to Use This Template

Because this is a sanitized template, you will need to replace the placeholder variables with your own Azure environment details before running the pipeline.

### Step 1: Create Your Repository
Click the green **Use this template** button at the top right of this repository to create your own copy.

### Step 2: Update Azure Placeholders
Search the repository (specifically your Packer `.pkr.hcl` files and GitHub Action `.yml` workflows) and replace the following placeholder variables with your actual Azure infrastructure names:
* `<YOUR_AZURE_SUBSCRIPTION_ID>`
* `<YOUR_AZURE_TENANT_ID>`
* `<YOUR_RESOURCE_GROUP_NAME>`
* `<YOUR_COMPUTE_GALLERY_NAME>`

### Step 3: Configure GitHub Secrets
To allow GitHub Actions to authenticate with your Azure environment, you need to create an Azure Service Principal and add its credentials to your repository secrets.

1. Go to your repository's **Settings** > **Secrets and variables** > **Actions**.
2. Add the following secrets:
   * `AZURE_CLIENT_ID`: Your Service Principal App ID.
   * `AZURE_CLIENT_SECRET`: Your Service Principal Password/Secret.
   * `AZURE_TENANT_ID`: Your Azure Tenant ID.
   * `AZURE_SUBSCRIPTION_ID`: Your Azure Subscription ID.

### Step 4: Trigger the Pipeline
Once your variables are set, the pipeline will automatically trigger on a push to the `main` branch. You can also trigger it manually:
1. Go to the **Actions** tab in GitHub.
2. Select the **Build Golden Images** workflow.
3. Click **Run workflow**.

## 📑 Audit & Compliance Reports
Once a GitHub Actions run completes successfully, navigate to the **Releases** section of the repository. You will find a dynamically versioned release (e.g., `v1.0.x`) containing the detailed OpenSCAP HTML evaluation reports for both the Ubuntu and RHEL images.
