---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "2048 AI BOT"
summary: "搭建 2048 AI BOT。在 2014 年的比賽中搭建 MCTS 版本，並於 2018 年的 AI 課程中搭建強化學習版本。"
authors: ["admin"]
tags: ["Competition", "School Project", "ML DL"]
categories: []
date: 2018-12-29

# Optional external URL for project (replaces project detail page).
external_link: ""

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
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

當時和我大學同學（後來的室友）Tom 發現了這個比賽。我們原本就算是因為玩遊戲而認識的，那時候有玩星海爭霸2的人其實不算多，然而第一次在台科大第一學生餐廳認識時聊到此事，又發現雙方都是玩人族（一個很少人玩除非是抖M才會想玩的弱勢種族），因此而熟識。都熱愛遊戲的我們，看到可以寫遊戲AI的比賽都特別興奮，那時算是什麼也不懂的我們（演算法、資料結構都還沒修過），依然毅然決然的報名參加了。

2048是一款操作相當簡單的遊戲，只需滑動上下左右，將相同的數字合併後便可獲得分數。而每次移動都會隨機在一個空位產生新的數字（一般是2，小機率會出現4）。遊戲可以不斷地進行下去，直到版面全滿且無法進行任何合併、移動為止。

當時的思路是用蒙地卡羅搜尋樹（MCTS）來找尋最佳的移動方向，以我們遊玩的經驗來說，把最大的數塊放在角落能夠大幅增加存活機率，特別是在場面最大數字很大的時候，以這種思路加上讓數字順序以Z自型來排列的話，就能很有效的讓合併完的新數塊能夠與之合併。常常遊戲結束都是因為有兩個大數塊被中間夾雜的小塊隔開而遲遲無法合併導致的。

因此我們設計了一套版面的評價指標，對於每個版面給予一個分數，利用DFS的策略來搜尋未來的最佳的版面。由於比賽限制移動次數必須為一秒100次，因此我們設定一個計時器，能同時進行最深的搜尋又保證平均時間可以落到標準之內。根據經驗，每一步的平均搜尋深度可以到4步左右，然而當遊戲快要結束時，由於有許多方向已判斷無法移動，故搜尋深度可以再更深到8甚至到10左右。

具體評價指標我們分為四種，單調性（Monotonicity）、平滑性（Smoothness）、空白格子（Free Tiles）、Z字型（亦為單調性的一種）。...

具體的搜尋方法稱為 Minimax Search with Alpha Beta Pruning。所謂的 Alpha Beta 剪枝目的就是為了去除掉很多可以不必搜尋的分枝以增加搜尋的效率。Alpha 和 Beta 其實是去模擬兩個人對弈的過程，在 2048 中就是人類移動版面對上電腦放入新數塊。過程中會假設雙方都去做可以最大化自己利益的動作，好比人類的策略就是希望版面分數最大化 （Alpha 最大的下界）、而電腦的策略就是希望版面分數最小化 （Beta 最小的上界）。...

---

後來到了北京大學讀碩士，那時候接觸到了用機器學習和深度學習為主的人工智慧，修了一堂名叫「人工智能實踐」的課，回想起當時的這個比賽，想用基於深度學習的強化學習方法來嘗試一下。

當時比賽因為比賽方有提供 C++ 版本的遊戲與 API，這次因為是使用 Python，故又自己重新做了一個 Python 版本的遊戲並設計一些有助於 debug 和方便與機器學習對接的 API。

具體試過了兩種策略選擇方式，最早嘗試的是使用 $\epsilon$-Greedy 的 **Policy Gradient**，想法比較簡單直接，也就是每次對於當前的版面利用神經網路來學出當前版面的評價，預測一個移動方向，移動後如果有分數增加，則做為獎勵（reward）。若一直進行無效操作（預測欲往某個無法移動的方向移動）則會給予懲罰（penalty）。而所謂的$\epsilon$-Greedy 方法其實是一種探索策略，以 $\epsilon$ 為模型探索 exploration 的機率，反之其餘時間模型會用最佳貪心的策略來進行 exploitation。初始我們的 $\epsilon$ 相對會非常高，而隨著訓練的時常慢慢遞減，而所謂的「探索」我們嘗試引入了「老師」的角色，除了以隨機的方式探索外，我們引入了先前 MCTS 的方法，試圖用 MCTS 來引導神經網路的學習。但後來經過實驗與細部觀測發現，由於有時候我們為了達到一個更好的狀態，其實必須要「經過」一些不好的狀態，然而因為這種版面可能對模型來說會有所懲罰，而讓模型變得畏懼去做一些比較「大膽」一點的舉動，因此模型整體趨向保守（常常不斷預測相同方向）。因此後來我們認為這種 Policy Gradient 並不太適用於這種非持續最佳優化的遊戲。

於是我們開始嘗試 **Deep Q-Learning**，與 Policy Gradient 的想法不同在於，在這裡我們的預測不是應該走哪個方向，而是對於版面的評價。在原始的 Q-Learning 中，我們學習建模的 $Q(s, a)$ 其實是一種對 reward 的建模，而我們不可能去把所有 state-action pair 的輸出都存起來，因此 Deep Q-Learning 其實相當於是去學習並對該 Q function 近似。當我們在預測的時候，預測的不是 action，而是未來版面可能的 state 的 score，最後挑 score 最大的那個來走。

但為了訓練 Deep-Q Network 我們需要先收集一份 experience history memory，在這裡我們與先前直接輸入版面數字到深度網路中不同，我們對於版面進行了 one-hot 的預處理，具體來說，對於版面我們區分為2的版面、4的版面、8的版面、⋯⋯，以此類推。並且每個版面只顯示該版面所屬的數字（有出現在該位置就為1，否則為0）。在構建 experience history memory 時，根據先前的經驗，我們有了幾個初步的想法，一種利用 random 來構建 experience history（教 DQN 來觀察 pattern），另一種是用 MCTS 來構建 experience history（直接教 DQN 怎麼玩）。訓練時利用 batch 的方式（而非先前的單步互動式）來進行學習，單個 sample 單位以 state-action pair 為基準。

然而最後雖然效果是優於稍早前做的 Policy Gradient，且有機會達到 2048，但相比先前用 MCTS 隨便都能 4096 以上的表現還算差強人意，這也學習到了並不一定所有東西都適合直接用 Deep Learning 來建模，也許 MCTS 與深度網路的搭配使用可能可以達到奇效（例如 AlphaZero）。

---

Source code:

* 2014: [Monte Carlo Tree Search](https://github.com/daviddwlee84/2048-AI-BOT) (competition)
* 2018: [Reinforcement Learning](https://github.com/daviddwlee84/ReinforcementLearning2048) (coursework)

![poster](poster.jpg)

Related Links

* [logic - What is the optimal algorithm for the game 2048? - Stack Overflow](https://stackoverflow.com/questions/22342854/what-is-the-optimal-algorithm-for-the-game-2048/)
* [CS 161 Recitation Notes - Minimax with Alpha Beta Pruning](http://web.cs.ucla.edu/~rosen/161/notes/alphabeta.html)
* [AlphaZero: Shedding new light on chess, shogi, and Go | DeepMind](https://deepmind.com/blog/article/alphazero-shedding-new-light-grand-games-chess-shogi-and-go)
