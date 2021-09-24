# Script for Minecraft Server

## How to use?
### .sh files (for Unix OS)
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

### .bat files (for Windows OS)
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
Get server.jar by version. Currently support 1.7.10, 1.12.2, 1.13.2, 1.14.4, 1.15.2, 1.16.5, 1.17, 1.17.1.  
Defaultly use 'latest' as version. ('latest' is manually edit.)

* install-requirements.sh
```
./install-requirements.sh [--noscreen]
```
Check if Java and screen are installed. If not, the installation process will automatically start. Add `--noscreen` to ignore checking screen.  
By default, this script will install OpenJDK 16.

* fast-build.sh
```
./fast-build.sh
```
Process steps:  
1. Check Java installation
2. Check screen installation
3. Download server.jar
4. Create a detached screen session called 'mc'
5. Create eula.txt
6. Start Minecraft server in detached screen sesson 'mc'

> Change default value (memory, server.jar filename, version) at line 4 ~ 6.

* replace-variables.sh
```
./replace-variables.sh
```
Change all relative variables in this repository.  
Edit the value of `default_memory`, `default_filename`, `default_version` to make the change.

> `"default"` won't change anything.

### sh/basic/
* start-server.sh
```
./start-server.sh [memory] [server.jar filename]
```  
Start the server. Defaulty use 2GB memory and 'server.jar' as the filename of server.jar.  
> To edit the default memory used, change the value of variable **default_memory** at line 4.

* backup.sh
```
./backup.sh
```  
Proceed a backup process.  
> * Create a folder called 'backup' if not exist.  
> * This script will copy the 'world' folder into the 'backup' folder, and rename it with current date.  

### sh/screen/
* screen-start-server.sh
```
./screen-start-server.sh [options]
    --memeory <memory>    RAM used for the server (in GB)
    --filename <file name>    The file name of server.jar
```
Start the server with a detached screen 'mc'. Defaulty use 2GB memory and 'server.jar' as the filename of server.jar.  
> * To edit the default memory used, change the value of variable **default_memory** at line 4.  
> * To get into the detached screen, use command 'screen -r mc' and use Ctrl + A + D to leave it.

* screen-backup.sh
```
./screen-backup.sh [options]
    --memeory <memory>    RAM used for the server (in GB)
    --filename <file name>    The file name of server.jar
```
Stop the server inside the detached screen 'mc' and proceed a backup process.   
After backup, the server will automatically restart. Defaulty use 2GB memory and 'server.jar' as the filename of server.jar to start the server. 
> * To edit the default memory used, change the value of variable **default_memory** at line 4.  
> * Create a folder called 'backup' if not exist.  
> * This script will copy the 'world' folder into the 'backup' folder, and rename it with current date.  

### bat/start-server.bat
Start server.

### bat/backup-server.bat
Proceed a backup process.  
> * Create a folder called 'backup' if not exist.  
> * This script will copy the 'world' folder into the 'backup' folder, and rename it with current date. 
