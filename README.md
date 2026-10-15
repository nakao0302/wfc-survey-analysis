# Work-Family Conflict (WFC) Analysis among Japanese Physical Therapists

理学療法士における仕事と家庭の葛藤（Work-Family Conflict: WFC）に関する多変量解析および調査方法別（メール、郵送、Web回答）の比較検証リポジトリです。

---

## 📌 研究概要 (Overview)

本研究は、日本の理学療法士（PT）を対象として、仕事と家庭の葛藤（WFC）の現状および私生活要因・職場要因との関連を明らかにするアンケート調査研究です。

- **対象地域**: 6県（島根県、鳥取県、山口県、徳島県、福岡県、宮崎県理学療法士会）
- **解析対象者数**: **$N = 687$ 名**（欠損値なし完全回答データ）
- **評価尺度**: 日本語版多次元ワーク・ファミリー・コンフリクト尺度（Watai et al., 2006; 原版 Carlson et al., 2000）
  - 全18項目、5段階リッカート尺度（1: 全く当てはまらない ～ 5: 全くそのとおりである）
  - WFC合計得点: 18点 ～ 90点（平均 46.29 ± 12.24点）
  - WFC下位尺度得点: 9点 ～ 45点（平均 24.70 ± 7.13点）

---

## 📁 ディレクトリ構成 (Repository Structure)

```
wfc-survey-analysis/
├── README.md                          # 本ドキュメント
├── data/
│   ├── clean_survey_data.csv          # 匿名化済み解析用データセット（N = 687）
│   └── wfc_item_scores.csv            # WFC全18項目の項目別回答データ
├── R/
│   ├── 01_descriptive_statistics.R    # ① WFC基本統計・サブグループ別記述統計
│   ├── 02_survey_method_comparison.R  # ② 調査方法別（メール・郵送・Web）3群比較・ANOVA・カイ二乗検定
│   ├── 03_multivariable_regression.R  # ③ 多変量線形回帰分析（全体および3群別モデル）
│   ├── 04_cronbach_alpha.R            # ④ 尺度の信頼性分析（Cronbachのα係数）
│   └── 05_diagnostics_vif.R           # ⑤ 多重共線性(VIF)および残差診断（正規性・等分散性）
└── results/
    ├── Table_対象者背景_調査方法別3群比較.xlsx
    ├── Table3_多変量解析_全体および調査方法3群比較.xlsx
    └── cronbach_alpha_results.csv
```

---

## 📊 主要な解析結果と査読対応 (Key Findings & Reviewer Responses)

### 1. 調査手法による3群比較（Non-response bias / Mode effect）

| 調査方法 | 対象県（士会） | 対象会員数 | 回収数 (n) | 回収率 | WFC合計得点 (Mean ± SD) |
| :--- | :--- | :---: | :---: | :---: | :---: |
| **メール（メルマガ配信）** | 徳島、島根、鳥取、宮崎 | 3,406名 | **488名** | **14.3%** | 46.13 ± 12.13 |
| **郵送** | 山口 | 約1,300名 | **80名** | **6.2%** | 46.13 ± 11.18 |
| **Web回答（HP掲載）** | 福岡 | 5,698名 | **119名** | **2.1%** | 47.02 ± 13.40 |
| **全体 (Total)** | 6県 | 10,404名 | **687名** | **6.6%** | **46.29 ± 12.24** |

> **一元配置分散分析 (ANOVA)**: $F(2, 684) = 0.256, \quad p = 0.774$（調査方法間でWFC得点に有意差なし）

### 2. 尺度の内的一貫性（Cronbach's $\alpha$）

本研究サンプルにおいて、極めて高い内的一貫性が確認されました。

- **全18項目総合尺度**: **$\alpha = 0.913$**
- **仕事→家庭の葛藤 (WFC: 9項目)**: **$\alpha = 0.870$**
  - 時間的WFC (3項目): $\alpha = 0.910$
  - 負担的WFC (3項目): $\alpha = 0.877$
  - 行動的WFC (3項目): $\alpha = 0.783$
- **家庭→仕事の葛藤 (FWC: 9項目)**: **$\alpha = 0.851$**
  - 時間的FWC (3項目): $\alpha = 0.868$
  - 負担的FWC (3項目): $\alpha = 0.889$
  - 行動的FWC (3項目): $\alpha = 0.890$

### 3. 多変量線形回帰分析（WFC合計得点 18〜90点に対するモデル）

- **モデル適合度**: $R^2 = 0.228$, Adjusted $R^2 = 0.198$, $F(26, 660) = 7.51, p < 0.001$
- **主要な関連要因（非標準化回帰係数 $B$）**:
  - **残業時間**: 10h未満基準で、**11-20h ($B = +3.12$点)**, **21-30h ($B = +5.17$点)**, **31-39h ($B = +15.12$点)** と有意に悪化。
  - **ライフイベント**: **子どもの存在 ($B = +4.44$点)**, **女性 ($B = +3.90$点)**, **シフト休 ($B = +2.03$点)** でWFCが有意に上昇。
  - **心理・職場要因**: **職場環境への強い不満 ($B = +9.30$点)**, **強いキャリア不安 ($B = +8.80$点)** でWFCが著明に上昇。

### 4. モデル前提条件の検証（診断結果）

- **多重共線性 (Multicollinearity)**:
  - 子ども有無 VIF = 2.94, 配偶者職業 VIF = 1.70～3.74, 平均 VIF = 2.84
  - すべての変数が一般的な基準（VIF < 5～10）を十分にクリアし、多重共線性なし。
- **残差の正規性**: 歪度 -0.016, 尖度 0.257, Shapiro-Wilk検定 $W = 0.997, p = 0.290$（正規性成立）。
- **残差の等分散性**: Breusch-Pagan検定 $LM = 0.333, p = 0.564$（等分散性成立）。
- **影響値**: 最大 Cook's distance = 0.1024（外れ値の懸念なし）。

---

## 💻 解析の再現方法 (Reproducibility)

R (≥ 4.3.0) 環境にて、各スクリプトを順次実行できます。

```bash
cd R
Rscript 01_descriptive_statistics.R
Rscript 02_survey_method_comparison.R
Rscript 03_multivariable_regression.R
Rscript 04_cronbach_alpha.R
Rscript 05_diagnostics_vif.R
```

---

## 📜 引用・参考文献 (References)

1. Watai, I., et al. (2006). Development and validation of the Japanese version of the Multidimensional Work-Family Conflict Scale. *Sangyo Eiseigaku Zasshi*, 48(3), 71-81.
2. Carlson, D. S., et al. (2000). Construction and initial validation of a multidimensional measure of work-family conflict. *Journal of Vocational Behavior*, 56(2), 249-276.
