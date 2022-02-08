# Minecraft伺服器腳本

## 如何使用？
### Bash檔案
1. 複製git repository到任何你想要的地方(需要安裝git)：  
```
git clone https://github.com/kent010341/mcserver-script.git
```

2. 複製(或移動)你想要的腳本到server資料夾(內有server.jar的)。範例命令：  
```
cp ./basic/start-server ~/mcserver/server/start-server
```

3. 執行腳本。範例命令：
```
./start-server
```

### .bat檔案
1. 複製git repository到任何你想要的地方(需要安裝git)：   
```
git clone https://github.com/kent010341/mcserver-script.git
```

2. 複製(或移動)你想要的腳本到server資料夾(內有server.jar的)。  

3. 點兩下腳本執行。

---

## 使用方法
### sh/
* command-creator
```
./command-creator
```
在 `/usr/local/bin` 建立一個 symbolic link 與 `sh/source/mcserver` 連結。

* get-server-file
```
./get-server-file [選項]
    --version <版本>, -v <版本>
        伺服器版本
    --path <路徑>, -p <路徑>
        server.jar的路徑
```
取得對應版本的server.jar。目前支援版本1.7\~1.18的最新版本。  
預設使用「latest」作為版本參數。(「latest」存放於`source/version-hash.txt`，是手動更改的)  

* install-requirements
```
[sudo] ./install-requirements [--noscreen, -ns]
```
確認Java與screen是否安裝，若未安裝則自動進行安裝。在指令末端加上`--noscreen` (可用縮寫`-ns`)來跳過確認screen的步驟。  
此腳本預設安裝OpenJDK 17 (JRE)。

> Java和Screen的安裝步驟需要root權限，故建議使用`sudo`

* fast-build
```
[sudo] ./fast-build [選項]
    --memory <記憶體>, -m <記憶體>
        伺服器使用的RAM (單位：GB)
    --version <版本>, -v <版本>
        伺服器版本
    --path <路徑>, -p <路徑>
        server.jar的路徑
    --enable-command-block, -ecb   
        設定server.properties允許使用指令方塊
    --difficulty <difficulty>, -d <difficulty> 
        設定server.properties的預設困難度，僅可使用hard, normal, easy或peace
    --seed <seed>, -s <seed>
        設定server.properties的地圖種子碼
```
執行以下步驟： 
1. 確認Java安裝
2. 確認screen安裝
3. 下載server.jar
4. 建立一個分離(detached)的screen session (名稱：mc)
5. 在screen session mc中啟動Minecraft伺服器
6. 編輯eula.txt和server.properties
7. 再次啟動伺服器

> 在第4 ~ 6行變更預設值 (記憶體 memory, server.jar 檔案名稱 filename, 版本 version)  
> Java和Screen的安裝步驟需要root權限，故建議使用`sudo`

* replace-variables
```
./replace-variables [選項]
    --memory <記憶體>, -m <記憶體>
        伺服器使用的RAM (單位：GB)
    --filename <檔案名稱>, -f <檔案名稱>
        伺服器啟動檔檔案名稱
    --version <版本>, -v <版本>
        伺服器版本
```
變更所有檔案中的相關變數。  

### sh/basic/ 
* start-server
```
./start-server [選項]
    --memory <記憶體>, -m <記憶體>
        伺服器使用的RAM (單位：GB)
    --filename <檔案名稱>, -f <檔案名稱>
        伺服器啟動檔檔案名稱
    --path <路徑>, -p <路徑>
        server.jar的路徑
```  
啟動伺服器。預設使用2GB記憶體以及用「server.jar」作為伺服器啟動檔的檔案名稱。  
> 如果你想變更預設的記憶體，修改腳本中的**default_memory**數值即可(在第4行)。  

* backup
```
./backup
```  
執行備份。
> * 如果沒有「backup」資料夾會自動建立。  
> * 這個腳本會複製world資料夾到backup資料夾內，並以當前日期重新命名。   

### sh/screen/
* screen-start-server
```
./screen-start-server [選項]
    --memory <記憶體>, -m <記憶體>
        伺服器使用的RAM (單位：GB)
    --filename <檔案名稱>, -f <檔案名稱>
        伺服器啟動檔檔案名稱
    --path <路徑>, -p <路徑>
        server.jar的路徑
```
以一個分離(detached)的screen session (名稱：mc)啟動伺服器。預設使用2GB記憶體以及用「server.jar」作為伺服器啟動檔的檔案名稱。  
> * 如果你想變更預設的記憶體，修改腳本中的**default_memory**數值即可(在第4行)。  
> * 如果你想操作分離的screen session，使用命令「screen -r mc」進入，要離開的話按下Ctrl + A + D即可。

* screen-backup
```
./screen-backup [選項]
    --memory <記憶體>, -m <記憶體>
        伺服器使用的RAM (單位：GB)
    --filename <檔案名稱>, -f <檔案名稱>
        伺服器啟動檔檔案名稱
    --path <路徑>, -p <路徑>
        server.jar的路徑
```
停止名為mc的分離(detached)screen session中的伺服器，並執行備份。  
備份完成後會重啟伺服器。預設使用2GB記憶體以及用「server.jar」作為伺服器啟動檔的檔案名稱來重啟伺服器。  
> * 如果你想變更預設的記憶體，修改腳本中的**default_memory**數值即可(在第4行)。 
> * 如果沒有「backup」資料夾會自動建立。  
> * 這個腳本會複製world資料夾到backup資料夾內，並以當前日期重新命名。  

### bat/start-server.bat
啟動伺服器

### bat/backup-server.bat
執行備份。
> * 如果沒有「backup」資料夾會自動建立。  
> * 這個腳本會複製world資料夾到backup資料夾內，並以當前日期重新命名。 

---

## mcserver command

> 先使用 `command-creator` 以建立 symbolic link

### mcserver start
* 選項
``` 
--memory <記憶體>, -m <記憶體>
    伺服器使用的RAM (單位：GB)
--filename <檔案名稱>, -f <檔案名稱>
    伺服器啟動檔檔案名稱
```

啟動 Minecraft 伺服器

### mcserver stop

停止 Minecraft server

### mcserver screen

回到 screen session 'mc' 內

### mcserver update
```
mcserver update [版本]
```

以指定的版本更新 server.jar 檔案 (預設：最新版本)

### mcserver fast-build
```
mcserver fast-build [版本]
```

在一個全新的伺服器快速建置 (預設：最新版本)

### mcserver env
```
mcserver env [版本]
```

檢查 JRE 和 screen 的安裝 (預設：最新版本)
