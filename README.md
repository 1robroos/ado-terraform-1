# ado-terraform-1
Test Azure devops and terraform, test1
[![Build Status](https://dev.azure.com/1robroos/AzureDevOps_Terraform_test/_apis/build/status/1robroos.ado-terraform-1?branchName=dev)](https://dev.azure.com/1robroos/AzureDevOps_Terraform_test/_build/latest?definitionId=25&branchName=dev)

# terraform-multienv

A template for maintaining a multiple environments infrastructure with [Terraform](https://www.terraform.io/). This template includes a CI/CD process, that applies the infrastructure in an AWS account.

<table>
   <tr>
      <td>environment</td>
      <td><a href="https://github.com/unfor19/terraform-multienv/blob/dev/.drone.yml">drone.io</a></td>
      <td><a href="https://github.com/unfor19/terraform-multienv/blob/dev/.github/workflows/pipeline.yml">GitHub Actions</a></td>
      <td><a href="https://github.com/unfor19/terraform-multienv/blob/dev/.circleci/config.yml">Circle Ci</a></td>
      <td><a href="https://github.com/1robroos/ado-terraform-1/blob/dev/azure-pipelines.yml">Github</a></td>
   </tr>
   <tr>
      <td>dev</td>
      <td><a href="https://cloud.drone.io/unfor19/terraform-multienv"><img src="https://cloud.drone.io/api/badges/unfor19/terraform-multienv/status.svg?ref=refs/heads/dev" /></a></td>
      <td><a href="https://github.com/unfor19/terraform-multienv/actions?query=workflow%3Apipeline"><img src="https://github.com/unfor19/terraform-multienv/workflows/pipeline/badge.svg?branch=dev" /></a></td>
      <td><a href="https://app.circleci.com/pipelines/github/unfor19/terraform-multienv?branch=dev"><img src="https://circleci.com/gh/unfor19/terraform-multienv/tree/dev.svg?style=svg" /></a></td>
      <td><a href="[![Build Status](https://dev.azure.com/1robroos/AzureDevOps_Terraform_test/_apis/build/status/1robroos.ado-terraform-1?branchName=dev)](https://dev.azure.com/1robroos/AzureDevOps_Terraform_test/_build/latest?definitionId=25&branchName=dev)" /></a></td>    
   </tr>
   <tr>
      <td>stg</td>
      <td><a href="https://cloud.drone.io/unfor19/terraform-multienv"><img src="https://cloud.drone.io/api/badges/unfor19/terraform-multienv/status.svg?ref=refs/heads/stg" /></a></td>
      <td><a href="https://github.com/unfor19/terraform-multienv/actions?query=workflow%3Apipeline"><img src="https://github.com/unfor19/terraform-multienv/workflows/pipeline/badge.svg?branch=stg" /></a></td>    
      <td><a href="https://app.circleci.com/pipelines/github/unfor19/terraform-multienv?branch=stg"><img src="https://circleci.com/gh/unfor19/terraform-multienv/tree/stg.svg?style=svg" /></a></td>
      <td><a href="https://dev.azure.com/1robroos/AzureDevOps_Terraform_test/_apis/build/status/1robroos.ado-terraform-1?branchName=stg)](https://dev.azure.com/1robroos/AzureDevOps_Terraform_test/_build/latest?definitionId=25&branchName=stg)" /></a></td>        
   </tr>
   <tr>
      <td>prd</td>
      <td><a href="https://cloud.drone.io/unfor19/terraform-multienv"><img src="https://cloud.drone.io/api/badges/unfor19/terraform-multienv/status.svg?ref=refs/heads/prd" /></a></td>
      <td><a href="https://github.com/unfor19/terraform-multienv/actions?query=workflow%3Apipeline"><img src="https://github.com/unfor19/terraform-multienv/workflows/pipeline/badge.svg?branch=prd" /></a></td>
      <td><a href="https://app.circleci.com/pipelines/github/unfor19/terraform-multienv?branch=prd"><img src="https://circleci.com/gh/unfor19/terraform-multienv/tree/prd.svg?style=svg" /></a></td>
      <td><a href="https://travis-ci.com/github/unfor19/terraform-multienv"><img src="https://travis-ci.com/unfor19/terraform-multienv.svg?branch=prd" /></a></td>        
   </tr>
</table>