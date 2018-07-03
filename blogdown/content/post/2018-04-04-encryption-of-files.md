+++
title = "Getting started with encryption of documents"
description = "to share data securely."
author = "Sina Rüeger"
date = 2018-04-13T20:40:59+02:00
tags = ["encryption","best practices","workflow"]
category = ["workflow"]
draft = false
+++

I work (broadly speaking) in epidemiology. Within collaborations we often have to share **sensitive data** across institutions and are therefore likely to not share IT facilities. But the most often used options - bare e-mail or file hosting - are not secure, as they both work via a server that could potentially be exposed. 

There are a handful of secure options around ([ProtonMail](https://protonmail.com/) or [keybase.io](https://keybase.io/), both working via [encryption](https://www.quora.com/Why-is-encryption-important)), but for those that **trust open source projects** the most and are familiar with a **terminal** I have written some basic instructions for asymmetric GPG encryption.  

*I should say that I am not an encryption expert at all. But, although there is a lot of talk about data protection, I never came across a compact, easy-to-follow instruction for the sender of the document and the recipient, valid for all three operating systems (Linux, Mac, Windows). Therefore, I tried to write one, mainly for myself and collaborators. Feedback is appreciated!*

{{< gist sinarueeger aadfe4916cf285e32d5a55f320a82a6f "encryption_files.md" >}}

