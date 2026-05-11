import pygame as pg
import random

#pygame初始化
pg.init()

# --- 字型 ---
def get_font(size):
    for f in ['microsoftjhenghei', 'simhei', 'stheitirelight']:
        if f in pg.font.get_fonts():
            return pg.font.SysFont(f, size)
    return pg.font.SysFont(None, size)


# GAME UI
FONT_UI = get_font(32)
col, row = 15, 15
inter = 40
width, height = (col + 2) * inter, (row + 2) * inter
# 產生視窗
screen = pg.display.set_mode([width, height])
# 設定遊戲標題
pg.display.set_caption("踩地雷")

# 遊戲邏輯
# 對每個區塊設定默認值: NOT_CLICK = -1
# 並對地雷區塊設定地雷值 -99
NOT_CLICK = -1
BOMB = -99
BOMB_COUNT = 10
game_board = [[NOT_CLICK] * col for i in range(row)]
# 埋地雷
# 用set()解決, 亂數產生重複位置的地雷
bombs = set()
while True:
    x = random.randint(0, col - 1)
    y = random.randint(0, row - 1)
    # if BOMB_COUNT > col * row:
    #     BOMB_COUNT = col * row
    #     print('地雷太多, 設定成目前最大值')
    bombs.add((x, y))
    game_board[x][y] = BOMB
    if len(bombs) == BOMB_COUNT:
        break

# 儲存每個位置的中心座標
game_board_center = [[None] * col for i in range(row)]
for i in range(row):
    for j in range(col):
        # 每個欄位的左側位置 + inter / 2
        x, y = (j+1) * inter + inter / 2, (i+1) * inter + inter / 2
        game_board_center[i][j] = (x, y)

def draw():
    # 準備第一個圖層
    bg = pg.Surface(screen.get_size())
    # 把畫布填滿某個顏色
    bg.fill([199, 167, 82])

    # 15*15棋盤 畫線
    # 1. 畫棋盤線: 橫線有16條(15+1), 直線16條(15+1)
    # 2. 畫地雷
    # 3. 點擊的時候畫出數字

    # test: 設1-8個數字 (附近有幾個地雷)
    for i in range(row):
        for j in range(col):
            n = game_board[i][j]
            if n == BOMB:
                x = (j + 1) * inter
                y = (i + 1) * inter
                x_center, y_center = game_board_center[i][j]
                # [START] 2. 畫地雷
                # pygame.draw.rect(畫布, 顏色, [x坐標, y坐標, 寬度, 高度], 線寬)
                # 顯示地雷位置
                pg.draw.rect(bg, [100, 0, 0], [x, y, inter, inter], 0)
            elif n == NOT_CLICK:
                pass
            else:
                x = (j + 1) * inter
                y = (i + 1) * inter
                x_center, y_center = game_board_center[i][j]
                # [START] 3. 點擊的時候畫出數字
                pg.draw.rect(bg, [255, 255, 255], [x, y, inter, inter], 0)
                # 字體(字, 平滑話, 顏色)
                t = FONT_UI.render(str(n), 1, [0, 0, 0])
                # 背景(bg)上面疊上t, 字體(center) -> get_rect -> (左上x, 左上y, 寬, 高)
                bg.blit(t, t.get_rect(center=[x_center, y_center]))

    # [START] 1. 畫棋盤線
    # 畫橫線 row
    line_color = [0, 0, 0]
    for i in range(row+1):
        pg.draw.line(bg,
                     line_color,
                     [inter, inter * (i+1)],
                     [width - inter, inter * (i+1)],
                     1)
    # 畫直線 col
    for i in range(col+1):
        pg.draw.line(bg,
                     line_color,
                     [inter * (i+1), inter],
                     [inter * (i+1), height - inter],
                     1)

    # 你要把圖層放到上一層
    screen.blit(bg, [0, 0])
    # 對畫面進行更新(才會真的秀出來)
    pg.display.update()

# 判斷附近九宮格內有幾個炸彈
def get_bomb_count(game_board, mini, minj):
    bomb_count = 0
    for i in [-1, 0, 1]:
        for j in [-1, 0, 1]:
            reali, realj = mini + i, minj + j
            if 0 <= reali < row and 0 <= realj < col:
                if game_board[reali][realj] == BOMB:
                    bomb_count = bomb_count + 1
    game_board[mini][minj] = bomb_count

    # 自動展開
    if bomb_count == 0:
        # 左邊一格自動展開
        ni, nj = mini, minj - 1
        if 0 <= ni < row and 0 <= nj < col and game_board[ni][nj] == NOT_CLICK:
            get_bomb_count(game_board, ni, nj)
        # 右邊一格自動展開
        ni, nj = mini, minj +1
        if 0 <= ni < row and 0 <= nj < col and game_board[ni][nj] == NOT_CLICK:
            get_bomb_count(game_board, ni, nj)
        # 上面一格自動展開
        ni, nj = mini -1 , minj
        if 0 <= ni < row and 0 <= nj < col and game_board[ni][nj] == NOT_CLICK:
            get_bomb_count(game_board, ni, nj)
        # 下面一格自動展開
        ni, nj = mini + 1, minj
        if 0 <= ni < row and 0 <= nj < col and game_board[ni][nj] == NOT_CLICK:
            get_bomb_count(game_board, ni, nj)

def check_win(game_board):
    for i in range(row):
        for j in range(col):
            if game_board[i][j] == NOT_CLICK:
                return False
    return True

draw()
# 建立一個永不結束的迴圈(遊戲才不會結束)
running = True
while running:
    # 收取你的遊戲任何事件(滑鼠點擊/鍵盤按鈕...)
    for event in pg.event.get():
        # 偵測滑鼠點擊以後放掉的動作
        if event.type == pg.MOUSEBUTTONUP:
            # 點擊的位置與哪個中心點位置最近
            # 1. 需要一個儲存媒介, 告訴我點下去的位置到底是安全還是地雷
            # 2. 需要一個近似方式, 來把我點的位置近似到某一個框框
            # (看我點的位置跟哪個框的中心點最近): 為了方便, 我要順便把每一個框的中心點位置儲存起來
            minv, mini, minj = float('inf'), -1, -1
            xm, ym = pg.mouse.get_pos()
            for i in range(row):
                for j in range(col):
                    # 拿到中心點的位置
                    xc, yc = game_board_center[i][j]
                    # 把按的位置和每個中心算距離
                    d = abs(xm - xc) + abs(ym - yc)
                    if d < minv:
                        minv, mini, minj = d, i, j
            print('滑鼠位置: ', xm, ym)
            print('中心位置: ', mini, minj)
            print('最近的欄位中心點: ', game_board_center[mini][minj])
            if game_board[mini][minj] == BOMB:
                print('遊戲結束')
                # running = False
            elif game_board[mini][minj] == NOT_CLICK:
                get_bomb_count(game_board, mini, minj)
            if check_win(game_board):
                print('你贏了')
            draw()
        # 如果收到的事件是按x
        if event.type == pg.QUIT:
            # 迴圈就會變成while False
            running = False

pg.quit()