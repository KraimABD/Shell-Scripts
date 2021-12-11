 
#!/bin/bash

# Enforce the root excution

if [[ "${UID}" -ne 0 ]]
then 
	echo "You must be the root or use sudo!" >&2
	exit 1
fi

# Make sure there a supply at least of one argument.
if [[ "${#}" -lt 1 ]] 
then
	echo "Usage: ${0} USER_NAME [COMMENT]..." >&2
 	exit 1
fi

# The first arguemnt as the username and others are Arguments
USER_NAME="${1}"
shift
COMMENT="${@}"

#Generate a Strong Password

S='!?;/.*-+@^\`|#~&[{$µ%ABCDEFGHIJKLMNOPQRSTUVWXYZ}]'
SPECIAL_CHARACTER=$(echo "${S}" | fold -w1 | shuf | head -c1)
SPECIAL_CHARACTE3=$(echo "${S}" | fold -w1 | shuf | head -c1)
SPECIAL_CHARACTER2=$(echo "${S}" | fold -w1 | shuf | head -c1)
SPECIAL_CHARACTER1=$(echo "${S}" | fold -w1 | shuf | head -c1)
PASSWORD=$(date +%sN${RANDOM}${RANDOM} | sha256sum | head -c 48)

PASSWOR=${SPECIAL_CHARACTER}${SPECIAL_CHARACTE3}${PASSWORD}${SPECIAL_CHARACTER1}${SPECIAL_CHARACTER2}

# Ready to create the account
useradd -c "${COMMENT}" -m "${USER_NAME}" &> /dev/null

# Check if the useradd command succeeded.
if [[ ${?} -ne 0 ]]
then 
	echo "Something Wrong Happend, or the Username entred is already exist!!" >&2
	exit 1
fi

# Password set
echo "${PASSWOR}" | passwd --stdin ${USER_NAME} &> /dev/null

# Check if the Password command succeeded ! 
if [[ "${?}" -ne 0 ]]
then 
	echo "Something went wrong with setting the Pasword, Try again later! Bye Bye." 1>&2
	exit 1
fi

# Force password change on the first login.
passwd -e ${USER_NAME} &> /dev/null 

# Display the informations 
echo  >> .Users.txt
echo "Username:${USER_NAME}" >> .Users.txt
echo  >> .Users.txt
echo "Comment:${COMMENT}"  >> .Users.txt
echo  >> .Users.txt
echo "Password:${PASSWOR}"  >> .Users.txt
echo   >> .Users.txt
echo "Host:${HOSTNAME}"  >> .Users.txt
echo  >> .Users.txt
echo "****************************************************************************************************************" >> .Users.txt
echo  >> .Users.txt
cat .Users.txt





exit 0
