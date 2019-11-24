---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "SemEval-2013 Word Sense Induction"
summary: "SemEval-2013 Task 13 Word Sense Induction for Graded and Non-Graded Senses."
authors: ["admin", "姜慧強"]
tags: ["School Project", "ML DL", "NLP"]
categories: []
date: 2019-05-29

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

url_code: "https://github.com/pku-nlp-forfun/SemEval2013-WordSenseInduction"
url_pdf: "https://github.com/pku-nlp-forfun/SemEval2013-Task13-Paper/blob/master/main.pdf"
url_slides: ""
url_video: ""

# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
slides: ""

markup: mmark
math: true
---

繼前一次自然語言高級專題的課堂 project SemEval-2018 Relation Classification，這次任務主題是 [SemEval-2013 Task 13 Word Sense Induction for Graded and Non-Graded Senses](https://www.cs.york.ac.uk/semeval-2013/task13.html)。事後來看，這次題目的主題是為了來看，現在當前的這種 word embedding 技術能夠對於這種 word sence induction 的提升有多少。該比賽 data 的釋出年份是 2013 年，當時 word2vec 也才剛被提出，後續接踵而至 2014 年的 [GloVe](https://nlp.stanford.edu/pubs/glove.pdf)、2015 年的 [fastText](https://fasttext.cc/) 到 2018 年的 [ELMo](https://allennlp.org/elmo)，此時再回頭來看這個任務，確實這些新提出的 representation learning 方法對於 NLP 文次或語意上理解有巨大的提升。

Word Sense Induction（WSI）算是一個很經典的 NLP 任務，同一個字可能在解釋上包含多種字意，特別是當出現在不同句子當中時，不同的上下文甚至可能直接決定了該字的意思。過往傳統在 WSI 上的研究可能像是基於 context vector 或是 LDA、BiLM 等。本次任務有三個 Subtask 分別是 Non-graded Word Sense Iduction、Graded Word Sense Induction、Lexical Substitution，而我們本次關注的重點是 Subtask 2 的 Graded WSI。所謂 graded 的意思是指對於每個我們預測出來的字義我們會給予一定的權重來代表此字義「多能代表」該字。例如有可能在句子中兩種解釋都說得通，但是其中一個解釋更合理，我們兩種解釋都會列出來，但是給予前者較高的權重。dataset 給予了 50 種不同的 verbs 跟 nouns，

該任務給出了五種 evaluation metrics，主要分為兩大類，第一大類是針對 Unsupervised Word Sense Disambiguation（WSD），其中包含了 Jaccard Index、Positionally-Weighted Kendall's $\tau$、Weighted NDCG；第二大類則是針對 Word Sense Induction（WSI）的 Clustering Comparison，其中包含了 Fuzzy NMI（Normalized Mutual Information）跟 Fuzzy B-Cubed。然而因為我們本次選擇針對 WSI 的關係，因此我們以 Fuzzy NMI（Normalized Mutual Information）、Fuzzy B-Cubed 跟這兩者的 geometric mean 做為我們的評價指標。

> * Unsupervised Word Sense Disambiguation (WSD)
>   * Jaccard Index
>     * Their ability to detect which sense are applicable
>   * Positionally-Weighted Kendall's $\tau$
>     * Their ability to rank the applicable sense according to the level of applicability
>   * Weighted NDCG (Normalized Discounted Cumulative Gain)
>     * Their ability to quantify the level of applicability for each sense
> * Word Sense Induction (WSI)
>   * Fuzzy Normalized Mutual Information (NMI)
>     * computing Normalized Mutual Information between overlapping clusters
>     * captures the alignment of the two clusterings independent of the cluster sizes (therefore serves as an effective measure of the ability of an approach to accurately model rare senses)
>   * Fuzzy B-Cubed
>     * provides an item-based evaluation that is sensitive to the cluster size skew and effectively captures the expected performance of the system on a dataset where the cluster (i.e., sense) distribution would be equivalent.

比較特別的是，在這個 Subtask 中給予了兩種不同的預測方式，第一種是字義與 WordNet 的字義的匹配，另一種是各 sample 的 instance 之間的 clustering。針對這兩者我們做了兩個模型，第一個是 TopN，第二個是 BiLM。

### TopN

在 TopN 中其實想法很簡單，就是對於每個字我們都預測 $N$ 個 word sense。具體來說，我們對於每個字所在的句子擷取其 representation 後與 WordNet 的字義解釋的 representation 做 similarity 計算。這中間牽涉到幾個比較關鍵性的東西，首先與 SemEval 2018 一樣，如何選擇一個好的 word embedding，再來是如何構建 sentence embedding，接著是如何計算兩個句子的相似度，以及最終我們要用多大的 $N$ 選出多少結果。具體步驟如下：

1. 利用該詞的詞性（part-of-speech 是屬於 verb 還是 noun）與詞義（lemma）本身，在 WordNet 3.1 中查詢得到其所有符合的相關 definitions。
2. 將所有句子（dataset intences 與 WordNet definitions）轉換成 vector 表示。
3. 計算彼此之間的 similarity。
4. 輸出前 $N$ 結果，並利用 similarity 來作為其 weight。

其中 embedding 這裡，因為前一次 project 的關係，我們直接使用當時表現最好的 fastText，並使用在 Wikipedia 2017、UMBC webbase corpus、statmt.org news dataset 上 pre-trained 好的300維 word vector。此外我們也再次嘗試使用了 BERT，由於我們選用的是 BERT-Base model，因此 word vector dimension 為768。

在 sentence embedding 的部分，我們試過三種不同的方法，直接把內容的所有 word embedding 相加、相加之後用句子長度做 normalization、將每個句子 padding 到同樣長度（使用 `[PAD]` 為所有 word embedding 的平均）。最終發現第二種方法對於效果上最好。

在 similarity 計算的部分，我們也試過不同的計算距離的方式（並利用距離的倒數做為 similarity），其中包含 cosine、Euclidean、Minkowsk，最後發現還是 cosine 的效果最好。由於我們會將最後 similairty 的 score 做為我們的 weight，然而我們想到一種小技巧，就是假設我們要預測 Top $k$，那麼最終的 weight 不直接用 similarity，而是用 similarity 減去第 $k$ 個的 similarity。這樣可以有效的讓彼此之間的權重比例差放大，更貼和 gold key 進而使 performance 更好。

此外我們也試了所謂的 strict 和 generalized Top $N$，因為在 gold key 中，字義的數量不一，有些只有一種字義，也有些則有多種字義。因此在 generalized Top $N$ 中，我們會利用一個 threshold 來篩選去除掉 similarity 太低的結果，但最少也會保留 1 個結果。然而最後發現這種 generalized Top N 的方法反而比 strict 的少了零點多分，我們猜測這是因為 similarity 的預測排序本身就不是正確的，導致就算我們篩掉一些我們認為相似度較低的，往往可能那個才是正確答案。最中發現在 N 為2的時候有最好的效果。

### BiLM

前者 TopN 模型是以 pargraph/sentence 的粒度做基於 WordNet 的相似度匹配，我們試想是否能用 word 的粒度並且在各個 sample sentence 之間進行 clustering 呢?
換言之，我們可以從上下文中構建更細粒度（fine-grained）的字義（例如 ELMo、BERT）而非單純使用原先的那種固定的 pre-trained embedding。藉由 Language Model（LM）的特性，我們可以從上下文中得到一個字在其中的意思，但是如果只是單純的把所有 word 換用成 contextual word embedding 表示，只會因為 LM 中自帶的 noise 太多，使得 robustness 變低且擴大 clustering 的 distance，而導致如果單純直接對 ELMo 的 embedding 進行 clustering，只會使效果劣於使用 pre-trained word embedding。

根據參考研究過後，我們依然是站在 ELMo 的這種 contextual word representation 的基礎上，但我們使用的是 **substitute vectors** 來代替某個 word embedding 而非直接使用 ELMo 輸出的 embedding。更精確地來說，我們借助了 LM 的特性，對於我們的 target 得到了一組在 LM 預測時的字組（也就是在 LM 預測某個字時的 candidate），並且企圖在裡面找到最相似可以代表的替換詞。除此之外，發現 conjunctions 特別是 *and* 一詞非常擅於連接兩個同種類的東西，我們可以稱這種為 conjunctive symetric patterns。將其與 substitute vector 的概念結合後，我們得到了一種基於 BiLM 的 context-dependent symmetric pattern substituions，並以此為基礎進行 clustering。對於我們 clustering 的方式使用的是 soft clustering。與一般 clustering 將所有 instances 聚集到某個特定的 class 中不同，soft（probabilistic）clustering 則是給予每個 cluster 一個機率分佈，看看該 instance 更像哪個 sense-cluster。

整體流程大致上可以分為三大階段。第一階段是對每個 instance 找到一個根據其 in-context word-substitutes 對應的 probability distribution（這是用 BiLM 所達成的）。第二階段是對於每個 instance 我們隨機挑選了 $k$ 個 representatives，每個 representatives 包含多個 samples（由 word distribution 所挑出）。最後我們會對於 representatives 來進行 soft clustering。

在第一階段中，我們知道 ELMo 其實底層是由一個 forward LM 跟 backward LM 所構成，為了得到對應於 center word 的 word candidate，我們用 forward LM 來擷取從句子開頭到 instance 中間的句子（也就是前半句），並用 backward LM 來從句尾擷取到 instance 之後的句子（也就是後半句）。根據 forward LM 跟 backward LM 我們會有兩組 candidates（context-based substitutions）的 distrubution。此外，我們會在 candidate 前後加入 *and* 來製作所謂的 dynamic symmetric pattern，這會使我們所得到的 distribution 有更好的 behavior。

至於在第二階段中，我們如何從前面得到的這兩個 distribution（forward 和 backward）中來構建所謂的 substitutes vectors 以支撐下一步的 fuzzy clustering。於是對於每個 instance 我們構建 $k$ 個 representatives，分別從兩個 distrubution 中各取了 $l$ 個 samples。（具體參數使用 $l = 4$ 和 $k = 20$）。

第三階段的 clustering 當中，我們對於每個 representatives 都相當有一組 bag-of-words，其中我們嘗試使用多種方法來表達這組 bag-of-words，舉凡像 one-hot（$|V|$ 維）、將 one-hot 用 TF-IDF 來做矩陣轉換（相當於把每個 representative 當成一個個 document）、使用 GloVe、fastText、BERT 直接做 bag-of-words 的 embedding 加總，最後發現使用 TF-IDF 能最有效的去除無關字的 weight（假如該字很常出現於其他 bag-of-words）並且達到最好的效果。我們使用的是 agglomerative clustering（cosine distance、average likeage），並且設定一個固定值的 clusters 數量（在此設為7）。然而這還只是針對 representatives 之間的 hard-clustering，要實現 soft clustering over instances，我們根據每個 instance 的 representatives 被分入各類的比例來做為其對於該類的 weight。

> * TF-IDF (Term-Frequence Inverse-Document-Frequency)
> * Agglomerative Clustering
>   1. Start with a collection $C$ of $n$ singleton clusters（初始時每個資料點自己都是一個 cluster）
>   2. Repeat until only one cluster is left（我們的目標是想辦法利用 distance 來 merge 兩兩 cluster 直到最後只剩一個最大的 cluster）
>       1. find a pair of clusters that is closest
>       2. merge the two clusters into a new cluster
>       3. remove the original clusters from the collection $C$ and add the new one
>   * 這最終會構建一個 dendrogram（某種 hierarchical tree of clusters），依據某種我們定義的 distance。
>   * 最後我們會用一個 threshold 從 tree 中間砍下去，被切分下去的分枝就各自成為一組 cluster 了。

### Result

最終在 TopN 中，我們使用前面所述效果最好的 strict Top2 搭配用 normalized adding 方式組成的 sentence embedding 達到 Fuzzy NMI 8.92、Fuzzy B-Cubed 52.51、Average 22.64。另外在 BiLM 的方面達到 Fuzzy NMI 11.06、Fuzzy B-Cubed 57.72、Average 25.27。

---

Related Links

* [AI-KU: Using Substitute Vectors and Co-Occurrence Modeling For Word Sense Induction and Disambiguation](https://www.aclweb.org/anthology/S13-2050/)
* [Word Sense Induction with Neural biLM and Symmetric Patterns](https://arxiv.org/abs/1808.08518)
  * 大致思路引用 AI-KU 但把原本的 4-gram Language Model 換成了 ELMo（故稱為 BiLM）。
* [Agglomerative Clustering: how it works - YouTube](https://www.youtube.com/watch?v=XJ3194AmH40&list=PLBv09BD7ez_7qIbBhyQDr-LAKWUeycZtx&index=2)
