# Home Infrastructure

This is a repo containing all the core pieces of my infrastructure, plus scripts to help easily deploy them. All sections are managed using either Helm or Terraform.

## Sections

### helm_deployments

Major applications & components of my Kubernetes cluster all configured as Helm Charts. Can be deployed with their run scripts:

```bash
./helm_deployments/{deployment name}/run.sh {dev or prod} {helm command}
```

### helm_library

These are library charts for Helm. Right now it's mostly just my app_deployment chart, the template for all of my applications. Please see `./helm_library/app_deployment/valuesExample.yml` for information on how to configure consuming projects. To publish the chart, use this command:

```bash
./helm_library/{library name}/run.sh {dev or prod}
```

### terraform_config

This is where deployed applications are configured via Terraform. Applications configured here should only be changed via Terraform to keep them properly in sync. Right now it's only nexus. To run these configurations, use:

```bash
./terraform_config/{library name}/run.sh {dev or prod} {terraform command}
```