# Replication Exercise "Does Victim Gender Matter for Justice Delivery? Police and Judicial Responses to Women's Cases in India"
This repository contains the materials for our attempted replication of outcomes and code from Nirvikar Jassa "Does Victim Gender Matter for Justice Delivery? Police and Judicial Responses to Women's Cases in India", 2023

Abstract: Are women disadvantaged whilst accessing justice? I chart, for the first time, the full trajectory of accessing justice in India using an original dataset of roughly half a million crime reports, subsequently merged with court files. I demonstrate that particular complaints can be hindered when passing through nodes of the criminal justice system, and illustrate a pattern of “multi-stage” discrimination. In particular, I show that women's complaints are more likely to be delayed and dismissed at the police station and courthouse compared to men. Suspects that female complainants accuse of crime are less likely to be convicted and more likely to be acquitted, an imbalance that persists even when accounting for cases of violence against women (VAW). The application of machine learning to complaints reveals—contrary to claims by policymakers and judges—that VAW, including the extortive crime of dowry, are not “petty quarrels,” but may involve starvation, poisoning, and marital rape. In an attempt to make a causal claim about the impact of complainant gender on verdicts, I utilize topical inverse regression matching, a method that leverages high-dimensional text data. I show that those who suffer from cumulative disadvantage in society may face challenges across sequential stages of seeking restitution or punitive justice through formal state institutions.

The latest pre-print can be found [here](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/81E4CE479AECAC3CEB4024FFE273565F/S0003055423000916a.pdf/does-victim-gender-matter-for-justice-delivery-police-and-judicial-responses-to-womens-cases-in-india.pdf).

## Code

The code can be found in the xxx.qmd file. (The script reads in data from this repository as is, and no change in directory is needed.)

## Codes

code_graph_theory.r: this code replicates the figure 1a of the paper.

analysis_discontinuity.r: this code replicates the discontinuity analysis for the case of Brazil. The code for other countries are equivalent, but with different data sources and ids for the communities.

## Data

The code uses the bigrame.Rdata file (quantitative data on speeches) found in the same directory, as well as the raw speech data (the code access speech CSVs in a folder titled "speeches_by_parliament"), which should be placed in the same directory in the folder with the same name. The raw speeches data was too large to push to this repository, and can be found at this link: https://andy.egge.rs/eggers_spirling_database.html

## Report

Our report on our replication and additions can be found in the "Report" folder. The document details our methods, results, differences and similarties, an autopsy of our results, and possible extensions for the original paper.

## Other resources

The "Original Paper" folder contains the full article by Spirling, as well as the author's replication code and materials. The Harvard Dataverse page for this paper can be found here: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/EZBYBZ
The "Presentation" folder contains a PDF of our presentation, which was created using Overleaf
