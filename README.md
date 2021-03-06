# Script for Minecraft Server

## How to use?
### Bash files (for Unix OS)
1. Clone this repository to anywhere you want (git is required):  
```
git clone https://github.com/kent010341/mcserver-script.git
```

2. Copy (or move) the script you want to your server folder. e.g.,  
```
cp ./basic/start-server ~/mcserver/server/start-server
```

3. Execute it. e.g.,
```
./start-server
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
* get-server-file
```
./get-server-file [option]
    --version <version>, -v <version>
        Minecraft server version
    --path <path>, -p <path>
        The path of server.jar
```
Get server.jar by version. Currently support the latest version from 1.7 to 1.18.  
Defaultly use 'latest' as version. ('latest' is manually editted in `source/version-hash.txt`.)

* install-requirements
```
[sudo] ./install-requirements [--noscreen, -ns]
```
Check if Java and screen are installed. If not, the installation process will automatically start. Add `--noscreen` (abbreviation: `-ns`) to ignore checking screen.  
By default, this script will install OpenJDK 17 (JRE).

> The Java and Screen installation process requires root permission, so using `sudo` is recommended.

* fast-build
```
[sudo] ./fast-build [options]
    --memory <memory>, -m <memory>
        RAM used for the server (in GB)
    --version <version>, -v <version>
        Minecraft server version
    --path <path>, -p <path>
        The path of server.jar
    --enable-command-block, -ecb   
        Enable command block in server.properties
    --difficulty <difficulty>, -d <difficulty> 
        Set difficulty in server.properties, available value: hard, normal, easy, peace
    --seed <seed>, -s <seed>
        Set seed in server.properties
```
Process steps:  
1. Check Java installation
2. Check screen installation
3. Download server.jar
4. Create a detached screen session called 'mc'
5. Start Minecraft server in detached screen sesson 'mc'
6. Edit eula.txt, server.properties
7. Start server again

> Change default value (memory, server.jar filename, version) at line 4 ~ 6.  
> The Java and Screen installation process requires root permission, so using `sudo` is recommended.

* replace-variables
```
./replace-variables [options]
    --memory <memory>, -m <memory>
        RAM used for the server (in GB)
    --filename <file name>, -f <file name>
        The file name of server.jar
    --version <version>, -v <version>
        Minecraft server version
```
Change all relative variables in this repository.  

### sh/basic/
* start-server
```
./start-server [options]
    --memory <memory>, -m <memory>
        RAM used for the server (in GB)
    --filename <file name>, -f <file name>
        The file name of server.jar
    --path <path>, -p <path>
        The path of server.jar
```  
Start the server. Defaulty use 2GB memory and 'server.jar' as the filename of server.jar.  
> To edit the default memory used, change the value of variable **default_memory** at line 4.

* backup
```
./backup
```  
Proceed a backup process.  
> * Create a folder called 'backup' if not exist.  
> * This script will copy the 'world' folder into the 'backup' folder, and rename it with current date.  

### sh/screen/
* screen-start-server
```
./screen-start-server [options]
    --memory <memory>, -m <memory>
        RAM used for the server (in GB)
    --filename <file name>, -f <file name>
        The file name of server.jar
    --path <path>, -p <path>
        The path of server.jar
```
Start the server with a detached screen 'mc'. Defaulty use 2GB memory and 'server.jar' as the filename of server.jar.  
> * To edit the default memory used, change the value of variable **default_memory** at line 4.  
> * To get into the detached screen, use command 'screen -r mc' and use Ctrl + A + D to leave it.

* screen-backup
```
./screen-backup [options]
    --memory <memory>, -m <memory>
        RAM used for the server (in GB)
    --filename <file name>, -f <file name>
        The file name of server.jar
    --path <path>, -p <path>
        The path of server.jar
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
