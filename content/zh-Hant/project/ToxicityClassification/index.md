---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Jigsaw Unintended Bias in Toxicity Classification"
summary: "Kaggle 的比賽，目標是要判斷一些網路上的評論是否為 toxic。"
authors: ["王韵", "王勝廣", "admin", "邱越", "田檬"]
tags: ["Side Project", "ML DL", "NLP", "Competition"]
categories: []
date: 2019-05-01

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

url_code: ""
url_pdf: ""
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

這是碩一下學期修的機器學習課程的期末小組專題，我們最後選擇了這個 Kaggle 的 [Jigsaw Unintended Bias in Toxicity Classification](https://www.kaggle.com/c/jigsaw-unintended-bias-in-toxicity-classification) 做為題目。課程最後由於課程其中一位老師跟微軟有密切合作，因此課程答辯是辦在微軟大夏內。最終我們組獲得本次課程的最佳專題，且在 Kaggle 中的名次擠進前 1%。

關於本次賽題分析，任務是根據評論的數據文字內容來判斷是否為 toxic 的言論。其實可以看作是 Sentiment Analysis（情感分析）或 Sentence Classification。其中所謂的 Unintended Bias，其實就是當某些情況，例如我們提到「同性戀」這個詞時，有時候根據上下文的不同，有些確實是 toxic 有些則其實可能是毫無負面意思，因此單看字面意義本身並不能直接判斷這個字是否 toxic。

> * Train set: 1800K+
> * Test set: 97K+
>
> | Column (Categories) | Description             |
> | ------------------- | ----------------------- |
> | target              | Toxicity 值（預測目標） |
> | comment text        | 評論文本                |
> | toxicity subtypes   | Toxicity 子類評分       |
> | identity types      | 評論涉及 identity 評分 （研究用途）|
>
> * Subtypes: severe toxicity, obscene, threat, insult, identity attack, sexual explicit
> * Identies: male, female, transgender, other gender, heterosexual, homosexual gay or lesbian, bisexual, other sexual orientation, christian, jewish, muslim, hindu, buddhist, atheist, other religion, black, white, asian, latino, other race or ethnicity, physical disability, intellectual or learning disability, psychiatric or mental illness, other disability

本次賽題所採用的 evaluation metrics 是一種結合多個 AUC submetrics 來平衡綜合考量整體效能的指標。其中詳細分為以下幾種：

* Overall AUCs: This is the ROC-AUC for the full evaluation set
* Bias AUCs
  * Subgroup AUC: $\operatorname{AUC}(D_g^- + D_g^+)$
  * BPSN (Background Positive, Subgroup Negative) AUC: $\operatorname{AUC}(D^+ + D_g^-)$
  * BNSP (Background Negative, Subgroup Positive) AUC: $\operatorname{AUC}(D^- + D_g^+)$
* Generalized Mean of Bias AUCs: $$\displaystyle M_p (m_s)=(\frac{1}{N} \sum_{s=1}^{N} m_s^p)^{\frac{1}{p}}$$

Final Metrics: $$\displaystyle score = w_0 AUC_{overall} + \sum_{a=1}^{A} w_a M_p(m_{s, a})$$

在數據預處理上，由於數據文本很大一部分是擷取自網路的 comments，因此常會有很多刻意、非刻意的拼寫錯誤，為了更好的提高 pre-trained embedding 對單詞的覆蓋率，我們對數據中的一些字進行了一系列的 regular expression 匹配。我們也過濾了未登入字符，以及使用了 BPE（Byte Pair Encoding）的技巧（即用一些常用字來組成未在字典中的其他字）。

而當時在做的時候觀察了數據的分佈，發現 data imbalance 的情況相當嚴重，大多數的資料都是 non-toxic（positive and negative），且 target distribution（subgroup and background）也有不平均的狀況，這也導致了在 prediction score distrubution 上與之不一致的狀況，加上可能裡面對於標注人員對於同種類型的評分標準不一（annotator bias）也可能造成一些不良影響。

因此為了緩解（mitigate）這些 bias，我們用了一些方法：

* Sample Weight
  * Subgroup 及 Subgroup 副樣本 loss 加權
* Custom Object Function
  * Rank Loss
  * Focal Loss
* Data Augmentation
  * 擴充 Subgroup samples
  * 平衡 Subgroup 正負樣本比例

關於模型的部分，主要分為兩大塊，第一塊是我們的 pre-trained model 的部分，另一部分是我們實際做分類、推理的部分。

* Pre-trained Model
  * GloVe & fastText word embedding
  * ELMo
  * BERT
* Inference Model
  * BiLSTM (baseline)
  * Dilated CNN (baseline)
  * Capsule Net
  * BERT fine-tuning

我們的基礎模型，在 word representation 的部分，我們將 GloVe、 fastText 和 ELMo 的 word vector 相 concatenate 並且加上 BPE encoding 來作為我們一個 word 的 representation。在 embedding look-up 後接了兩層 Bidirectional LSTM 並接上 global max pooling 與 global average pooling 並把輸出相 concatenate 後，接了兩層 Residual Network（內部由全連接網路 + 4 層 LSTM 所組成）。最後在輸出時用了一個單輸出的 sigmoid 的線性層做為我們的 toxicity 結果預測以及一個多輸出的 sigmoid 線性層做為各個 subgroup 的 toxicity 預測。

在 BERT fine-tuning 的部分，我們直接將句子前面加上 `[CLS]` 後輸入模型，並在 `[CLS]` 對應的隱層輸出位置（也就是第一個位置）接上上述的兩種 sigmoid 的線性層來做分類。當時在引入了 BERT 之後效果有顯著的提升。

最終我們將各模型的輸出進行 ensemble 後的輸出做線上提交。在結果方面，我們在 Overall AUC 上達到 96.9%，並且在比賽中曾經達到過 22/2280（Top 1%）的成績

> * **Ensemble** 方法（meta-algorithms）：目的為了減小 variance（Bagging）、減小 bias（Boosting）或增加 predictive force （Stacking alias Ensemble）
>   * **Bagging**（Booststrap 再採樣、Aggregating）：在每個樣本訓練出來的模型取平均（從而降低模型的 variance)
>     * 其中一種做法是 k-fold cross-validation 各訓練出 k 個模型，最後用多數投票（分類問題）或是對輸出取平均（回歸問題）的方式來獲得所有訓練的模型共同決策結果。
>     * 好處是可以並行來訓練學習器。而通常 Bagging 是沒有一個明確的優化目標的。
>     * Random Forest 可以視為 Bagging 的一種延伸
>   * **Boosting**：是一種迭代方法，根據上一次迭代的預測結果對樣本進行加權（預測錯的樣本加大權重），減小誤差，來降低模型的 bias。
>     * AdaBoost（Adaptive Boosting）是其代表算法。其中還有 Gradient Boost、Gradient Boost Tree 等等。
>   * **Stacking**：是利用高層次的模型（次學習器）去學習怎麼樣組合低層次模型（基學習器）。（如果把 Boosting 看作是多個基分類器的線性組合，那麼 Stacking 就是多個基分類器的非線性組合）
>     * 在進行 Stacking 時要特別注意的是標籤洩漏（Label Leak）的問題，當我們在 training data 上訓練又在 training data 上預測時就會造成 Label Leak，因此需要特別切分出 valid set，用 valid set 的組合（k-fold）來構建下一層的訓練數據。
>     * 然而訓練完後我們還需對 test set 進行預測。有兩種作法，可以將 k 個模型對 test set 的預測結果取平均，也可以用所有的 training data 重新訓練一個新模型來預測 test set。
>     * 固定的 k-fold 可以儘量避免 valid set 過擬合，也就是全局共用一份 k-fold（比如組員之間）
>   * **Blending**：與 stacked generalization 很相似，不同之處在於，所有的 Stacker Model 共用同一份 holdout set（valid set），在訓練數據上區分了 Generalizer 與 Stackers。這樣在團隊之間可以不用全局共用一份 k-fold（分享 seed for stratified folds），且可以隨意的將新做的 model 往 Blenders 裡面丟。讓 Blender 決定是否要將其留下。

在比賽分工上，由於是一個組的比賽且每個人都有自己的課要忙，我們的組長王韵非常勤奮幾乎 carry 了整個組，王勝廣則 handle 了數據的預處理的部分，而我主要負責了 ELMo 部分的模型。

---

Related Links

* [Bagging, boosting and stacking in machine learning - Cross Validated](https://stats.stackexchange.com/questions/18891/bagging-boosting-and-stacking-in-machine-learning)
