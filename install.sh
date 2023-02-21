#!/bin/bash
## PARAMETERS ##
source ./env.sh
## END PARAMETERS ##
#Already in app_dir and already appuser 
mkdir .virtualenvs
python -m venv "./.virtualenvs/${env_name}"
source "./.virtualenvs/${env_name}/bin/activate"
python -m pip install -r requirements.txt
#Create cron
crontab_line="@reboot ${PWD}/${run_script}"
(crontab -l 2>/dev/null; echo "$crontab_line")| crontab -
#create run file 
echo "#!/bin/bash" > "$run_script"
echo "cd ${PWD}" >> "$run_script"
echo "source ./.virtualenvs/${env_name}/bin/activate" >> "$run_script"
echo "nohup python ./${site_name}/manage.py runserver 0.0.0.0:${port} &" >> "$run_script"
#Installed now run app 
chmod +x $run_script 
./$run_script 