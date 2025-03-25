# Replication Exercise "Does Victim Gender Matter for Justice Delivery? Police and Judicial Responses to Women's Cases in India"
This repository contains the materials for our attempted replication of outcomes and code from Nirvikar Jassa "Does Victim Gender Matter for Justice Delivery? Police and Judicial Responses to Women's Cases in India", 2023

Abstract: Are women disadvantaged whilst accessing justice? I chart, for the first time, the full trajectory of accessing justice in India using an original dataset of roughly half a million crime reports, subsequently merged with court files. I demonstrate that particular complaints can be hindered when passing through nodes of the criminal justice system, and illustrate a pattern of “multi-stage” discrimination. In particular, I show that women's complaints are more likely to be delayed and dismissed at the police station and courthouse compared to men. Suspects that female complainants accuse of crime are less likely to be convicted and more likely to be acquitted, an imbalance that persists even when accounting for cases of violence against women (VAW). The application of machine learning to complaints reveals—contrary to claims by policymakers and judges—that VAW, including the extortive crime of dowry, are not “petty quarrels,” but may involve starvation, poisoning, and marital rape. In an attempt to make a causal claim about the impact of complainant gender on verdicts, I utilize topical inverse regression matching, a method that leverages high-dimensional text data. I show that those who suffer from cumulative disadvantage in society may face challenges across sequential stages of seeking restitution or punitive justice through formal state institutions.

The paper can be found [here](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/81E4CE479AECAC3CEB4024FFE273565F/S0003055423000916a.pdf/does-victim-gender-matter-for-justice-delivery-police-and-judicial-responses-to-womens-cases-in-india.pdf).

## Code

The code is located in the `replication.qmd` file. Ensure that the data is placed in the same working directory as the code, or adjust the working directory accordingly within the script to ensure it runs properly.

## Data

The code utilizes a corpus of police reports, which you can download [here](https://georgetown.box.com/s/q2bj0g830oyg9dlp69optsve2zh37z5j). Due to the file's large size, it cannot be uploaded to the repository. We recommend cloning the repository and downloading the dataset separately, then placing it in the appropriate folder to ensure the code runs smoothly.

## Report

Our report on our replication and additions can be found in the "Report" folder. The document details our methods, results, differences and similarties, an autopsy of our results, and possible extensions for the original paper.

## Presentation

Our replication exercise presentation is available in the "Presentation" folder, which contains a PDF of the slides.
