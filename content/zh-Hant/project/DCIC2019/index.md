---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "混凝土泵車砼活塞故障預警"
summary: "基於特徵工程的比賽，對於 time-series 的運轉數據預測其故障的可能性。"
authors: ["admin"]
tags: ["Side Project", "ML DL", "Competition"]
categories: []
date: 2019-03-20

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

url_code: "https://github.com/daviddwlee84/MachineLearningPractice/tree/master/Project/DCIC2019"
url_pdf: ""
url_slides: ""
url_video: ""

# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
slides: ""
---

這個比賽參加的契機是一個在深藍科技的學長想要招募一些學弟來加入 DeepSmart 團隊一起打比賽而舉辦的練習賽，雖然後面因為必須要求去他公司實習與實驗室的種種因素而婉拒了這次機會，然而卻是讓我對特徵工程類型的比賽有深刻的一次體會也收穫很多。（其實還有前一個練習賽是 Kaggle 的 [Elo Merchant Category Recommendation](https://www.kaggle.com/c/elo-merchant-category-recommendation)，然而因為當時時間太短，僅有用 LightGBM 是跑了一些 baseline 和簡單的特徵）。

關於本次賽題[混凝土泵車砼活塞故障預警](https://www.datafountain.cn/competitions/336/details)的背景是在生產設備中，特別是砼塞這種在混凝土泵車做為關鍵性的零件同時也是消耗性部件，若活塞故障將導致泵車無法正常運作，然而固定計畫性的檢修之維護成本高，且維護時必須停機，相反的如果等故障發生後再維修，又會導致非計畫性的停產，因此若能從泵車上實時上傳砼塞的運轉數據並能有效預測其是否有可能故障來做出有效的預測預警，便可達到折衷的效果。

賽題提供了許多與混凝土泵車砼活塞有關的數據，包括工作時間、發動機轉速、油溫、壓力等多類工況數據，以及對應情況下，在未來完成給定工作量（混凝土泵送方量）的過程中，活塞是否故障的標識信息。具體資料欄位如下：

* 活塞工作時長：
  * 新換活塞後，累積工作時長
  * Numeric feature
* 發動機轉速、油泵轉速、泵送壓力、液壓油溫、流量檔位、分配壓力、排量電流：
  * 均為泵車的對應工況值
  * Numeric feature
* 低壓開關、高壓開關、攪拌超壓信號、正泵、反泵：
  * 開關量
  * Binary feature
* 設備類型：該泵車的類型
  * Categorical feature

除了開關量以外，上述設備類型、工況數據的具體值都經過了一定的脫敏處理（Data Masking），即不完全是實際測量值，但已考慮盡量不影響數據蘊含的關係等信息。

這個比賽與一般傳統比較單純的 dataset 不同，每個 sample 都是一連串長短不一的 time-series 運轉數據，因此我們必須對這些數據每個合併計算特徵之後才能一起丟到下游的模型中訓練。

首先學習到的是一些通用的作法，例如非類別型數據我們可以對他取 unique length、max、min、sum、mean、std 等等。而對於 time-series 的資料又可以特別去做 first derivative 和 fourier transform 等特徵。

針對這次比賽的特性，其實也了解到如何使用領域知識來製作特徵，比方我們可以用 累積工作時長 × 發動機轉速 或是 累積工作時長 × 油泵轉速 的組合來計算發動機與油泵累積旋轉圈數。或是當轉速超過某個 threshold 我們可能可以判斷它轉太快有可能會加快耗損等等。

這次比賽主要所使用的模型工具是 XGBoost，也學習了如何去看 Feature Importance 來選擇一些比較有效的特徵。

由於這次比賽的數據分佈實在有點弔詭，常常在 local 端提升的成績上傳上去反而 online score 下降，讓人十分挫折，畢竟所花的時間不菲。最後上傳的最佳成績為 Macro F1 score 為 60.01%，在結算後掉至 168/906 名。

---

Related Links

* [混凝土泵車砼活塞故障預警 - DataFountain](https://www.datafountain.cn/competitions/336)
