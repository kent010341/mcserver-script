# Script for Minecraft Server

## How to use?
### .sh files
1. Clone this repository to anywhere you want (git is required):  
```
git clone https://github.com/kent010341/mcserver-script.git
```

2. Copy (or move) the script you want to your server folder. e.g.,  
```
cp ./basic/start-server.sh ~/mcserver/server/start-server.sh
```

3. Execute it. e.g.,
```
./start-server.sh
```

### .bat files
1. Clone this repository to anywhere you want (git is required):  
```
git clone https://github.com/kent010341/mcserver-script.git
```

2. Copy (or move) the script you want to your server folder.

3. Double click to execute it.

---

## Usage
### sh/
* get-server-file.sh
```
./get-server-file.sh [version]
```
Get server.jar by version. Currently support 1.13.2, 1.14.4, 1.15.2, 1.16.5, 1.17, 1.17.1.  
Defaultly use 'latest' as version. ('latest' is manually edit.)

### sh/basic/
* check-java.sh  
```
./check-java.sh
```  
This script will check if you have already installed Java. If not, it will automatically install the OpenJDK 16.

* start-server.sh
```
./start-server.sh [memory] [server.jar filename]
```  
Start the server. Defaulty use 2GB memory and 'server.jar' as the filename of server.jar.  
> if you want to edit the default memory used, change the value of variable **default_memory** at line 4.

* backup.sh
```
./backup.sh
```  
Proceed a backup process.  
> Create a folder called 'backup' if not exist.  
> This script will copy the 'world' folder into the 'backup' folder, and rename it with current date.  

### sh/screen/
* screen-start-server.sh
```
./screen-start-server.sh [memory] [server.jar filename]
```
Start the server with a detached screen 'mc'. Defaulty use 2GB memory and 'server.jar' as the filename of server.jar.  
> if you want to edit the default memory used, change the value of variable **default_memory** at line 4.

* screen-backup.sh
```
./screen-backup.sh
```
Stop the server inside the detached screen 'mc' and proceed a backup process.  
After backup, the server will automatically restart.
> Create a folder called 'backup' if not exist.  
> This script will copy the 'world' folder into the 'backup' folder, and rename it with current date.  

### bat/start-server.bat
Start server.

### bat/backup-server.bat
Proceed a backup process.  
> Create a folder called 'backup' if not exist.  
> This script will copy the 'world' folder into the 'backup' folder, and rename it with current date. 
