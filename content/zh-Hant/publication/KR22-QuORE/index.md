---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Open Relation Extraction with Non-Existent and Multi-Span Relationships"
authors: ["Huifan Yang", "admin", "Zekun Li", "Donglin Yang", "Jinsheng Qi", "Bin Wu"]
date: 2022-02-13
doi: ""

# Schedule page publish date (NOT publication's date).
publishDate: 2022-02-13

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ["1"]

# Publication name and optional abbreviated publication name.
publication: "19th International Conference on Principles of Knowledge Representation and Reasoning, KR 2022"
publication_short: "KR 2022"

abstract: "Open relation extraction (ORE) aims to assign semantic relationships among arguments, essential to the automatic construction of knowledge graphs (KG). The previous ORE methods and some benchmark datasets consider a relation between two arguments as definitely existing and in a simple single-span form, neglecting possible non-existent relationships and flexible, expressive multi-span relations. However, detecting non-existent relations is necessary for a pipelined information extraction system (first performing named entity recognition then relation extraction), and multi-span relationships contribute to the diversity of connections in KGs. To fulfill the practical demands of ORE, we design a novel Query-based Multi-head Open Relation Extractor (QuORE) to extract single/multi-span relations and detect non-existent relationships effectively. Moreover, we re-construct some public datasets covering English and Chinese to derive augmented and multi-span relation tuples. Extensive experiment results show that our method outperforms the stateof-the-art ORE model LOREM in the extraction of existing single/multi-span relations and the overall performances on four datasets with non-existent relationships. Our code and data are publicly available."

# Summary. An optional shortened abstract.
summary: "We proposed a Query-based Multi-head Open Relation Extractor (QuORE) to extract single/multi-span relations and detect non-existent relationships effectively."

tags: []
categories: []
featured: true
draft: false

# Custom links (optional).
#   Uncomment and edit lines below to show custom links.
# links:
# - name: Follow
#   url: https://twitter.com
#   icon_pack:
#   icon: twitter

url_pdf: https://www.easychair.org/publications/preprint_open/jz3j
url_code: https://github.com/farahhuifanyang/QuORE
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
  caption: "Overview of the approach"
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
