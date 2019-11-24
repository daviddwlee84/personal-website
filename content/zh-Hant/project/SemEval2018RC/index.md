---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "SemEval-2018 Relation Classification"
summary: "SemEval-2018 Task 7 Semantic Relation Extraction and Classification in Scientific Papers."
authors: ["admin", "姜慧強"]
tags: ["School Project", "ML DL", "NLP"]
categories: []
date: 2019-04-09

# Optional external URL for project (replaces project detail page).
external_link: ""

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: "Smart"
  preview_only: false

# Custom links (optional).
#   Uncomment and edit lines below to show custom links.
# links:
# - name: Follow
#   url: https://twitter.com
#   icon_pack: fab
#   icon: twitter

url_code: "https://github.com/pku-nlp-forfun/SemEval-2018-RelationClassification"
url_pdf: "https://github.com/pku-nlp-forfun/SemEval2018-Task7-Paper/blob/master/main.pdf"
url_slides: ""
url_video: ""

# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
slides: ""
---

> 本次任務是當時碩一下學期選修的一門信科的課，名叫自然語言高級專題。那時我在北大軟微大興校區，每週三通勤一個多小時到北大本部燕園校區。而學校的規定是，只有修軟微自己開的課才算學分，但我和幾個同學仍然還是決定選修而只是旁聽，來督促自己學習吧，後來這群好友目前已經有三人在 MSRA 中了。此外，也藉由這堂課的機會，順便練習一下 LaTeX 的論文寫作，讓報告看起來有模有樣一點。

這次 SemEval-2018 Task 7 任務的主題是 [Semantic Relation Extraction and Classification in Scientific Papers](https://competitions.codalab.org/competitions/17422)。在 dataset 中共定義了六種類別，分別是 USAGE、RESULT、MODEL、PART_WHOLE、TOPIC、COMPARISON，其中除了 COMPARISON 是 symmetrical relation 之外，其餘的 relation 皆是 asymmetrical relation。

其中，我們針對的 Subtask 1 - Relation classification 又分為 Task 1.1 Relation classification on clean data 和 Task 1.2 Relation classification on noisy data。於是我們提出了一個 Fusion End-to-end Method 和基於 Feature Engineering 的方法。

以 Relation Classificaiton 來說，我們最關注的其實就是如何將兩個 entities 之間的句子進行 contextual representation 進而利用解析出來的句子語意來判別 relation。當時最一開始其實還不是很懂，想了一個最 naive 的想法，就是將每種關係用一些 phrases 來表示，比方說 USAGE 其實可以替換成英文的 used by、used for、applied to、performed on，因此我們的想法是去利用這些 phrases 來替換連接兩個 entities 並且去看誰預測的機率最高。然而這顯然是有點問題的（以現在寫這篇文章的時間點回頭看），因為這樣做其實忽略了句子的信息，加上那些 relation 其實並不是可以很單純的被這些 phrases 的這種組合的 embedding 就能夠表示。後來看了 LightRel 才也認識到了在 NLP 中基本上非常基本的句子 padding（為了使 feature 的維度保持一致），以及如何使用句子的 representation 來進行分類（即後來使用的 TextCNN）。然而在本次實驗中我們只考慮了 entities 「中間」的句子（直接把所有 word embedding 拼接之後丟進 statistics machine learning model），此外我們嘗試了四種不同的 `[PAD]` 擺放的位置，分別是在 entity1 之前或之後以及在 entity2 之前或之後。後來在 TextCNN 的為 baseline 的測試中發現，padding before entity2 的效果在 Task 1.1 與 Tesk 1.2 的 test set 中的 Macro-F1 與 Micro-F1 score 表現都是最好的。

而在 LightRel 中定義了一些特徵稱為 word-shape features。儘管在我們後來的實驗中發現使用這些特徵只會使我們的 performance 下降。但還是值得拿出來討論，比方說如果第一個字的結尾是 `'s` 的話，那我們合理可以知道他可能代表某種 belonging 的 relation。具體 LightRel 使用的特徵如下：

* any character is capitalized
* a comma is present
* the first character is capitalized and the word is the first in the relation
* the first character is lower-case
* there is an underscore present (representing a multi-word entity
* if quotes are present in the token)

我們最主要下功夫的點在於 embedding 的製作上，這也是我們模型最大提升的地方。由於 SemEval 的 dataset 的文字數量遠遠小於可以訓練出一個良好 embedding 的需求。因此首先我們要決定我們額外的 corpus，其次是要用什麼樣的工具來構建 word vectors。我們發現了 Citation Network Dataset，該 dataset 提供了很多近年的 scientific paper。我們在裡面找到了 DBLP v10 和 ACM v9 並擷取其中的 Abstract 文字部分（LightRel 使用的是 DBLP v5 與 ACM v9 的融合）。在這其中我們試過了 Google 的 word2vec 和 Facebook 的 fastText 以及當時很新的 BERT。我們構建了300維的 word vector 並且忽略了出現頻率小於 5 次的字，其中為了處理 out-of-vocabulary 的問題，我們對於 `[UNK]` token 取了所有 embedding 的平均來代表。但當時我們的 BERT fine-tune 並沒有調得很好，而最終在比較後 fastText 表現優於其他兩者。

LightRel 的模型部分其實很簡單，就只是一個 Logistic Regression model。但由於他的原始碼採用的是 LibLinear 這個 library，而這個 package 在做 k-fold cross-validation 的時候會弄得非常複雜。因此我們用 Scikit Learn 重寫了一下，並且測試了 LinearSVC、LogisticRegression 和 DecisionTreeClassifier，但最後還是發現 LogisticRegression 的表現最好。我們也試過 LightGBM 但表現十分不理想，我們認為這是因為我們 feature dimension 太高，且這種 word embedding 的 feature 其實並不利於這種 tree-based algorithm。最後我們嘗試用 TextCNN 來建模（filter size = [6, 7, 8]），發現 performance 明顯比先前實驗中的 statistics machine learning model 還要好，因此其他實驗分析（比方測試 padding 位置以及嘗試解決 data imbalance時）我們皆以 TextCNN 為 baseline 。

實驗分析中我們發現了 Task 1.1 雖然說是 clean data 而 Task 1.2 是 noisy data，但 Task 1.1 在榜單上的模型幾乎分數都小於同模型在 Task 1.2 上跑的成績。我們發現這是因為 Task 1.1 的樣本數量極度不平衡，特別是在 TOPIC 這個類別上，總共 1228 個 training sample 中只有 18 個是屬於這個類別。於是我們嘗試從 Task 1.2 中的數據提取一些來進行擴充以輔助 Task 1.1 的訓練，我們試過將 Task 1.2 的 TOPIC 類別的 training sample 單獨加入、前者再加入 test sample 的 TOPIC、再加入整個 Task 1.2 training set、再加入整個 Task 1.2 test set，最終發現並不是越多 data 效果就一定越好，我們發現最好的效果是加入整個 Task 1.2 的 data。

最終我們在 Task 1.1 上取得 67.74% F1 score 並在 Task 1.2 上取得 77.35% 顯著超越我們所參考的 LightRel 模型的 39.9% 與 68.2%。
