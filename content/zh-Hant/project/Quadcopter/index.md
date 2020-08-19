---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "基於模組化架構之四軸飛行器設計及其於影像辨識之應用"
summary: "大學畢業專題。從零打造四軸直昇機，並且在多種不同的開發平台上運行，並結合電腦影像技術做自動控制。獲得校內最佳專題獎、最佳人氣獎。"
authors: ["admin", "陳重昌", "施鈞陽"]
tags: ["School Project", "Competition"]
categories: []
date: 2016-11-04

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
---

Technique:

* PID (proportional-integral-derivative) Control
* Object detection (using OpenCV)
* GUI Control Panel

Development Environment:

* Flying Algorithm (using one of the development board):
  * ARM - STM32F4
  * HOLTEK - HT32F1656
  * Intel Edison
* Computer Vision:
  * Raspberry Pi 3
  * Webcam
  * SG90 (x2)
* Sensors/Module:
  * Attitude Sensor: GY80 / JY901
  * Power suupply and Motor control: ESC
  * Wireless communication: APC220
* Other
  * 11.1v Battery
  * Motor + Propeller (x4)
  * PS4 Joystick

Awards:

* School:
  * Best Independent Study Award
  * Best Popularity Award
* ARM Design Contest:
  * Top 10
* HOLTEK MCU Design Contest
  * Honorable Award
