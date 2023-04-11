# Terraform config for Website Factory

Create a new service account to be used in Terraform Cloud from here: https://console.cloud.google.com/iam-admin/serviceaccounts.  
Required roles for the service account:

- Editor
- Project IAM Admin
- Secret Manager Admin
- Compute Network Admin

Generate and download the JSON keys and then use them as a GOOGLE_CREDENTIALS env variable in Terraform Cloud

Make sure to verify the ownership of the domain here: https://search.google.com/search-console/welcome
Add the service account email generated above as the owner user in the search console.

---

Every client (user that want a website-factory deployed) will have a Terraform Cloud workspace connected to this repository. Variables are defined inside Terraform Cloud for each workspace. Push to main branch will result in a new deploy to stage env (on code4ro infra). Push to production branch will result in a new deploy to every client that have a workspace in Terraform Cloud. So with one push to production we can deploy the changes to all clients simultaneously.

## Add a new client

Create a new workspace in Terraform Cloud and connect to this github repo with VCS branch set to _production_. Add the necessary variables in Terraform Cloud. You can check on the other workspaces for what variables needs to be defined. Finally push to _production_ or manually execute a new plan to deploy the infrastructure.

## Deploy to stage

Create a new MR in _main_ branch in order to execute a new plan on Terraform Cloud. If everything looks good on the plan, merge the MR in main in order to apply the changes to the stage environment.

## Deploy to production

Create a new MR from _main_ to _production_ branch in order to execute a new plan on Terraform Cloud. If everything looks good on the plan, merge the MR in production in order to apply the changes to the production environment.
