---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Stanford CS224n NLP with DL"
summary: "自學課程，其中包括 word2vec、dependency parsing、machine translation、question answering 等 projects。"
authors: ["admin"]
tags: ["Side Project", "ML DL", "NLP"]
categories: []
date: 2019-07-01

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

url_code: "https://github.com/daviddwlee84/Stanford-CS224n-NLP"
url_pdf: ""
url_slides: ""
url_video: ""

# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
slides: ""

# To enable LaTeX math rendering for a page, you should include `markup: mmark` and `math: true` in the page’s front matter
# Otherwise, to enable math on the homepage or for all pages, you must globally set `math = true` in `config/_default/params.toml`.
# https://sourcethemes.com/academic/docs/managing-content/#math-and-code
markup: mmark
math: true
---

這是一個史丹佛的線上課程，2019年釋出的更新主要比2017年多了近年來發展的 Transformer、BERT 等 State-of-the-art 模型，課程內容相當的與時俱進。我覺得老師跟 Head TA 講得非常好，其中還邀請到了 Transformer 的作者之一來課堂分享，非常推薦給任何想入門或是複習NLP的人學習。特別是今年和2017年最大不同在於，從原本的 TensorFlow 改為用 PyTorch 為主要 framework，其實真的很不錯，寫過 TensorFlow 1.X 跟 Keras 就會知道，PyTorch 的 API 相對於 TensorFlow 親民許多又比 Keras 更好 debug 跟做細部調整，甚至會有點小後悔當初沒有以 PyTorch 入門。

這次課程的重點我覺得扎實的 Assignment 佔了很大一部份，且由簡入深、循序漸進，和課程有相呼應的搭配，在做作業的途中也有許多的引導，實屬非常棒的教材。

**Assignment 1** 主題是 **Exploring Word Vectors**。主要讓人感受用 co-ocurrence matrix（count-based word vector）與 word2vec（prediction-based word vectors）之間的差異，並用簡單的例子在 2D 平面上做視覺化的比較。前者使用了 Truncated SVD 對原始稀疏的 co-occrrence matrix 進行降維並使矩陣變得稠密；後者使用的是在 Google News 上預訓練好的300維 word2vec，同樣使用 Truncated SVD 把它降至二維。除了視覺化的例子外，也做了一些 cosine 相似度的測試，和同義詞反義詞的實驗等。

> * SVD Singular Value Decomposition 目的是要將矩陣進行分解（$X \rightarrow USV^T$）最後取 $U$ 來作為我們的 word embeddings。
> * Truncated SVD 使用時機是在當我們只關心前 $k$ 個 components（且 $k$ 相對小）時，可以減少計算量。

**Assignment 2** 開始正式踏入 **word2vec**，利用 Skip-gram model 來訓練 word2vec（另一種方法是CBOW Continuous Bag-of-words），其中我們使用了 Negative Sampling 來取代 Naive Softmax 以降低計算複雜度（其他方法還有像是Hierarchical Softmax）。最後同樣在 2D 平面上觀察所訓練出來的分佈情況。

> * Skip-gram 是利用當前的字來預測周圍的字（surrounding words），根據當前字的位置來預測在一定範圍內的前後字。
> * CBOW 是根據上下文（context）預測當前的字，被稱為Bag-of-word的原因是因為在預測時並不考慮字的順序。
> * 由於 Softmax 在預測類別很多的情況下的計算量非常巨大，故有一些方法可以來減輕其複雜度。
>   * Hierarchical Softmax 是把原本直接預測所有類別的輸出，改為一個 Binary（Huffman）Tree 結構，變成預測某個子樹節點，這樣可以大大減少類別數量。
>   * Negative Sampling 則是對於每次預測都個抽取 $k$ 個（可重複）的 negative samples（words），對於當前字與目標字形成的 pair（word, context）根據其來源打上 label，來學習判斷這個 pair 是出自於 data 中還是隨機生成的，將原本多分類的問題轉變為二分類。

**Assignment 3** 是介紹 **Neural Dependency Parsing**，在傳統的 Dependency Parsing 中有許多不同方法（例如 Dynamic Programming、Graph Algorithm、Constraint Satisfaction）但時間複雜度高。因此我們使用了一種 Greedy Transition-based Parsing（Deterministic Dependency Parsing）的方法，此方法是利用訓練一個分類器，讓在每一次 Parsing 的過程中可以直接找到正確的 attachment。我們使用的是一個叫 Shift-Reduce Parser 的這種解析方式，每次預測三種不同的操作 Shift、Left-Arc、Right-Arc。而我們有一個 Stack 初始裝 `[ROOT]` 有一個 Buffer 初始裝所有待爬取的字，目標會從 Buffer 中 "Shift" 字到 Stack 中，並在 Stack 中進行 dependency 的 attachment。最終如果 Buffer 為空且 Stack 只剩 `[ROOT]` 時則終止。由於事實上我們只需要把整個 Buffer shift 到 Stack 中，再重 Stack 中去除，因此我們只需要 $O(n)$ 的時間複雜度（相較於 Dynamic Programming 的 $O(n^3)$ 在效率上達到很大的提升。

我們使用的 evaluation metrics 是 UAS（Unlabeled Attachment Score），是在計算有多少百分比的 word 有找到正確的 head。最終在第9個 epoch 時達到最高 88.97%。

> * Dependency Parsing 的方法
>   * Dynamic Programming 相當於去找出所有可行解的最優解。
>   * Graph Algorithm 為一個 sequence 建立一個 minimum spanning tree。
>   * Constraint Satisfaction
>   * Greedy Transition-based Parsing / Deterministic Dependency Parsing 即本次的重點。
> * Attachment Error
>   * Prepositional Phrase Attachment Error 是當一個 PP（例如 *before midnight*、*under the carpet*）修飾到錯誤的 head word。
>   * Verb Phrase Attachment Error 是當一個 VP（例如 *leaving the store unattended*）修飾到錯誤的 head word。
>   * Modifier Attachment Error 是當一個 modifier（例如 *extremely*）修飾到錯誤的 head word。
>   * Coordination Attachment Error 是當有一個 coordinating conjunction（例如 *or*）串連兩個 conjunctions（可能是個 phrase），而第二個 conjunct 應該要連接到第一個 conjunct，因此錯誤是當第二個 conjunct 連接到到錯誤的 head word時。

**Assignment 4** 開始進入比較大型的模型 —— **Neural Machine Translate**。目的是將 source 語言（Spanish）翻譯成 target 語言（English）。在這裡我們使用的是一種 Sequence-to-sequence 的 Encoder-Decoder 結構，搭配 Decoder 對於 Encoder 的編碼的 Attention（使用的是 Multiplicative Attention）。在結構上，我們使用 Bidirectional LSTM 搭建 Encoder（用 `nn.LSTM`），並使用 Unidirectional LSTM 搭建 Decoder（用 `nn.LSTMCell`）。

Encode 的目標是為了讓 input sequence 轉變成一個 fixed-size "context vector"，而 decode 則是利用 encode 所得到的資訊來進行一個一個字的預測。其中在 Decoder 解碼時，我們會將 Encoder 的最後一層 hidden layer 的結果做為 Decoder 的初始值，但因為 Encoder 是 bidirectional 的關係，我們會多利用一層線性層來把 forward $h^{(f)}$ 與 backward $h^{(b)}$ 相 concatenate 的狀態 $h = \lbrack h^{(f)}; h^{(b)} \rbrack$ project 到與 Decoder 相同維度來作為其初始狀態。

每次進行 decode 時，Decoder 的輸出 $h_t^{\text{dec}}$ 會與 Encoder 的每個輸出算一個權重 $e_t$（將其取 softmax 以得到機率分佈 $\alpha_t$，最中得到一個 Attention 的結果 $a_t$（由於 Encoder 是 bidirectional 的關係，維度會是 $\mathbb{R^{2h \times 1}}$）。特別要注意，在計算 softmax 之前，由於我們有 padding 的關係，我們只想跟實際有 word 的 encoding 做 attention，因此我們必須把 padding 的部分 mask 掉（設為 $-\infty$）。每次我們會將這個 Attention 的結果 $a_t$ 與 Decoder 的輸出 $h_t^{\text{dec}}$ 進行 concatenate $u_t = \lbrack a_t; h_t^{\text{dec}} \rbrack$，之後通過一個以 tanh 激活的線性層與一層 Dropout 層來得到我們的 combined-output vector $o_t$，並在最後以一層線性層接 softmax 來進行預測下一個字。

整個 decode 階段可以分為訓練階段與預測階段，訓練階段從特殊字 `<START>` 做為初始輸入，經過一連串的操作後預測下一個字，再將預測的字做為下一次預測的初始值。在這裡我們使用 Beam Search 來進行 decode。由於訓練階段我們知道什麼時候會碰到特殊字 `<END>` 使單次的 decode 訓練階段結束，然而在預測時我們並不能保證何時能夠產出 `<END>`，因此除了在 decode 階段解析出 `<END>` 停止之外（當然，在 Beam Search 中，預測出 `<END>` 謹代表該分支停止），我們也會設定一個搜尋深度（timestep）的最大值 $T$，或者是在我們解析得到至少 $n$（pre-defined cutoff）個完整的 hypotheses 時。

對於機器翻譯的 evaluation 我們使用的是 BLEU（Bilingual Evaluation Understudy），這是一種基於 n-gram 的計分機制，一個 source sentense $s$ 可能可以對應 $k$ 個 reference translations $r_1, \dots r_k$，以及我們所預測的 candidate translation $c$。要計算 $c$ 的 BLEU 分數，我們會先對於每個 n-gram（$n$ 從1到4）計算 modified n-gram predcision $p_n$，具體計算就是去比對重複次數最高的那個 $r$ 並除以 $c$ 的 n-gram 數，由於是用 n-gram 匹配，可能會出現多次重複匹配的情況，我們會限制分子不能超過 $c$ 的 n-gram 數。此外，對於每個 $p_n$ 我們都有一個權重 $\lambda_n$（其總和為1）。最後還有一個 BP（brevity penalty）係數，與前者的加權和相成即為最終 $c$ 的 BLEU 分數。

本次實驗訓練了13個 epoches，最終 Corpus BLEU 達到 22.365。對於 NMT 系統也做了分析，對照 reference translation 跟預測的 NMT translation 結果進行比對來看其錯誤並推論該錯誤可能造成的原因為何。舉凡像是一些 `<UNK>` 或是重複循環的輸出，亦或是數字並沒有被保留或因單位不同而輸出錯誤的值等等。

> * Language Model 語言模型，任務其實很簡單，就是根據上下文來決定下一個字的預測。
> * Attention 的種類
>   * Basic dot-product Attention 是單純對於兩個 vector 算 cosine 相似度，但有一個限制條件是他們的維度必須要相同。這個的優點就是計算非常快速簡潔。 $e_i = s^T h_i$
>   * Multiplicative Attention 是多了一個 attention weight 在兩者之間。 $e_i = s^T W h_i$
>   * Additive Attention 是利用了一層線性層加 tanh 激活，相當於一個 shadow network。$e_i = v^T \tanh(W_1h_i + W_2 s)$
>   * 還有很多其他的變種，各自也有各自的延伸。
> * Decode 的方法
>   * Geedy decoding 在每一次對 softmax 的輸出取 argmax，也就是預測輸出機率最高的字。然而會遇到當有後向前依賴的輸出時，已輸出的預測無法更改的狀況。
>   * Exhaustive search decoding 我們每次計算所有可能產生的 sequence 的機率。但這樣的時間複雜度實在是太過昂貴。 $\displaystyle P(y|x) = \prod^T_{t = 1} P(y_t|y_1, \dots y_t-1, x) \Rightarrow O(V^T)$
>   * Beam search decoding 相當於是一種折衷，我們每次保留 $k$（beam size）most probable 的 partial translations（我們稱之為 hypotheses），對每一個 hypothesis 會有一個 score（即他自己的 log probability）。最後我們會挑選 top-scoring hypothesis（我們會將每一層的 score 以 length 進行 normalize），並以 backtrack 的方式往樹狀的暫存狀態解析得到 full hypothesis。

**Assignment 5** 這次是號稱 coding-heavy 跟 written-question-light，這次作業相較以往，有一些 sanity check 是需要自己完成的。而本次的主題 **Character-based NMT** 是針對 Assignment 4 的改進，也就是在原本的基礎上引入了 Character-level CNN Encoder 跟 Decoder。使用 1-dimensional convolutions 的想法在於字其實是分為很多小的 semantic unit（morphology - parts of words）這些小塊組成了整個字的意思，而 CNN 正好很適合去捕捉這種區域型的信息。此外為何要引入 Character-level model 最主要的重點除了可以減少 word vocabulary 的大小外，更可以解決 `<UNK>`的問題。在預處理中，我們會對於每個 word 切分成 characters ，並在頭尾加上 start 與 end 的符號（分別用 `{` 與 `}` 來代表），並同樣會做 padding（使用 length 為21）。同樣的，我們也會有 character embedding（所有英文字母加上一些符號）。

關於 Character-level model 的結構，分為 Encoder 與 Decoder 來討論。在 Encoder 中，首先會對於輸入的 characters 進行 embedding lookup，並且通過一層以 ReLU 激活的 Convolution 層後，進行 Max-pooling over time（global max pooling）。之後將這個 Convolution 完的結果 $$x_{\text{conv_out}}$$ 接到一個 Highway Network 中。Highway Network 跟 Residual Network 很類似，都是為了要有所謂的 skip-connection，然而 Highway Network 多了一個 dynamic gate（類似於 LSTM 的 gates）來控制輸出的 identity $x$ 與 Network Block 中的輸出的比例。這裡我們的 Network Block 就只是一層以 ReLU 激活的線性層。最終我們將 Highway Network 的輸出 $$x_{\text{highway}}$$ 通過一層 Dropout 得到 $$x_{\text{word_emb}}$$ 做為我們對於這個 word 的 word embedding，也就是取代了以往 word embedding lookup 的環節。

其餘中間結構皆與 Assignment 4 相同，而在 Decoder 的部分，相當於是額外做了一個 Character-level Decoder，他有自己的 character embedding，裡面是一個單向的 LSTM，原理與 Assignment 4 的差不多，只是少了 Attention 的步驟（通過 LSTM 後，利用線性層 project 到 character vocabulary 上用 softmax 算 score）。在訓練的過程中，我們不僅會訓練 Word-level Decoder 也會訓練 Character-level Decoder。而在解碼預測階段，整體的解碼過程仍然是用 Beam Search 以 word 為粒度進行預測，然而當我們預測出 `<UNK>` 時，則會啟動 Character-level Decoder，在這邊對於每個 characters 的預測則是採用 Greedy Search。

在經過29個 epoches 的訓練之後，得到最終的 Corpus BLEU 為 24.20，相對於 Assignment 有差不多2的提升。把當時 Assignment 4 的結果拿出來跟這次的比較，特別是觀察以前被預測為 `<UNK>` 的字是如何在這裡被解析的，會發現很多很有趣的現象。

> * Pooling 又可稱 Subsampling 具體可以有以下分類
>   * 以 Pooling 的方式區分
>     * Max Pooling 在 NLP 中使用 max pooling 是比較好的，因為通常 NLP 的信號是比較稀疏的，且我們希望觀察到的是「有沒有被激活」的現象。
>     * Average Pooling
>   * 以 Pooling 的範圍區分
>     * Pooling Over (Through) Time (Global Pooling) 其實就相當於直接對整個 sequence 取 max（也就是每個 kernel/filter 卷積出來的結果來計算）。
>     * Local Pooling 在 CV 中通常是使用此種 Pooling（就算沒有特別講）
>   * 特殊的方式
>     * K-Max Pooling Over Time 每次會找出 $k$ 個最大值，並且要注意的是會保留最大值在原始 sequence 對應的順序。

期末的 **Final Project** 預設主題是針對 SQuAD 2.0 的 **Question Answering** 系統。SQuAD 會給予一段 paragraph 並給予一個問題，並且要我們預測問題的答案，一般來說，答案會是簡答題（span-based answer），例如某個 entity，而這個 entity 是一定可以在 paragraph 中被找到的。然而 SQuAD 2.0 與 1.X 系列最大的差別在於，SQuAD 2.0 多了很多題目可以是 NoAnswer 的，由於在 SQuAD 1.X 中，我們可以明確的知道答案一定在問題中，因此只要全力去找與問題最相關的字段就可以了，然而在 SQuAD 2.0 則強迫必須要真的去理解問題的意思。
