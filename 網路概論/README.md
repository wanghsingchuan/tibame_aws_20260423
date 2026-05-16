# 網路概論 CH1：Introduction 重點整理 🌐

> 整理自 Kurose & Ross《Computer Networking: A Top-Down Approach》9th Edition Chapter 1

---

## 📑 目錄

- [章節地圖 (Roadmap)](#-章節地圖-roadmap)
- [一、什麼是 Internet？](#一什麼是-internet)
- [二、什麼是 Protocol？](#二什麼是-protocol)
- [三、網路邊緣 (Network Edge)](#三網路邊緣-network-edge)
- [四、網路核心 (Network Core)](#四網路核心-network-core)
- [五、效能：Loss、Delay、Throughput](#五效能lossdelaythroughput)
- [六、網路安全 (Security)](#六網路安全-security)
- [七、Protocol Layers 協定分層](#七protocol-layers-協定分層-)
- [八、Internet 歷史](#八internet-歷史-)
- [章節重點摘要](#-章節重點摘要)

---

## 📑 章節地圖 (Roadmap)

1. 什麼是 Internet？什麼是 Protocol？
2. 網路邊緣 (Network Edge)
3. 網路核心 (Network Core)
4. 效能 (Performance)：loss、delay、throughput
5. 網路安全 (Security)
6. 協定分層 (Protocol Layers)
7. 歷史 (History)

---

## 一、什麼是 Internet？

### 兩種觀點

**1️⃣ 「螺絲螺帽」觀點 (Nuts and Bolts View)**

Internet 由三大元件組成：

| 元件 | 說明 | 範例 |
|------|------|------|
| **Hosts (end systems)** | 數十億連網裝置，跑網路 App | 手機、電腦、IoT 裝置 |
| **Packet switches** | 轉送封包 | Routers、Switches |
| **Communication links** | 傳輸媒介 | 光纖、銅線、無線電、衛星 |

- **Internet = "network of networks"**：由互連的 ISP 組成
- **Protocols 無所不在**：HTTP、TCP、IP、WiFi、4G/5G、Ethernet
- **Internet 標準**：
  - **RFC** (Request for Comments)
  - **IETF** (Internet Engineering Task Force)

**2️⃣ 「服務」觀點 (Services View)**

- 提供應用程式所需的基礎建設（Web、串流影音、Email、社群媒體…）
- 提供分散式應用程式的程式介面 (programming interface)

---

## 二、什麼是 Protocol？

> **Protocols define the format, order of messages sent and received among network entities, and actions taken on message transmission, receipt.**

協定定義：
- 訊息的**格式**
- 訊息傳送/接收的**順序**
- 收發訊息時應採取的**動作**

**人類協定 vs 網路協定對照：**

| 人類協定 | 網路協定 |
|---------|---------|
| Hi → Hi | TCP connection request → response |
| 「現在幾點？」 | GET http://... |
| 「2:00」 | `<file>` 回傳 |

---

## 三、網路邊緣 (Network Edge)

### Internet 結構三層

```
┌─────────────────────────────────────┐
│   Network Edge                      │  ← Hosts (clients/servers)
├─────────────────────────────────────┤
│   Access Networks & Physical Media  │  ← 有線/無線連線
├─────────────────────────────────────┤
│   Network Core                      │  ← 互連的 Routers
└─────────────────────────────────────┘
```

### Access Networks 接取網路

**1. Cable-based Access (HFC, Hybrid Fiber Coax)**
- 使用 **FDM (Frequency Division Multiplexing)** 分頻多工
- 非對稱：下行 40 Mbps – 1.2 Gbps / 上行 30-100 Mbps
- 多戶**共享**頻寬到 cable headend
- 關鍵設備:cable modem、CMTS (Cable Modem Termination System)

**2. DSL (Digital Subscriber Line)**
- 使用既有的電話線連到 central office DSLAM
- 下行 24-52 Mbps / 上行 3.5-16 Mbps
- **專屬 (dedicated)** 線路，不像 Cable 是共享

**3. Home Networks**
- 通常整合在一台設備中：cable/DSL modem + router + firewall + NAT + WiFi AP
- WiFi：54、450 Mbps；有線 Ethernet：1 Gbps

**4. Wireless Access Networks**

| 類型 | 範圍 | 速度 |
|------|------|------|
| **WLAN (WiFi)** 802.11b/g/n | ~100 ft 建築物內 | 11、54、450 Mbps |
| **Cellular (4G/5G)** | 數十公里 | 數十 Mbps |

**5. Enterprise Networks**
- 混合有線/無線
- Ethernet：100Mbps / 1Gbps / 10Gbps
- 連接 switches 與 routers

**6. Data Center Networks**
- 高頻寬連結：10-100 Gbps
- 連接數百到數千台伺服器

### Host 如何送資料？

主機把訊息切成 **packets**（封包），每個封包長度 L bits，以傳輸速率 R 送進網路。

```
Packet Transmission Delay = L (bits) / R (bits/sec)
```

### 實體媒介 (Physical Media)

| 媒介 | 類型 | 特點 |
|------|------|------|
| **Twisted Pair (TP)** | Guided | Cat 5：1 Gbps；Cat 6：10 Gbps |
| **Coaxial cable** | Guided | 雙向、寬頻、多頻道 |
| **Fiber optic** | Guided | 高速 (10s-100s Gbps)、低錯誤率、抗電磁干擾 |
| **Radio (WiFi/Cellular)** | Unguided | 受反射、阻擋、干擾影響 |
| **Satellite** | Unguided | Starlink < 100 Mbps；地球同步衛星延遲 270ms |

---

## 四、網路核心 (Network Core)

### 兩大核心功能

| 功能 | 範疇 | 動作 |
|------|------|------|
| **Forwarding (轉送)** | 區域性 (local) | 用查表方式，把封包從輸入埠送到輸出埠 |
| **Routing (路由)** | 全域性 (global) | 路由演算法決定 source → destination 的完整路徑 |

> 🚗 類比：Routing 是規劃整段旅程；Forwarding 是在每個交叉路口決定走哪邊。

### Packet Switching vs Circuit Switching

#### 🔵 Packet Switching (封包交換)

**Store-and-Forward 機制**：整個封包必須完整到達 router 才能繼續傳送到下一段。

- 範例：L = 10 Kbits，R = 100 Mbps → 一跳延遲 = 0.1 msec
- **Queueing 排隊**：當到達速率 > 傳輸速率時封包排隊
- **Packet Loss**：當 buffer 滿了，封包會被丟棄

#### 🔴 Circuit Switching (電路交換)

- 來源到目的地之間**保留專屬資源**
- 不共享 → 效能保證 (guaranteed)
- 電路閒置時不會被他人使用 → 浪費
- 兩種多工方式：
  - **FDM (Frequency Division Multiplexing)**：分頻
  - **TDM (Time Division Multiplexing)**：分時

#### 📊 兩者比較

| 項目 | Packet Switching | Circuit Switching |
|------|------------------|-------------------|
| 資源分配 | 隨需共享 | 預先保留 |
| 適用場景 | 突發性 (bursty) 資料 | 傳統電話網路 |
| 效率 | 高（資源共享） | 低（閒置浪費） |
| 缺點 | 可能壅塞、封包遺失 | 浪費資源 |

**範例**:1 Gbps 連結，每位使用者 100 Mbps（10% 時間活躍）
- Circuit Switching：只能支援 **10 個**使用者
- Packet Switching：可支援 **35 個**使用者，10 人以上同時活躍機率 < 0.0004

### Internet 結構：Network of Networks

演進過程：
1. 直接互連 → O(N²) 連線數，不可行 ❌
2. 連到單一 global ISP → 但會有競爭者出現
3. 多個 ISP 透過 **IXP (Internet Exchange Point)** 互連
4. 出現 **Regional ISPs** 連接 access nets
5. **Content Provider Networks**（Google、Microsoft、Akamai）自建網路把內容拉近使用者

**最終結構**：中心是少數 well-connected 的大型網路
- **Tier-1 ISPs**：Level 3、Sprint、AT&T、NTT
- **Content Provider Networks**：Google、Facebook

---

## 五、效能：Loss、Delay、Throughput

### 封包延遲的四個來源

```
d_nodal = d_proc + d_queue + d_trans + d_prop
```

| 延遲類型 | 符號 | 說明 | 公式 |
|---------|------|------|------|
| **處理延遲** | d_proc | 檢查 bit 錯誤、決定輸出 link | 通常 < microseconds |
| **排隊延遲** | d_queue | 在輸出 link 等待傳送 | 取決於壅塞程度 |
| **傳輸延遲** | d_trans | 把封包推進 link 的時間 | **L / R** |
| **傳播延遲** | d_prop | 訊號在實體介質上行進時間 | **d / s** (s ≈ 2×10⁸ m/s) |

> ⚠️ **d_trans 和 d_prop 是非常不同的概念**：
> - d_trans 像「把所有人擠進電梯」
> - d_prop 像「電梯爬升的時間」

### 排隊延遲與流量強度 (Traffic Intensity)

```
Traffic Intensity = (L × a) / R
```

- a = 封包平均到達率
- L = 封包長度
- R = 連結頻寬

| La/R 值 | 結果 |
|---------|------|
| ~ 0 | 平均排隊延遲很小 |
| → 1 | 平均排隊延遲很大 |
| > 1 | 流入超過可服務量 → **延遲趨近無限大** |

### Packet Loss 封包遺失

- Router buffer 容量有限
- Buffer 滿了，新到達封包會被丟棄
- 遺失封包可能由前一節點、來源端重送，或不重送

### Throughput 吞吐量

> **Rate (bits/time unit) at which bits are being sent from sender to receiver**

- **Instantaneous (瞬時)**：某一時刻的速率
- **Average (平均)**：較長時間的平均速率

**Bottleneck Link (瓶頸連結)**：限制 end-to-end 吞吐量的那段連結

```
End-end throughput = min(R_s, R_c, R/N)
```

實務上 R_s 或 R_c 通常是瓶頸（access network 限制）。

### Traceroute 工具

- 量測 source → 沿路 router 的延遲
- 對每個 i：送 3 個封包，TTL = i，router 會回傳，量測往返時間
- `*` 代表無回應

---

## 六、網路安全 (Security)

### 為什麼安全很重要？

> Internet 原始設計**沒有把安全當作首要考量**：「一群互相信任的使用者連到透明的網路」😊
> 現在的設計者只能「亡羊補牢」，所有層級都需考慮安全。

### 三大攻擊類型

**1. Packet Sniffing (封包竊聽)**
- 在廣播媒介（共享 Ethernet、無線）上，網卡進入 **promiscuous mode** 讀取所有經過的封包
- 工具：Wireshark（合法用途的封包分析器）

**2. IP Spoofing (假冒身份)**
- 注入封包並偽造來源 IP 位址
- 接收端誤以為封包來自合法來源

**3. Denial of Service (DoS) 阻斷服務攻擊**
1. 選定目標
2. 入侵網路上多台主機（**botnet** 殭屍網路）
3. 從被入侵的主機對目標發送大量假流量
4. 合法使用者無法存取資源

### 防禦手段

| 手段 | 說明 |
|------|------|
| **Authentication** | 證明身份（如 SIM 卡的硬體識別） |
| **Confidentiality** | 透過加密保護內容 |
| **Integrity checks** | 數位簽章防止/偵測竄改 |
| **Access restrictions** | 密碼保護的 VPN |
| **Firewalls** | 過濾進入流量、防禦 DoS |

---

## 七、Protocol Layers 協定分層 ⭐

### 為什麼要分層？

- 明確結構便於識別系統各部分關係
- **模組化**便於維護與更新
- 某一層的服務實作變更，不影響其他層

### 機場類比 🛫

| 層 | 動作 |
|----|------|
| Ticketing | 購票 / 抱怨 |
| Baggage | 託運 / 提領 |
| Gate | 登機 / 下機 |
| Runway | 起飛 / 降落 |
| Airplane routing | 飛行路線 |

### 🌐 Internet Protocol Stack (五層模型)

```
┌──────────────┐
│  Application │  HTTP, IMAP, SMTP, DNS    ← 支援網路應用
├──────────────┤
│  Transport   │  TCP, UDP                 ← 行程對行程的資料傳輸
├──────────────┤
│  Network     │  IP, routing protocols    ← 路由 datagram
├──────────────┤
│  Link        │  Ethernet, 802.11, PPP    ← 鄰近節點間傳輸
├──────────────┤
│  Physical    │  bits "on the wire"       ← 實體位元
└──────────────┘
```

### 🌍 OSI 七層模型 (補充)

相較於 Internet 五層，OSI 多了兩層：
- **Presentation**：資料解讀（加密、壓縮、編碼轉換）
- **Session**：同步、檢查點、復原

Internet stack 把這些功能交由 application 自行實作。

### Encapsulation 封裝 🪆

像俄羅斯娃娃 (Matryoshka dolls) 一樣層層包裝：

| 層 | 資料單位 | 加上的 Header |
|----|---------|---------------|
| Application | **Message (M)** | — |
| Transport | **Segment** | + H_t |
| Network | **Datagram** | + H_n |
| Link | **Frame** | + H_l |

**封裝流程**：
```
M
   ↓ Transport
[H_t | M]
   ↓ Network
[H_n | H_t | M]
   ↓ Link
[H_l | H_n | H_t | M]
   ↓ Physical
bits on the wire
```

接收端則反向**解封裝 (decapsulation)**，逐層剝除 header。

---

## 八、Internet 歷史 📜

### 🟢 1961-1972：早期封包交換原理
- **1961**：Kleinrock 用排隊理論證明 packet switching 效能
- **1964**：Baran 提出軍用網路的封包交換
- **1967**：ARPAnet 概念由 ARPA 提出
- **1969**：第一個 ARPAnet 節點上線
- **1972**：ARPAnet 公開展示、NCP 第一個 host-host 協定、第一個 email、ARPAnet 達 15 節點

### 🟡 1972-1980：互連與專屬網路
- **1970**：ALOHAnet（夏威夷衛星網路）
- **1974**：Cerf 和 Kahn 提出互連網路架構
  - ⭐ **奠定今日 Internet 架構的原則**：
    - Minimalism、autonomy
    - Best-effort service model
    - Stateless routing
    - Decentralized control
- **1976**：Xerox PARC 發明 Ethernet

### 🟠 1980-1990：新協定、網路擴張
- **1982**：SMTP email 協定
- **1983**：部署 TCP/IP、DNS 定義
- **1985**：FTP 協定
- **1988**：TCP congestion control
- 達 100,000 hosts

### 🔴 1990-2000s：商業化與 Web
- **1991**：NSF 解除商業使用限制
- **1990s 初**：Tim Berners-Lee 發明 HTML、HTTP（Web 誕生）
- **1994**：Mosaic 瀏覽器 → Netscape
- 即時通訊、P2P 檔案分享、網路安全興起

### 🟣 2005-現在：規模、SDN、行動、雲端
- 寬頻家用接取積極部署 (10-100s Mbps)
- **2008**：軟體定義網路 (SDN)
- 4G/5G、WiFi 普及
- 服務商 (Google、FB、MS) 自建網路
- 企業上雲 (AWS、Azure)
- **2017**：行動裝置上網數量超過固定裝置
- **2023**：約 **150 億**裝置連到 Internet

---

## 🎯 章節重點摘要

| 主題 | 核心概念 |
|------|---------|
| **Internet 是什麼** | 「網路的網路」+ 提供服務的基礎建設 |
| **Protocol** | 訊息格式、順序、動作的規範 |
| **Network Edge** | Hosts + Access Networks（Cable/DSL/WiFi/4G/5G） |
| **Network Core** | Router 網狀互連、Packet vs Circuit Switching |
| **Performance** | 四種延遲、Throughput 受 bottleneck 限制 |
| **Security** | Sniffing、Spoofing、DoS 三大威脅 |
| **Layering** | 五層架構 + Encapsulation |

---

## 📚 教材來源

Computer Networking: A Top-Down Approach (9th edition), Kurose & Ross, Pearson, 2025

---

> ✍️ 持續更新中，歡迎指正與補充！
