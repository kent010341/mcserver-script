# Minecraft伺服器腳本

## 如何使用？
### .sh檔案
1. 複製git repository到任何你想要的地方(需要安裝git)：  
```
git clone https://github.com/kent010341/mcserver-script.git
```

2. 複製(或移動)你想要的腳本到server資料夾(內有server.jar的)。範例命令：  
```
cp ./basic/start-server.sh ~/mcserver/server/start-server.sh
```

3. 執行腳本。範例命令：
```
./start-server.sh
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
* get-server-file.sh
```
./get-server-file.sh [版本]
```
取得對應版本的server.jar。目前支援版本1.13.2、1.14.4、1.15.2、1.16.5、1.17、1.17.1。  
預設使用「latest」作為版本參數。(「latest」是手動更改的)  

* install-requirements.sh
```
./install-requirements.sh [--noscreen]
```
確認Java與screen是否安裝，若未安裝則自動進行安裝。在指令末端加上`--noscreen`來跳過確認screen的步驟。  
此腳本預設安裝OpenJDK 16。

### sh/basic/ 
* start-server.sh
```
./start-server.sh [記憶體] [伺服器啟動檔檔案名稱]
```  
啟動伺服器。預設使用2GB記憶體以及用「server.jar」作為伺服器啟動檔的檔案名稱。  
> 如果你想變更預設的記憶體，修改腳本中的**default_memory**數值即可(在第4行)。  

* backup.sh
```
./backup.sh
```  
執行備份。
> * 如果沒有「backup」資料夾會自動建立。  
> * 這個腳本會複製world資料夾到backup資料夾內，並以當前日期重新命名。   

### sh/screen/
* screen-start-server.sh
```
./screen-start-server.sh [記憶體] [伺服器啟動檔檔案名稱]
```
以一個分離(detached)的screen session (名稱：mc)啟動伺服器。預設使用2GB記憶體以及用「server.jar」作為伺服器啟動檔的檔案名稱。  
> * 如果你想變更預設的記憶體，修改腳本中的**default_memory**數值即可(在第4行)。  
> * 如果你想操作分離的screen session，使用命令「screen -r mc」進入，要離開的話按下Ctrl + A + D即可。

* screen-backup.sh
```
./screen-backup.sh  [記憶體] [伺服器啟動檔檔案名稱]
```
停止名為mc的分離(detached)screen session中的伺服器，並執行備份。  
備份完成後會重啟伺服器。預設使用2GB記憶體以及用「server.jar」作為伺服器啟動檔的檔案名稱來重啟伺服器。  
> * 如果你想變更預設的記憶體，修改腳本中的**default_memory**數值即可(在第30行)。 
> * 如果沒有「backup」資料夾會自動建立。  
> * 這個腳本會複製world資料夾到backup資料夾內，並以當前日期重新命名。  

### bat/start-server.bat
啟動伺服器

### bat/backup-server.bat
執行備份。
> * 如果沒有「backup」資料夾會自動建立。  
> * 這個腳本會複製world資料夾到backup資料夾內，並以當前日期重新命名。 
