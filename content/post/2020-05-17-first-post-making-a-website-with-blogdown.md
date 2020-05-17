---
title: 'First post: Making a website with blogdown'
author: ~
date: '2020-05-17'
slug: first-post-making-a-website-with-blogdown
categories: []
tags: []
---

# Introduction

This is the first blog post on my own website. I've decided to make this website using the R package `blogdown`. The website looks very nice now (in my humble opinion), but it was tedious to make. When attempting to create the website, I first tried out a couple of themes before I settled on the basic "lithium" theme, because it was by far the easiest theme to wrap your head around. I want to summarize some difficulties I experienced while making the website, thereby (possibly) helping people who run into the same or similar problems. 

# Good things

First of all, I think it pays to go over the good things of `blogdown`. You can literally create a site in seconds, by executing:

```{r}
install.packages('blogdown')

library(blogdown)

# If you haven't done so yet:
blogdown::install_hugo()

blogdown::new_site(theme = "githubrepo/theme") 
# It will pick this 'lithium' theme as the default.
```

Then you can start filling out some information in the `config.toml` file, which is very intuitive, you can create some posts by executing `blogdown::new_post()` and your blog is up and running (albeit off-line :) ). So far the easy part: picking a theme is the first tedious aspect. 

# Picking A Theme

# Changing your favicon

# The logic of Go/Hugo

# Arranging the site and blog