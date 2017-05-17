---
title: "README.md"
author: "Ashley Kelly"
date: "May 16, 2017"
output: html_document
---


## Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

First, if the dataset does not already exist in the working directory it will be downloaded. <br />
Load the training, testing, activity and feature info. <br />
Reformat the dataset to keep only those columns which reflect a mean or standard deviation. <br />
Loads the activity and subject data for each dataset, and merges those columns with the dataset. <br />
Converts the activity and subject columns into factors. <br />
Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair. <br />
Creates and assigns descriptive column names. <br />
The end result is output into the data directory. <br />
