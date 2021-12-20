# Instana Agent Log4Shell scripts

For more information about Instana and the Apache Log4j CVE-2021-44228 please visit our [official incident documentation](https://status.instana.io/incidents/4zgcd2gzf4jw).

## Scan Instana for unpatched Agents

### Prerequisites

* Prepare your tenant unit name: From the URL of your Instana instance pick the firt element before `instana.io`. For our QA instance this is `qa-instana` from the URL `https://qa-instana.instana.io`.
* Set up an API token as described in our documentation [here](https://www.instana.com/docs/api/web).

### Run the script

Clone this repository and run the script as follows:

```shell
API_TOKEN="<your-token-here>" TENANT_UNIT="<your-tenant-unit-here>" ./log4shell-instana-agents.sh
```

In case your Instana installation runs in a host different than `instana.io` please also put the environemnt variable `INSTANA_HOST` as follows:

```shell
API_TOKEN="<your-token-here>" TENANT_UNIT="<your-tenant-unit-here>" INSTANA_HOST="<your-host-here>" ./log4shell-instana-agents.sh
```

Full example:

```shell
API_TOKEN="abc42" TENANT_UNIT="qa-instana" INSTANA_HOST="instana.io" ./log4shell-instana-agents.sh
```

### Output

The script reports any Instana agent which is not yet patched for the Log4Shell security vulnerability. The output will be in the form

```json
{
  "snapshotId": "TArxPb6x9n5klFFNCJ9jN5GKIyQ",
  "hostname": "gke-my-cluster-node-7a41ge9f-hwbd"
}
```