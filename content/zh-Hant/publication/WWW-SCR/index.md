---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Similar Cases Recommendation via Legal Knowledge Graph Construction and Representation"
authors: ["Nian-Tao Xie", "Sheng-Guang Wang", "admin", "Jing-Lin Zhao", "Su-Jian Li"]
date: 2019-10-14
doi: ""
# ACM DOI 10.1145/1122445.1122456

# Schedule page publish date (NOT publication's date).
publishDate: 2020-01-10

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ["3"]

# Publication name and optional abbreviated publication name.
publication: "Similar Cases Recommendation via Legal Knowledge Graph Construction and Representation"
publication_short: "SCR"

abstract: "Similar cases recommendation in the legal domain aims to find out relevant cases from a large number of judgment documents for a given indictment and can aid in enhancing the efficiency of judges in the trial process. Previous methods mainly focus on exploring the information which can be directly captured from each separate document and lack of incorporating external rules or knowledge which summarizes empirically from the whole domain. Thus, in this paper, we present a novel paradigm of recommend- ing similar legal cases based on our constructed knowledge graph. First, we put forward the joint model based on BERT to con- struct our knowledge graph by extracting entities and relations, with nodes representing entities and edges representing relations. The joint model learns the domain-related paradigm through shar- ing loss functions of sub-models to enhance the generalization effect. Second, with such a knowledge graph, we design the Trans- former based TransKB method to convert each document into one low-dimensional continuous vector which can care for the information from all the documents of the domain. Last, we em- ploy the similarity computation method to retrieve all the vectors reserved in our database for recommending the most similar cases. We verify our method in the Motor Vehicle Accident Liability Disputes in the Chinese civil law and construct its knowledge graph by defining 20 entity types and 9 relation types. We achieve state-of- the-art results in terms of MR, MRR, Hit@10 and human judgments, showing the pragmatic application of our method."

# Summary. An optional shortened abstract.
summary: "We develop a similar lawsuit case recommender using triple extration to form the knowledge graph, and use our TransKB model to get the knowledge embeddings and finally use them for similarity calculation"

tags: []
categories: []
featured: false
draft: true

# Custom links (optional).
#   Uncomment and edit lines below to show custom links.
# links:
# - name: Follow
#   url: https://twitter.com
#   icon_pack: fab
#   icon: twitter

url_pdf:
url_code:
url_dataset:
url_poster:
url_project:
url_slides:
url_source:
url_video:

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Associated Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `internal-project` references `content/project/internal-project/index.md`.
#   Otherwise, set `projects: []`.
projects: []

# Slides (optional).
#   Associate this publication with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides: "example"` references `content/slides/example/index.md`.
#   Otherwise, set `slides: ""`.
slides: ""
---
