# BashFTP
LINUX/MACOS capable, the script monitors for changes, then uploads the file through FTP, then logs it and after removes itself. Able to keep running, the logging feature will delete any of the same filename, commits welcome.   
![Screenshot 2024-03-06 at 23 46 39](https://github.com/megasyntax/BashFTP/assets/102532457/900a41e1-7059-4549-b73c-daed893ef9e1)

  
# How To Install  
On Linux/MacOS, visit brew.sh once installed,    
Use terminal: ```brew install fswatch```, ```brew install lftp```  
Modify ```BashFTP.sh```: set local_dir, log_file with your name in filepaths  
Modify your FTP details within the ftp file:
'''SERVER="192.168.68.118:2525"   
USERNAME="username"  
PASSWORD="password"  '''
Download Pre-Release: [BashFTP Script](https://github.com/megasyntax/BashFTP/blob/main/Bash_FTP.sh)  
Execute: ```./Bash_FTP.sh``` in Terminal  

# More info...
using an ftp connection you are able to save storage space by automating these tedious steps. 
follow the steps to install.


