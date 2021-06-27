+++
# Experience widget.
widget = "experience"  # See https://sourcethemes.com/academic/docs/page-builder/
headless = true  # This file represents a page section.
active = true  # Activate this widget? true/false
weight = 40  # Order that this section will appear.

title = "Experience"
subtitle = "Job / Intern"

# Date format for experience
#   Refer to https://sourcethemes.com/academic/docs/customization/#date-format
date_format = "Jan 2006"

# Experiences.
#   Add/remove as many `[[experience]]` blocks below as you like.
#   Required fields are `title`, `company`, and `date_start`.
#   Leave `date_end` empty if it's your current employer.
#   Begin/end multi-line descriptions with 3 quotes `"""`.
[[experience]]
  title = "Bing Multimedia Software Engineer"
  company = "Microsoft Software Technology Center Asia"
  company_url = "https://www.microsoft.com/en-us/ard/aboutus/teams.aspx"
  location = "Suzhou, China"
  date_start = "2021-07-19"
  date_end = ""
  description = """
  Going to do Recommender System related topics.
  """

[[experience]]
  title = "Bing NLP Carina Algorithm Intern"
  company = "Microsoft Software Technology Center Asia"
  company_url = "https://www.microsoft.com/en-us/ard/aboutus/teams.aspx"
  location = "Beijing, China"
  date_start = "2020-07-20"
  date_end = "2021-06-18"
  description = """
  Worked on Writing Assistant related projects in two main parts:
  
  * **AI Writer**: An application which aims to increase diversity of an article as well as reduces efforts of writing "filling text" for human. (This was the project used for the intern conversion)

    * Continuous Writing: 

      * GPT2

    * Rewriting:

      * Paraphrasing

          * UniLM ([SimBERT](https://github.com/ZhuiyiTechnology/simbert))

      * Back-translation

          * Bing Translator
          * Google Translation

      * Information-Retrieval-based

          * Elastic Search
          * Approximate Nearest Neighbor ([annoy](https://github.com/spotify/annoy))

      * Style Transfer

          * Style Transformer

  * **Value Understanding**: Built a numerical extractor which can extract *quantity fact* from raw text.

    * Designed an annotation guideline especially for Chinese quantity extraction.
    * Communication with labeling company and annotate more than 2000 article data to construct the training dataset from scratch.
    * Designed two major approaches namely "NER Combine" and "Quantity MRC".

      * NER Combine: Combine spans with label extracted from NER model with an scope-based rule-based algorithm
      * Quantity MRC: Construct query for each slots based on extracted Quantity

    * Post-processing modules that able to deal with complex sentences especially the "respectively cases".
    * Got used as back-end of three different projects

      * Writing Assistant (mainly finance): Including value consistency and value recommendation
      * Medical thesis analyser
      * A WeChat mini program
  
  <br>Interviewed 5 internship candidates (after getting the return offer).
  """

[[experience]]
  title = "Knowledge Computing Research Intern"
  company = "Microsoft Research Asia"
  company_url = "https://www.msra.cn/"
  location = "Beijing, China"
  date_start = "2019-12-10"
  date_end = "2020-05-29"
  description = """
  Take over mainly two research-oriented NLP projects.

  * Generation of slides from academic paper
  * Math word problem generation
  """

[[experience]]
  title = "Research Intern (Laboratory)"
  company = "Peking University National Engineering Research Center of Software Engineering"
  company_url = "https://se.pku.edu.cn/"
  location = "Beijing, China"
  date_start = "2019-07-01"
  date_end = "2021-06-30"
  description = """
  Doing case of Anti-healthcare fraud and Medical record analysis.

  Including research of:
  
  * Information Extraction
  * Named-entity Recognition
  * Relation Classification
  * Knowledge Graph

  > PKU Thesis: Design and Implementation of Chinese Document Numerical Fact Extraction
  """

[[experience]]
  title = "Embedding System Design Software Intern"
  company = "Industrial Technology Research Institute (ITRI)"
  company_url = "https://www.itri.org.tw"
  location = "Hsinchu, Taiwan"
  date_start = "2016-07-01"
  date_end = "2016-08-31"
  description = """
  I was in the self-driving group, I mainly handled the STV0991 development board which was going to carry the computer vision algorithms.
  """

+++
