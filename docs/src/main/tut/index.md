---
layout: docs
title:  "ML Lambda"
permalink: 'index.html'
---

## What is ML Lambda? 

__ML Lambda__ is an open source model management cluster for deploying, serving and monitoring machine learning models and ad-hoc algorithms. It enables you to get your models up and running in an instant on just about any infrastructure and using any of the available machine learning toolkits. It lets you monitor your models' performance, analyse their inputs (for example, determine whether there is recently an increased number of outliers or not), observe models' inference on given data and many more. 


* [Getting Started]({{site.baseurl}}{%link getting-started.md%}) page will help you to quickly set up and deploy your first model with __ML Lambda__.
* [Models]({{site.baseurl}}{%link models.md%}) page will explain you the main [principles]({{site.baseurl}}{%link models.md%}#principles) of working with your models and show you how to upload [TensorFlow]({{site.baseurl}}{%link models.md%}#tensorflow), [Keras]({{site.baseurl}}{%link models.md%}#keras), [Spark]({{site.baseurl}}{%link models.md%}#spark) or any other arbitrary model within [Python]({{site.baseurl}}{%link models.md%}#python) runtime. 
* All models run on top of [Runtimes]({{site.baseurl}}{%link runtimes.md%}). If you can't find a desired runtime for your purposes, you can [develop]({{site.baseurl}}{%link runtimes.md%}#developing-runtime) your own runtime for any language via RPC service.