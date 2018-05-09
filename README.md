# Deploying an ASP.NET Core web app to AWS Linux VM and SQL Server for Linux - Will it Deploy? Episode 7

Welcome to another **Will it Deploy?** episode where we try to automate the deployment of different technologies with Octopus Deploy. In this episode, we're trying to deploy an ASP.NET Core 2.0 web app to an Amazon Web Services (AWS) Ubuntu Virtual Machine (VM) with SQL Server for Linux. We also explore setting up a cloud-based delivery pipeline with [AppVeyor](https://appveyor.com) and [Octopus](https://octopus.com/cloud).

[![Deploying an ASP.NET Core app to Linux - Will it Deploy? Episode 7](images/will-it-deploy.png)](https://youtu.be/KhKnb58xOWk "Deploying an ASP.NET Core app to Linux - Will it Deploy? Episode 7")

NOTE: [Octopus Cloud](https://octopus.com/cloud) is coming soon! Register your interest and stay up to date with our cloud-based solution.

## Problem

### Tech Stack

Our app is a random quote generator web app called [Random Quotes](https://github.com/OctopusSamples/WillItDeploy-Episode007). This is fairly simple, but it'll allow us to walk through how to automate the deployment of an ASP.NET Core web application with a database to an Ubuntu Linux VM and SQL Server for Linux running in AWS.

* Microsoft [ASP.NET Core 2.0](https://docs.microsoft.com/en-us/aspnet/core/) web app.
* [Entity Framework Core 2.0](https://docs.microsoft.com/en-us/ef/core/) framework.
* Build with [AppVeyor](https://appveyor.com).
* Deploy with [Octopus](https://octopus.com/cloud).

Kudos to our marketing manager [Andrew](https://twitter.com/andrewmaherbne) who has been learning to code and built the first cut of this app. Nice job!

### Deployment Target

![Amazon web services logo](images/aws-logo.png "width=200")

* [AWS EC2 Ubuntu](https://aws.amazon.com/marketplace/search/results?x=0&y=0&searchTerms=Ubuntu+Sql+Server+Linux) virtual machine.
* Microsoft [SQL Server 2017 for Linux](https://www.microsoft.com/en-au/sql-server/) database

## Solution

So will it deploy? **Yes it will!**

Our cloud-based delivery pipeline looks like the following:

![GitHub, AppVeyor and Octopus delivery pipeline](images/cloud-pipeline.png "width=750")

We're committing our source code to [GitHub](https://github.com/OctopusSamples/WillItDeploy-Episode007), building our app automatically with [AppVeyor](https://appveyor.com), and deploying to an [AWS Ubuntu VM](https://aws.amazon.com/marketplace/search/results?x=0&y=0&searchTerms=Ubuntu+Sql+Server+Linux) with [Octopus](https://octopus.com/cloud).

It's quick and easy to integrate AppVeyor with Octopus. We're using a custom build script to build and package our application and we configure the 'Octopus Deploy' deployment provider to deploy it.

![AppVeyor build settings](images/appveyor-package-webapp.png "width=500")

![AppVeyor deployment provider settings](images/appveyor-deployment-provider.png "width=500")

Our deployment process looks like the following:

![Octopus deployment process](images/deployment-process.png "width=500")

- Octopus **Deploy a Package** step to acquire/unzip our database scripts on the Octopus Server.
- Octopus Community Contributed step template -  **[SQL - Execute Script File](https://library.octopusdeploy.com/step-template/actiontemplate-sql-execute-script-file)** to execute our Entity Framework Core migration script agaist our SQL Server database. 
- Octopus **Deploy a Package** step to deploy our ASP.NET Core web application to our Ubuntu Linux VM and configure it appropriately.

This project uses the following variables to store our app settings and database connection details.

![Project variables](images/project-variables.png "width=500")