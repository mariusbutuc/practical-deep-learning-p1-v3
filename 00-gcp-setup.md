# Welcome to GCP!

> This guide explains how to set up Google Cloud Platform (GCP) to use PyTorch 1.0.0 and fastai 1.0.2. At the end of this tutorial you will be able to use both in a GPU-enabled Jupyter Notebook environment.

In my case, I'm setting everything up on a macOS machine and yes, YMMV.

## Pricing

I'm going for the _Standard Compute_ setup, as opposed to the _Budget Compute_:
* Using [preemptible] instances for better economy. The prices below reflect that.
* GCP charges separately for the base CPU platform, and the GPU.
    * CPU: `n1-highmem-8` = $0.12/hour
    * GPU: `nvidia-tesla-p4` = $0.26/hour
    * Disk: `200GB` = $9.60/month

## Create account

Follow the steps in the course guide. 

## Python 2.7

> Make sure that Python 2.7 is installed on your system.

…it already ships with macOS.

## Google Cloud SDK

I initially installed `gcloud` using the instructions in the course guide, but was not happy with where it ended up being installed.

[Uninstalled gcloud], then used homebrew cask to install it again, and updated `~/.bash_profile` to match the new locations. The Cask package is well contained, and its `info` contains most of the relevant information:

```sh
$ brew cask info google-cloud-sdk
google-cloud-sdk: latest
https://cloud.google.com/sdk/
/usr/local/Caskroom/google-cloud-sdk/latest (18,603 files, 248.8MB)
From: https://github.com/Homebrew/homebrew-cask/blob/master/Casks/google-cloud-sdk.rb
==> Name
Google Cloud SDK
==> Artifacts
google-cloud-sdk/install.sh (Installer)
google-cloud-sdk/bin/bq (Binary)
google-cloud-sdk/bin/docker-credential-gcloud (Binary)
google-cloud-sdk/bin/gcloud (Binary)
google-cloud-sdk/bin/git-credential-gcloud.sh (Binary)
google-cloud-sdk/bin/gsutil (Binary)
==> Caveats
google-cloud-sdk is installed at /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk. Add your profile:

  for bash users
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc'
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc'

  for zsh users
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
```

### `gcloud init`

After authentication, there are a few details I needed to get through on the first run:

> Pick cloud project to use:  
>  [1] api-project-847148158142  
>  [2] practical-deep-learning-v3  
>  [3] Create a new project

Pick the one that billing was enabled for from the beginning; picking a meaningful name _and_ ID might be a good idea.

As mentioned in the beginning, I'm going for the _Standard Compute_ setup. The `us-west-2` region is one that has `nvidia-tesla-p4` GPUs, but I couldn't find it when selecting the zone to be used as as project default. The key is in the last lines of the output:

> Which Google Compute Engine zone would you like to use as project default?
>
> …snip…  
> [50] northamerica-northeast1-a  
> Did not print [6] options.  
> Too many options [56]. Enter "list" at prompt to print choices fully.

Type `list` and indeed, `us-west2-b` is now visible:

> [54] us-west2-b

For a small shell script to store these details in and to provide a quick place to change them and allow all commands to be ran at once, check out [scripts/gcloud.init.sh].

## Create an instance

[scripts/create_instance.sh] 

To get around the `GPUS_ALL_REGIONS` quota exceeded error I had to upgrade my account from trial to paid.

> Quota GPUS_ALL_REGIONS exceeded. Limit: 0.0 globally.

* [img/gcloud-GPUS_ALL_REGIONS-global-quota-0-cli.png]
* [img/gcloud-GPUS_ALL_REGIONS-global-quota-0-web.png]

One way to aceess your quotas form the CLI is to use the 

```sh
$ gcloud compute project-info describe --project practical-deep-learning-v3
```

and look for the `GPUS_ALL_REGIONS` metric. After upgrading to the paid account and as my instance is currently turned off, the output displays

```sh
# …snip…
- limit: 1.0
  metric: GPUS_ALL_REGIONS
  usage: 0.0
```

## Quick instance "management"

Start the instance:

```sh
$ gcloud compute instances start fastai-instance
```

Stop the instance:

```sh
$ gcloud compute instances stop fastai-instance
```

To confirm the status of the instance, I currently prefer:

```sh
$ gcloud compute instances list --filter="name=fastai-instance"
NAME             ZONE        MACHINE_TYPE  PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP  STATUS
fastai-instance  us-west2-b  n1-highmem-8  true         XX.XXX.X.X                TERMINATED
```

Connect to the instance:

```sh
gcloud compute ssh jupyter@fastai-instance -- -L 8080:localhost:8080
```

Update the course repo

```sh
cd tutorials/fastai/course-v3
git pull
```

Update the fastai library on the instance

```sh
sudo /opt/anaconda3/bin/conda install -c fastai fastai -y
```


  [uninstalled gcloud]: https://cloud.google.com/sdk/docs/uninstall-cloud-sdk
  [preemptible]: https://cloud.google.com/compute/docs/instances/preemptible
  
